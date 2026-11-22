import Foundation

public actor TransmissionService: TorrentClientService {
    private var config: APIConfig
    private let session: URLSession
    private var sessionId: String? = nil
    private var tagCounter: Int = 1
    private var refreshSessionTask: Task<String, Error>?

    public init(config: APIConfig) {
        self.config = config
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 3.0
        sessionConfig.timeoutIntervalForResource = 6.0
        sessionConfig.waitsForConnectivity = false
        self.session = URLSession(configuration: sessionConfig)
    }

    public func updateConfig(_ newConfig: APIConfig) {
        self.config = newConfig
        self.sessionId = nil
        self.refreshSessionTask?.cancel()
        self.refreshSessionTask = nil
    }

    private func nextTag() -> Int {
        let tag = tagCounter
        tagCounter = (tagCounter &+ 1)
        return tag
    }

    // MARK: - Generic RPC Helper

    private struct RPCRequest<T: Encodable>: Encodable {
        let method: String
        let arguments: T?
        let tag: Int
    }

    private struct RPCResponse<T: Decodable>: Decodable {
        let result: String
        let arguments: T?
        let tag: Int?
    }

    private struct EmptyArgs: Codable, Sendable {}

    private func makeBaseURLRequest() throws -> URLRequest {
        guard let url = config.endpointURL(for: "") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("QBMenubar/1.3.2 (macOS)", forHTTPHeaderField: "User-Agent")

        if let sessionId = sessionId {
            request.setValue(sessionId, forHTTPHeaderField: "X-Transmission-Session-Id")
        }

        // Basic Authentication
        if !config.username.isEmpty || !config.password.isEmpty {
            let authString = "\(config.username):\(config.password)"
            if let authData = authString.data(using: .utf8) {
                let base64Auth = authData.base64EncodedString()
                request.setValue("Basic \(base64Auth)", forHTTPHeaderField: "Authorization")
            }
        }

        return request
    }

    private func resolveSessionId(staleSessionId: String?, candidateResponse: HTTPURLResponse?) async throws -> String {
        // 1. If another concurrent call already refreshed sessionId, reuse it immediately
        if let current = self.sessionId, current != staleSessionId {
            return current
        }

        // 2. If a refresh is already in progress, await its result
        if let inFlight = refreshSessionTask {
            return try await inFlight.value
        }

        // 3. If candidate 409 response provided the header, adopt it immediately
        if let newSessionId = candidateResponse?.value(forHTTPHeaderField: "X-Transmission-Session-Id"), !newSessionId.isEmpty {
            self.sessionId = newSessionId
            return newSessionId
        }

        // 4. Otherwise coalesce onto a single serialized handshake task
        let task = Task<String, Error> { [weak self] in
            guard let self = self else { throw URLError(.cancelled) }
            return try await self.performSessionHandshake()
        }
        self.refreshSessionTask = task
        do {
            let refreshed = try await task.value
            self.refreshSessionTask = nil
            return refreshed
        } catch {
            self.refreshSessionTask = nil
            throw error
        }
    }

    private func performSessionHandshake() async throws -> String {
        let req = try makeBaseURLRequest()
        let (_, response) = try await session.data(for: req)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        if let newId = httpResponse.value(forHTTPHeaderField: "X-Transmission-Session-Id"), !newId.isEmpty {
            self.sessionId = newId
            return newId
        }
        if httpResponse.statusCode == 200, let current = self.sessionId {
            return current
        }
        throw URLError(.cannotConnectToHost)
    }

    private func executeRPC<Args: Encodable, ResultArgs: Decodable>(
        method: String,
        arguments: Args?
    ) async throws -> ResultArgs {
        let tag = nextTag()
        let rpcReq = RPCRequest(method: method, arguments: arguments, tag: tag)
        let requestBody = try JSONEncoder().encode(rpcReq)

        var request = try makeBaseURLRequest()
        request.httpBody = requestBody
        let usedSessionId = self.sessionId

        var (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        // Handle Transmission 409 CSRF Session-Id Handshake
        if httpResponse.statusCode == 409 {
            let newSessionId = try await resolveSessionId(staleSessionId: usedSessionId, candidateResponse: httpResponse)
            request.setValue(newSessionId, forHTTPHeaderField: "X-Transmission-Session-Id")

            (data, response) = try await session.data(for: request)
            guard let retryResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            if retryResponse.statusCode == 401 {
                throw URLError(.userAuthenticationRequired)
            }
            guard retryResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
        } else if httpResponse.statusCode == 401 {
            throw URLError(.userAuthenticationRequired)
        } else if httpResponse.statusCode != 200 {
            throw URLError(.badServerResponse)
        }

        let rpcResponse = try JSONDecoder().decode(RPCResponse<ResultArgs>.self, from: data)
        guard rpcResponse.result == "success" else {
            throw NSError(
                domain: "TransmissionService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Transmission error: \(rpcResponse.result)"]
            )
        }

        if let resultArgs = rpcResponse.arguments {
            return resultArgs
        }

        // If decoding empty result arguments
        if let empty = EmptyArgs() as? ResultArgs {
            return empty
        }

        throw URLError(.cannotParseResponse)
    }

    // MARK: - Connection & Diagnostics

    private struct SessionGetFields: Encodable {
        let fields: [String]
    }

    private struct SessionGetResponse: Decodable {
        let version: String?
        let rpcVersion: Int?
        let downloadDir: String?
        let altSpeedEnabled: Bool?

        enum CodingKeys: String, CodingKey {
            case version
            case rpcVersion = "rpc-version"
            case downloadDir = "download-dir"
            case altSpeedEnabled = "alt-speed-enabled"
        }
    }

    public func testConnection() async throws -> (version: String, pingMs: Int) {
        let startTime = Date()
        let fields = SessionGetFields(fields: ["version", "rpc-version", "download-dir"])
        let resp: SessionGetResponse = try await executeRPC(method: "session-get", arguments: fields)
        let ping = Int(Date().timeIntervalSince(startTime) * 1000)
        let ver = resp.version ?? "Unknown"
        return ("Transmission \(ver)", ping)
    }

    public func login() async throws -> Bool {
        do {
            _ = try await testConnection()
            return true
        } catch {
            return false
        }
    }

    // MARK: - Transfer Info & Stats

    private struct SessionStatsResponse: Decodable {
        let downloadSpeed: Int64
        let uploadSpeed: Int64
        let cumulativeStats: CumulativeStats?

        enum CodingKeys: String, CodingKey {
            case downloadSpeed
            case uploadSpeed
            case cumulativeStats = "cumulative-stats"
        }

        struct CumulativeStats: Decodable {
            let downloadedBytes: Int64
            let uploadedBytes: Int64
        }
    }

    public func fetchTransferInfo() async throws -> TransferInfo {
        let resp: SessionStatsResponse = try await executeRPC(method: "session-stats", arguments: nil as String?)
        return TransferInfo(
            dlInfoSpeed: resp.downloadSpeed,
            upInfoSpeed: resp.uploadSpeed,
            dlInfoData: resp.cumulativeStats?.downloadedBytes ?? 0,
            upInfoData: resp.cumulativeStats?.uploadedBytes ?? 0,
            connectionStatus: "connected",
            dhtNodes: 0
        )
    }

    // MARK: - Speed Limits (Alt Speed / Turtle Mode)

    private struct SessionSetAltSpeed: Encodable {
        let altSpeedEnabled: Bool

        enum CodingKeys: String, CodingKey {
            case altSpeedEnabled = "alt-speed-enabled"
        }
    }

    public func fetchSpeedLimitsMode() async throws -> Bool {
        let fields = SessionGetFields(fields: ["alt-speed-enabled"])
        let resp: SessionGetResponse = try await executeRPC(method: "session-get", arguments: fields)
        return resp.altSpeedEnabled ?? false
    }

    public func toggleSpeedLimitsMode() async throws {
        let current = try await fetchSpeedLimitsMode()
        let setArgs = SessionSetAltSpeed(altSpeedEnabled: !current)
        let _: EmptyArgs = try await executeRPC(method: "session-set", arguments: setArgs)
    }

    // MARK: - Torrents Query

    private struct TorrentGetArgs: Encodable {
        let fields: [String]
        let ids: [String]?

        init(fields: [String], ids: [String]? = nil) {
            self.fields = fields
            self.ids = ids
        }
    }

    private struct TorrentListResponse: Decodable {
        let torrents: [TRTorrent]
    }

    private struct TRTorrent: Decodable {
        let id: Int
        let hashString: String
        let name: String
        let totalSize: Int64
        let percentDone: Double
        let rateDownload: Int64
        let rateUpload: Int64
        let eta: Int
        let status: Int
        let peersSendingToUs: Int?
        let peersGettingFromUs: Int?
        let uploadRatio: Double?
        let downloadedEver: Int64?
        let downloadDir: String?
        let addedDate: Int64?
        let leftUntilDone: Int64?
    }

    public func fetchTorrents(filter: String? = nil) async throws -> [Torrent] {
        let fields = TorrentGetArgs(fields: [
            "id",
            "name",
            "hashString",
            "totalSize",
            "percentDone",
            "rateDownload",
            "rateUpload",
            "eta",
            "status",
            "peersSendingToUs",
            "peersGettingFromUs",
            "uploadRatio",
            "downloadedEver",
            "downloadDir",
            "addedDate",
            "leftUntilDone"
        ])

        let resp: TorrentListResponse = try await executeRPC(method: "torrent-get", arguments: fields)

        let mapped: [Torrent] = resp.torrents.compactMap { tr in
            let state: String
            switch tr.status {
            case 0: // TR_STATUS_STOPPED
                if tr.percentDone >= 1.0 || (tr.leftUntilDone ?? 1) == 0 {
                    state = "pausedUP"
                } else {
                    state = "pausedDL"
                }
            case 1, 2: // TR_STATUS_CHECK_WAIT, TR_STATUS_CHECK
                state = tr.percentDone >= 1.0 ? "checkingUP" : "checkingDL"
            case 3: // TR_STATUS_DOWNLOAD_WAIT
                state = "queuedDL"
            case 4: // TR_STATUS_DOWNLOAD
                state = "downloading"
            case 5: // TR_STATUS_SEED_WAIT
                state = "queuedUP"
            case 6: // TR_STATUS_SEED
                state = "uploading"
            default:
                state = "unknown"
            }

            let completedBytes = tr.downloadedEver ?? Int64(Double(tr.totalSize) * tr.percentDone)

            return Torrent(
                hash: tr.hashString,
                name: tr.name,
                size: tr.totalSize,
                progress: tr.percentDone,
                dlspeed: tr.rateDownload,
                upspeed: tr.rateUpload,
                eta: tr.eta >= 0 ? tr.eta : -1,
                state: state,
                numSeeds: tr.peersSendingToUs ?? 0,
                numLeechs: tr.peersGettingFromUs ?? 0,
                ratio: tr.uploadRatio ?? 0.0,
                completed: completedBytes,
                savePath: tr.downloadDir,
                addedOn: tr.addedDate
            )
        }

        // Apply filter if specified
        let filtered: [Torrent]
        if let filter = filter {
            switch filter {
            case "downloading":
                filtered = mapped.filter { $0.isDownloading }
            case "seeding":
                filtered = mapped.filter { $0.isSeeding }
            case "completed":
                filtered = mapped.filter { $0.progress >= 1.0 }
            case "paused":
                filtered = mapped.filter { $0.isPaused }
            case "active":
                filtered = mapped.filter { $0.dlspeed > 0 || $0.upspeed > 0 }
            default:
                filtered = mapped
            }
        } else {
            filtered = mapped
        }

        // Sort by progress descending
        return filtered.sorted { $0.progress > $1.progress }
    }

    // MARK: - Torrent Files

    private struct TRFilesResponse: Decodable {
        let torrents: [TRTorrentWithFiles]
    }

    private struct TRTorrentWithFiles: Decodable {
        let id: Int
        let files: [TRFile]
        let fileStats: [TRFileStat]?
    }

    private struct TRFile: Decodable {
        let name: String
        let length: Int64
        let bytesCompleted: Int64
    }

    private struct TRFileStat: Decodable {
        let bytesCompleted: Int64
        let wanted: Bool
        let priority: Int
    }

    public func fetchTorrentFiles(hash: String) async throws -> [TorrentFile] {
        let args = TorrentGetArgs(fields: ["id", "files", "fileStats"], ids: [hash])
        let resp: TRFilesResponse = try await executeRPC(method: "torrent-get", arguments: args)

        guard let firstTorrent = resp.torrents.first else {
            return []
        }

        return firstTorrent.files.enumerated().map { index, file in
            let stat = firstTorrent.fileStats != nil && index < firstTorrent.fileStats!.count ? firstTorrent.fileStats![index] : nil
            let progress = file.length > 0 ? min(1.0, Double(file.bytesCompleted) / Double(file.length)) : 1.0
            return TorrentFile(
                index: index,
                name: file.name,
                size: file.length,
                progress: progress,
                priority: stat?.priority ?? 1,
                isSeed: nil
            )
        }
    }

    // MARK: - Actions

    private struct TorrentActionArgs: Encodable {
        let ids: [String]?

        init(ids: [String]?) {
            self.ids = ids
        }
    }

    public func pauseTorrents(hashes: [String]) async throws {
        let ids: [String]? = hashes.contains("all") ? nil : hashes
        let args = TorrentActionArgs(ids: ids)
        let _: EmptyArgs = try await executeRPC(method: "torrent-stop", arguments: args)
    }

    public func resumeTorrents(hashes: [String]) async throws {
        let ids: [String]? = hashes.contains("all") ? nil : hashes
        let args = TorrentActionArgs(ids: ids)
        let _: EmptyArgs = try await executeRPC(method: "torrent-start", arguments: args)
    }

    private struct RemoveTorrentArgs: Encodable {
        let ids: [String]?
        let deleteLocalData: Bool

        enum CodingKeys: String, CodingKey {
            case ids
            case deleteLocalData = "delete-local-data"
        }
    }

    public func deleteTorrents(hashes: [String], deleteFiles: Bool) async throws {
        let ids: [String]? = hashes.contains("all") ? nil : hashes
        let args = RemoveTorrentArgs(ids: ids, deleteLocalData: deleteFiles)
        let _: EmptyArgs = try await executeRPC(method: "torrent-remove", arguments: args)
    }

    public func recheckTorrents(hashes: [String]) async throws {
        let ids: [String]? = hashes.contains("all") ? nil : hashes
        let args = TorrentActionArgs(ids: ids)
        let _: EmptyArgs = try await executeRPC(method: "torrent-verify", arguments: args)
    }

    // MARK: - Add Torrent

    private struct AddTorrentFilenameArgs: Encodable {
        let filename: String
        let paused: Bool
        let downloadDir: String?

        enum CodingKeys: String, CodingKey {
            case filename
            case paused
            case downloadDir = "download-dir"
        }
    }

    private struct AddTorrentMetainfoArgs: Encodable {
        let metainfo: String
        let paused: Bool
        let downloadDir: String?

        enum CodingKeys: String, CodingKey {
            case metainfo
            case paused
            case downloadDir = "download-dir"
        }
    }

    public func addTorrent(urls: [String], savePath: String? = nil, paused: Bool = false) async throws {
        for url in urls {
            let cleanURL = url.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !cleanURL.isEmpty else { continue }
            let args = AddTorrentFilenameArgs(
                filename: cleanURL,
                paused: paused,
                downloadDir: savePath?.isEmpty == false ? savePath : nil
            )
            let _: EmptyArgs = try await executeRPC(method: "torrent-add", arguments: args)
        }
    }

    public func addTorrent(
        fileData: Data,
        fileName: String,
        savePath: String? = nil,
        paused: Bool = false
    ) async throws {
        let base64 = fileData.base64EncodedString()
        let args = AddTorrentMetainfoArgs(
            metainfo: base64,
            paused: paused,
            downloadDir: savePath?.isEmpty == false ? savePath : nil
        )
        let _: EmptyArgs = try await executeRPC(method: "torrent-add", arguments: args)
    }

    public func getDefaultSavePath() async -> String? {
        let fields = SessionGetFields(fields: ["download-dir"])
        guard let resp: SessionGetResponse = try? await executeRPC(method: "session-get", arguments: fields) else {
            return nil
        }
        return resp.downloadDir
    }
}
