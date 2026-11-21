import Foundation

/// Unified protocol defining operations supported by torrent client backends (qBittorrent, Transmission, etc.)
public protocol TorrentClientService: Sendable {
    func updateConfig(_ newConfig: APIConfig) async
    func testConnection() async throws -> (version: String, pingMs: Int)
    func login() async throws -> Bool
    func fetchTransferInfo() async throws -> TransferInfo
    func fetchSpeedLimitsMode() async throws -> Bool
    func toggleSpeedLimitsMode() async throws
    func fetchTorrents(filter: String?) async throws -> [Torrent]
    func fetchTorrentFiles(hash: String) async throws -> [TorrentFile]
    func pauseTorrents(hashes: [String]) async throws
    func resumeTorrents(hashes: [String]) async throws
    func deleteTorrents(hashes: [String], deleteFiles: Bool) async throws
    func recheckTorrents(hashes: [String]) async throws
    func addTorrent(urls: [String], savePath: String?, paused: Bool) async throws
    func addTorrent(fileData: Data, fileName: String, savePath: String?, paused: Bool) async throws
    func getDefaultSavePath() async -> String?
}

extension TorrentClientService {
    public func fetchTorrents() async throws -> [Torrent] {
        try await fetchTorrents(filter: nil)
    }

    public func addTorrent(urls: [String]) async throws {
        try await addTorrent(urls: urls, savePath: nil, paused: false)
    }
}

public enum TorrentServiceFactory {
    public static func create(for config: APIConfig) -> any TorrentClientService {
        switch config.clientType {
        case .qbittorrent:
            return QBittorrentService(config: config)
        case .transmission:
            return TransmissionService(config: config)
        }
    }
}
