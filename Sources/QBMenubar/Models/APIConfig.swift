import Foundation

public enum AppLanguage: String, Codable, CaseIterable, Identifiable, Sendable {
    case zhHans = "简体中文"
    case en = "English"
    case zhHant = "繁體中文"
    case ja = "日本語"
    case ko = "한국어"
    case fr = "Français"
    case de = "Deutsch"
    case es = "Español"
    case ru = "Русский"

    public var id: String { rawValue }
}

public enum MenuBarStyle: String, Codable, CaseIterable, Identifiable, Sendable {
    case downloadOnly = "只显示下载速度 (默认)"
    case twoLines = "双行显示 (↑上传 / ↓下载)"
    case singleLineBoth = "单行显示 (↓下载 ↑上传)"

    public var id: String { rawValue }
}

public enum IconTheme: String, Codable, CaseIterable, Identifiable, Sendable {
    case adaptive = "系统自适应 (黑/白)"
    case original = "经典原色 (qBittorrent 经典蓝)"
    case white = "纯白色 (深色菜单栏)"
    case black = "纯黑色 (浅色菜单栏)"

    public var id: String { rawValue }
}

public enum ArrowTheme: String, Codable, CaseIterable, Identifiable, Sendable {
    case adaptive = "跟随系统 (黑/白自适应 - 默认)"
    case white = "纯白色"
    case black = "纯黑色"
    case dynamicColor = "动态彩色 (下载绿 / 上传蓝)"

    public var id: String { rawValue }
}

public enum IconSizeOption: String, Codable, CaseIterable, Identifiable, Sendable {
    case tiny = "超小 (10 pt)"
    case small = "小号 (12 pt)"
    case normal = "标准 (14 pt - 默认)"
    case large = "大号 (16 pt)"
    case xlarge = "特大 (18 pt)"

    public var id: String { rawValue }

    public var points: Double {
        switch self {
        case .tiny: return 10.0
        case .small: return 12.0
        case .normal: return 14.0
        case .large: return 16.0
        case .xlarge: return 18.0
        }
    }
}

public struct APIConfig: Codable, Equatable, Sendable {
    public var baseURL: String
    public var apiPrefix: String
    public var username: String
    public var password: String
    public var bypassLocalhost: Bool
    public var pollInterval: Double
    public var chartHistorySeconds: Int
    public var showCompleted: Bool
    public var maxDisplayTorrents: Int
    public var enableNotifications: Bool
    public var notifyOnStart: Bool
    public var notifyOnComplete: Bool
    public var menuBarStyle: MenuBarStyle
    public var iconTheme: IconTheme
    public var arrowTheme: ArrowTheme
    public var iconSize: IconSizeOption
    public var language: AppLanguage
    public var pinnedTorrentHash: String?
    public var showPinnedProgress: Bool

    public static let defaultConfig = APIConfig(
        baseURL: "http://127.0.0.1:8080",
        apiPrefix: "/api/v2",
        username: "admin",
        password: "",
        bypassLocalhost: true,
        pollInterval: 2.0,
        chartHistorySeconds: 30,
        showCompleted: true,
        maxDisplayTorrents: 20,
        enableNotifications: true,
        notifyOnStart: true,
        notifyOnComplete: true,
        menuBarStyle: .downloadOnly,
        iconTheme: .adaptive,
        arrowTheme: .adaptive,
        iconSize: .normal,
        language: .zhHans,
        pinnedTorrentHash: "auto",
        showPinnedProgress: true
    )

    private static let userDefaultsKey = "QBMenubar.APIConfig"

    public init(
        baseURL: String = "http://127.0.0.1:8080",
        apiPrefix: String = "/api/v2",
        username: String = "admin",
        password: String = "",
        bypassLocalhost: Bool = true,
        pollInterval: Double = 2.0,
        chartHistorySeconds: Int = 30,
        showCompleted: Bool = true,
        maxDisplayTorrents: Int = 20,
        enableNotifications: Bool = true,
        notifyOnStart: Bool = true,
        notifyOnComplete: Bool = true,
        menuBarStyle: MenuBarStyle = .downloadOnly,
        iconTheme: IconTheme = .adaptive,
        arrowTheme: ArrowTheme = .adaptive,
        iconSize: IconSizeOption = .normal,
        language: AppLanguage = .zhHans,
        pinnedTorrentHash: String? = "auto",
        showPinnedProgress: Bool = true
    ) {
        self.baseURL = baseURL
        self.apiPrefix = apiPrefix
        self.username = username
        self.password = password
        self.bypassLocalhost = bypassLocalhost
        self.pollInterval = pollInterval
        self.chartHistorySeconds = chartHistorySeconds
        self.showCompleted = showCompleted
        self.maxDisplayTorrents = maxDisplayTorrents
        self.enableNotifications = enableNotifications
        self.notifyOnStart = notifyOnStart
        self.notifyOnComplete = notifyOnComplete
        self.menuBarStyle = menuBarStyle
        self.iconTheme = iconTheme
        self.arrowTheme = arrowTheme
        self.iconSize = iconSize
        self.language = language
        self.pinnedTorrentHash = pinnedTorrentHash
        self.showPinnedProgress = showPinnedProgress
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseURL = try container.decodeIfPresent(String.self, forKey: .baseURL) ?? "http://127.0.0.1:8080"
        self.apiPrefix = try container.decodeIfPresent(String.self, forKey: .apiPrefix) ?? "/api/v2"
        self.username = try container.decodeIfPresent(String.self, forKey: .username) ?? "admin"
        self.password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        self.bypassLocalhost = try container.decodeIfPresent(Bool.self, forKey: .bypassLocalhost) ?? true
        self.pollInterval = try container.decodeIfPresent(Double.self, forKey: .pollInterval) ?? 2.0
        self.chartHistorySeconds = try container.decodeIfPresent(Int.self, forKey: .chartHistorySeconds) ?? 30
        self.showCompleted = try container.decodeIfPresent(Bool.self, forKey: .showCompleted) ?? true
        self.maxDisplayTorrents = try container.decodeIfPresent(Int.self, forKey: .maxDisplayTorrents) ?? 20
        self.enableNotifications = try container.decodeIfPresent(Bool.self, forKey: .enableNotifications) ?? true
        self.notifyOnStart = try container.decodeIfPresent(Bool.self, forKey: .notifyOnStart) ?? true
        self.notifyOnComplete = try container.decodeIfPresent(Bool.self, forKey: .notifyOnComplete) ?? true
        self.menuBarStyle = try container.decodeIfPresent(MenuBarStyle.self, forKey: .menuBarStyle) ?? .downloadOnly
        self.iconTheme = try container.decodeIfPresent(IconTheme.self, forKey: .iconTheme) ?? .adaptive
        self.arrowTheme = try container.decodeIfPresent(ArrowTheme.self, forKey: .arrowTheme) ?? .adaptive
        self.iconSize = try container.decodeIfPresent(IconSizeOption.self, forKey: .iconSize) ?? .normal
        self.language = try container.decodeIfPresent(AppLanguage.self, forKey: .language) ?? .zhHans
        self.pinnedTorrentHash = try container.decodeIfPresent(String.self, forKey: .pinnedTorrentHash) ?? "auto"
        self.showPinnedProgress = try container.decodeIfPresent(Bool.self, forKey: .showPinnedProgress) ?? true
    }

    public static func load() -> APIConfig {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let config = try? JSONDecoder().decode(APIConfig.self, from: data) else {
            return .defaultConfig
        }
        return config
    }

    public func save() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: Self.userDefaultsKey)
        }
    }

    public var normalizedBaseURL: String {
        var url = baseURL.trimmingCharacters(in: .whitespacesAndNewlines)
        while url.hasSuffix("/") {
            url.removeLast()
        }
        if !url.starts(with: "http://") && !url.starts(with: "https://") {
            url = "http://" + url
        }
        return url
    }

    public func endpointURL(for path: String) -> URL? {
        var cleanPrefix = apiPrefix.trimmingCharacters(in: .whitespacesAndNewlines)
        if !cleanPrefix.hasPrefix("/") {
            cleanPrefix = "/" + cleanPrefix
        }
        while cleanPrefix.hasSuffix("/") {
            cleanPrefix.removeLast()
        }

        var cleanPath = path
        if !cleanPath.hasPrefix("/") {
            cleanPath = "/" + cleanPath
        }

        let fullString = normalizedBaseURL + cleanPrefix + cleanPath
        return URL(string: fullString)
    }

    public static func formatSpeed(_ bytesPerSec: Int64) -> String {
        if bytesPerSec <= 0 {
            return "0 KB/s"
        }
        let kb = Double(bytesPerSec) / 1024.0
        if kb < 1000.0 {
            return String(format: "%.0f KB/s", kb)
        }
        let mb = kb / 1024.0
        if mb < 1000.0 {
            return String(format: "%.1f MB/s", mb)
        }
        let gb = mb / 1024.0
        return String(format: "%.2f GB/s", gb)
    }

    public static func formatBytes(_ bytes: Int64) -> String {
        ByteCountFormatter.string(fromByteCount: bytes, countStyle: .file)
    }
}
