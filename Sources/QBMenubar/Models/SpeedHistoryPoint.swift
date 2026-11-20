import Foundation

public struct SpeedHistoryPoint: Identifiable, Sendable, Equatable {
    public let id: UUID
    public let timestamp: Date
    public let downloadSpeed: Double // MB/s
    public let uploadSpeed: Double   // MB/s

    public init(id: UUID = UUID(), timestamp: Date = Date(), downloadBytes: Int64, uploadBytes: Int64) {
        self.id = id
        self.timestamp = timestamp
        self.downloadSpeed = max(0.0, Double(downloadBytes) / (1024.0 * 1024.0))
        self.uploadSpeed = max(0.0, Double(uploadBytes) / (1024.0 * 1024.0))
    }
}
