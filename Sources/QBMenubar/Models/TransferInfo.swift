import Foundation

public struct TransferInfo: Codable, Sendable, Equatable {
    public let dlInfoSpeed: Int64
    public let upInfoSpeed: Int64
    public let dlInfoData: Int64
    public let upInfoData: Int64
    public let connectionStatus: String
    public let dhtNodes: Int64

    enum CodingKeys: String, CodingKey {
        case dlInfoSpeed = "dl_info_speed"
        case upInfoSpeed = "up_info_speed"
        case dlInfoData = "dl_info_data"
        case upInfoData = "up_info_data"
        case connectionStatus = "connection_status"
        case dhtNodes = "dht_nodes"
    }

    public init(
        dlInfoSpeed: Int64 = 0,
        upInfoSpeed: Int64 = 0,
        dlInfoData: Int64 = 0,
        upInfoData: Int64 = 0,
        connectionStatus: String = "connected",
        dhtNodes: Int64 = 0
    ) {
        self.dlInfoSpeed = dlInfoSpeed
        self.upInfoSpeed = upInfoSpeed
        self.dlInfoData = dlInfoData
        self.upInfoData = upInfoData
        self.connectionStatus = connectionStatus
        self.dhtNodes = dhtNodes
    }
}
