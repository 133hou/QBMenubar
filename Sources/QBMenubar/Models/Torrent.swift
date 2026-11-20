import Foundation

public struct Torrent: Codable, Identifiable, Sendable, Equatable {
    public var id: String { hash }

    public let hash: String
    public let name: String
    public let size: Int64
    public let progress: Double
    public let dlspeed: Int64
    public let upspeed: Int64
    public let eta: Int
    public let state: String
    public let numSeeds: Int?
    public let numLeechs: Int?
    public let ratio: Double?
    public let completed: Int64?
    public let savePath: String?
    public let addedOn: Int64?

    enum CodingKeys: String, CodingKey {
        case hash
        case name
        case size
        case progress
        case dlspeed
        case upspeed
        case eta
        case state
        case numSeeds = "num_seeds"
        case numLeechs = "num_leechs"
        case ratio
        case completed
        case savePath = "save_path"
        case addedOn = "added_on"
    }

    public init(
        hash: String,
        name: String,
        size: Int64 = 0,
        progress: Double = 0.0,
        dlspeed: Int64 = 0,
        upspeed: Int64 = 0,
        eta: Int = -1,
        state: String = "downloading",
        numSeeds: Int? = 0,
        numLeechs: Int? = 0,
        ratio: Double? = 0.0,
        completed: Int64? = 0,
        savePath: String? = nil,
        addedOn: Int64? = nil
    ) {
        self.hash = hash
        self.name = name
        self.size = size
        self.progress = progress
        self.dlspeed = dlspeed
        self.upspeed = upspeed
        self.eta = eta
        self.state = state
        self.numSeeds = numSeeds
        self.numLeechs = numLeechs
        self.ratio = ratio
        self.completed = completed
        self.savePath = savePath
        self.addedOn = addedOn
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hash = try container.decodeIfPresent(String.self, forKey: .hash) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
        self.size = (try? container.decodeIfPresent(Int64.self, forKey: .size)) ?? 0
        self.progress = (try? container.decodeIfPresent(Double.self, forKey: .progress)) ?? 0.0
        self.dlspeed = (try? container.decodeIfPresent(Int64.self, forKey: .dlspeed)) ?? 0
        self.upspeed = (try? container.decodeIfPresent(Int64.self, forKey: .upspeed)) ?? 0
        self.eta = (try? container.decodeIfPresent(Int.self, forKey: .eta)) ?? (try? container.decodeIfPresent(Int64.self, forKey: .eta).map { Int($0) }) ?? -1
        self.state = (try? container.decodeIfPresent(String.self, forKey: .state)) ?? "downloading"
        self.numSeeds = try? container.decodeIfPresent(Int.self, forKey: .numSeeds)
        self.numLeechs = try? container.decodeIfPresent(Int.self, forKey: .numLeechs)
        self.ratio = try? container.decodeIfPresent(Double.self, forKey: .ratio)
        self.completed = try? container.decodeIfPresent(Int64.self, forKey: .completed)
        self.savePath = try? container.decodeIfPresent(String.self, forKey: .savePath)
        self.addedOn = try? container.decodeIfPresent(Int64.self, forKey: .addedOn)
    }

    // MARK: - Helper Computed Properties

    public var isDownloading: Bool {
        ["downloading", "metaDL", "forcedDL", "stalledDL", "queuedDL"].contains(state)
    }

    public var isSeeding: Bool {
        ["uploading", "forcedUP", "stalledUP", "queuedUP"].contains(state)
    }

    public var isPaused: Bool {
        ["pausedDL", "pausedUP", "stoppedDL", "stoppedUP"].contains(state)
    }

    public var isError: Bool {
        ["error", "missingFiles"].contains(state)
    }

    public func localizedStateDescription(lang: AppLanguage) -> String {
        if !lang.isChinese {
            switch state {
            case "downloading": return "Downloading"
            case "metaDL": return "Metadata"
            case "forcedDL": return "Forced DL"
            case "stalledDL": return "Stalled"
            case "queuedDL": return "Queued"
            case "uploading", "forcedUP": return "Seeding"
            case "stalledUP": return "Seeding"
            case "queuedUP": return "Queued UP"
            case "pausedDL": return "Paused"
            case "pausedUP": return "Completed"
            case "checkingDL", "checkingUP": return "Checking"
            case "error": return "Error"
            case "missingFiles": return "Missing"
            default: return state.capitalized
            }
        } else if lang.isTraditionalChinese {
            switch state {
            case "downloading": return "下載中"
            case "metaDL": return "獲取元數據"
            case "forcedDL": return "強制下載"
            case "stalledDL": return "等待連線"
            case "queuedDL": return "排隊中"
            case "uploading": return "做種中"
            case "forcedUP": return "強制做種"
            case "stalledUP": return "等待做種"
            case "queuedUP": return "排隊做種"
            case "pausedDL": return "已暫停"
            case "pausedUP": return "已完成 (暫停)"
            case "checkingDL", "checkingUP": return "校驗中"
            case "error": return "錯誤"
            case "missingFiles": return "文件缺失"
            default: return state
            }
        }
        return stateDescription
    }

    public func localizedStateDescription(isEn: Bool) -> String {
        localizedStateDescription(lang: isEn ? .en : .zhHans)
    }

    public var stateDescription: String {
        switch state {
        case "downloading": return "下载中"
        case "metaDL": return "获取元数据"
        case "forcedDL": return "强制下载"
        case "stalledDL": return "等待连接"
        case "queuedDL": return "排队中"
        case "uploading": return "做种中"
        case "forcedUP": return "强制做种"
        case "stalledUP": return "等待做种"
        case "queuedUP": return "排队做种"
        case "pausedDL": return "已暂停"
        case "pausedUP": return "已完成(暂停)"
        case "checkingDL", "checkingUP": return "校验中"
        case "error": return "错误"
        case "missingFiles": return "文件缺失"
        default: return state
        }
    }

    public var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }

    public var formattedCompletedSize: String {
        ByteCountFormatter.string(fromByteCount: completed ?? 0, countStyle: .file)
    }

    public var formattedDLSpeed: String {
        if dlspeed <= 0 { return "0 B/s" }
        return ByteCountFormatter.string(fromByteCount: dlspeed, countStyle: .file) + "/s"
    }

    public var formattedUPSpeed: String {
        if upspeed <= 0 { return "0 B/s" }
        return ByteCountFormatter.string(fromByteCount: upspeed, countStyle: .file) + "/s"
    }

    public var formattedETA: String {
        if eta < 0 || eta >= 8640000 { return "∞" }
        if eta < 60 { return "\(eta)s" }
        let mins = eta / 60
        let secs = eta % 60
        let hours = mins / 60
        let remMins = mins % 60
        let days = hours / 24
        let remHours = hours % 24
        if days > 0 { return "\(days)d \(remHours)h" }
        if hours > 0 { return "\(hours)h \(remMins)m" }
        return "\(mins)m \(secs)s"
    }
}
