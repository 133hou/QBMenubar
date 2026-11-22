import Foundation

public actor QBittorrentService: TorrentClientService {
    private var config: APIConfig
    private let session: URLSession

    public init(config: APIConfig) {
        self.config = config
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpCookieAcceptPolicy = .always
        sessionConfig.httpShouldSetCookies = true
        sessionConfig.httpCookieStorage = HTTPCookieStorage()
        sessionConfig.timeoutIntervalForRequest = 2.5
        sessionConfig.timeoutIntervalForResource = 5.0
        sessionConfig.waitsForConnectivity = false
        self.session = URLSession(configuration: sessionConfig)
    }

    public func updateConfig(_ newConfig: APIConfig) {
        self.config = newConfig
    }

    // MARK: - Generic Request Helper

    private func makeRequest(
        path: String,
        method: String = "GET",
        queryItems: [URLQueryItem]? = nil,
        formData: [String: String]? = nil
    ) throws -> URLRequest {
        guard var url = config.endpointURL(for: path) else {
            throw URLError(.badURL)
        }

        if let queryItems = queryItems, !queryItems.isEmpty {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            if let resolvedURL = components?.url {
                url = resolvedURL
            }
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(config.normalizedBaseURL, forHTTPHeaderField: "Referer")
        request.setValue(config.normalizedBaseURL, forHTTPHeaderField: "Origin")
        request.setValue("QBMenubar/1.0 (macOS)", forHTTPHeaderField: "User-Agent")

        if let formData = formData {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let bodyString = formData.map { key, value in
                let escapedKey = Self.formURLEncode(key)
                let escapedValue = Self.formURLEncode(value)
                return "\(escapedKey)=\(escapedValue)"
            }.joined(separator: "&")
            request.httpBody = bodyString.data(using: .utf8)
        }

        return request
    }

    internal static func formURLEncode(_ value: String) -> String {
        let allowed = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._~"))
        return value.addingPercentEncoding(withAllowedCharacters: allowed) ?? value
    }

    private func validateSuccessResponse(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            let errorMsg = String(data: data, encoding: .utf8) ?? "HTTP \(httpResponse.statusCode)"
            throw NSError(
                domain: "QBittorrentService",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey: errorMsg]
            )
        }
    }

    // MARK: - Connection & Auth

    public func testConnection() async throws -> (version: String, pingMs: Int) {
        let startTime = Date()
        let request = try makeRequest(path: "/app/version")
        let (data, response) = try await session.data(for: request)
        let ping = Int(Date().timeIntervalSince(startTime) * 1000)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if httpResponse.statusCode == 200, let version = String(data: data, encoding: .utf8) {
            return (version.trimmingCharacters(in: .whitespacesAndNewlines), ping)
        }

        // If 403 Forbidden, try logging in
        if httpResponse.statusCode == 403 {
            let success = try await login()
            if success {
                return ("Authenticated", ping)
            }
            throw URLError(.userAuthenticationRequired)
        }

        throw URLError(.cannotConnectToHost)
    }

    public func login() async throws -> Bool {
        if config.bypassLocalhost {
            // Check if already authenticated or bypass works
            if let (version, _) = try? await testConnection(), !version.isEmpty {
                return true
            }
        }

        let request = try makeRequest(
            path: "/auth/login",
            method: "POST",
            formData: [
                "username": config.username,
                "password": config.password
            ]
        )

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }

        let body = String(data: data, encoding: .utf8) ?? ""
        return httpResponse.statusCode == 200 && body.contains("Ok.")
    }

    // MARK: - Queries

    public func fetchTransferInfo() async throws -> TransferInfo {
        let request = try makeRequest(path: "/transfer/info")
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(TransferInfo.self, from: data)
    }

    public func fetchSpeedLimitsMode() async throws -> Bool {
        let request = try makeRequest(path: "/transfer/speedLimitsMode")
        let (data, _) = try await session.data(for: request)
        let str = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        return str == "1"
    }

    public func toggleSpeedLimitsMode() async throws {
        let request = try makeRequest(path: "/transfer/toggleSpeedLimitsMode", method: "POST")
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func fetchTorrents(filter: String? = nil) async throws -> [Torrent] {
        var queryItems = [
            URLQueryItem(name: "sort", value: "progress"),
            URLQueryItem(name: "reverse", value: "true")
        ]
        if let filter = filter {
            queryItems.append(URLQueryItem(name: "filter", value: filter))
        }

        let request = try makeRequest(path: "/torrents/info", queryItems: queryItems)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Torrent].self, from: data)
    }

    public func fetchTorrentFiles(hash: String) async throws -> [TorrentFile] {
        let queryItems = [URLQueryItem(name: "hash", value: hash)]
        let request = try makeRequest(path: "/torrents/files", queryItems: queryItems)
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([TorrentFile].self, from: data)
    }

    // MARK: - Actions

    public func pauseTorrents(hashes: [String]) async throws {
        let hashesString = hashes.joined(separator: "|")
        let request = try makeRequest(
            path: "/torrents/pause",
            method: "POST",
            formData: ["hashes": hashesString]
        )
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func resumeTorrents(hashes: [String]) async throws {
        let hashesString = hashes.joined(separator: "|")
        let request = try makeRequest(
            path: "/torrents/resume",
            method: "POST",
            formData: ["hashes": hashesString]
        )
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func deleteTorrents(hashes: [String], deleteFiles: Bool) async throws {
        let hashesString = hashes.joined(separator: "|")
        let request = try makeRequest(
            path: "/torrents/delete",
            method: "POST",
            formData: [
                "hashes": hashesString,
                "deleteFiles": deleteFiles ? "true" : "false"
            ]
        )
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func recheckTorrents(hashes: [String]) async throws {
        let hashesString = hashes.joined(separator: "|")
        let request = try makeRequest(
            path: "/torrents/recheck",
            method: "POST",
            formData: ["hashes": hashesString]
        )
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func addTorrent(urls: [String], savePath: String? = nil, paused: Bool = false) async throws {
        var formData: [String: String] = [
            "urls": urls.joined(separator: "\n"),
            "paused": paused ? "true" : "false"
        ]
        if let savePath = savePath, !savePath.isEmpty {
            formData["savepath"] = savePath
        }

        let request = try makeRequest(
            path: "/torrents/add",
            method: "POST",
            formData: formData
        )
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func addTorrent(
        fileData: Data,
        fileName: String,
        savePath: String? = nil,
        paused: Bool = false
    ) async throws {
        guard let url = config.endpointURL(for: "/torrents/add") else {
            throw URLError(.badURL)
        }

        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(config.normalizedBaseURL, forHTTPHeaderField: "Referer")
        request.setValue(config.normalizedBaseURL, forHTTPHeaderField: "Origin")
        request.setValue("QBMenubar/1.0 (macOS)", forHTTPHeaderField: "User-Agent")

        var body = Data()

        func appendFormField(name: String, value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        appendFormField(name: "paused", value: paused ? "true" : "false")
        if let savePath = savePath, !savePath.isEmpty {
            appendFormField(name: "savepath", value: savePath)
        }

        let safeFileName = fileName.isEmpty ? "download.torrent" : fileName
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"torrents\"; filename=\"\(safeFileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/x-bittorrent\r\n\r\n".data(using: .utf8)!)
        body.append(fileData)
        body.append("\r\n".data(using: .utf8)!)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body
        let (data, response) = try await session.data(for: request)
        try validateSuccessResponse(response, data: data)
    }

    public func getDefaultSavePath() async -> String? {
        guard let request = try? makeRequest(path: "/app/defaultSavePath") else { return nil }
        guard let (data, response) = try? await session.data(for: request),
              let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
              let path = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines),
              !path.isEmpty else {
            return nil
        }
        return path
    }
}
