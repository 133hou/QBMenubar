import Foundation
import Security
import QBMenubarShared

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

    public var isChinese: Bool {
        self == .zhHans || self == .zhHant
    }

    public var isTraditionalChinese: Bool {
        self == .zhHant
    }
}

public enum MenuBarStyle: String, Codable, CaseIterable, Identifiable, Sendable {
    case downloadOnly = "只显示下载速度 (默认)"
    case twoLines = "双行显示 (↑上传 / ↓下载)"
    case singleLineBoth = "单行显示 (↓下载 ↑上传)"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        if !lang.isChinese {
            switch self {
            case .downloadOnly: return "Download Speed Only (Default)"
            case .twoLines: return "Two Lines (↑Upload / ↓Download)"
            case .singleLineBoth: return "Single Line (↓Download ↑Upload)"
            }
        } else if lang.isTraditionalChinese {
            switch self {
            case .downloadOnly: return "只顯示下載速度 (預設)"
            case .twoLines: return "雙行顯示 (↑上傳 / ↓下載)"
            case .singleLineBoth: return "單行顯示 (↓下載 ↑上傳)"
            }
        }
        return rawValue
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }
}

public enum IconTheme: String, Codable, CaseIterable, Identifiable, Sendable {
    case adaptive = "系统自适应 (黑/白)"
    case original = "经典原色 (qBittorrent 经典蓝)"
    case white = "纯白色 (深色菜单栏)"
    case black = "纯黑色 (浅色菜单栏)"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        if !lang.isChinese {
            switch self {
            case .adaptive: return "System Adaptive (Black / White)"
            case .original: return "Classic (qBittorrent Blue)"
            case .white: return "Pure White (Dark Menu Bar)"
            case .black: return "Pure Black (Light Menu Bar)"
            }
        } else if lang.isTraditionalChinese {
            switch self {
            case .adaptive: return "系統自適應 (黑/白)"
            case .original: return "經典原色 (qBittorrent 經典藍)"
            case .white: return "純白色 (深色選單列)"
            case .black: return "純黑色 (淺色選單列)"
            }
        }
        return rawValue
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }
}

public enum ArrowTheme: String, Codable, CaseIterable, Identifiable, Sendable {
    case adaptive = "跟随系统 (黑/白自适应 - 默认)"
    case white = "纯白色"
    case black = "纯黑色"
    case dynamicColor = "动态彩色 (下载绿 / 上传蓝)"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        if !lang.isChinese {
            switch self {
            case .adaptive: return "System Adaptive (Default)"
            case .white: return "Pure White"
            case .black: return "Pure Black"
            case .dynamicColor: return "Dynamic Color (Green DL / Blue UL)"
            }
        } else if lang.isTraditionalChinese {
            switch self {
            case .adaptive: return "跟隨系統 (黑/白自適應 - 預設)"
            case .white: return "純白色"
            case .black: return "純黑色"
            case .dynamicColor: return "動態彩色 (下載綠 / 上傳藍)"
            }
        }
        return rawValue
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }
}

public enum IconSizeOption: String, Codable, CaseIterable, Identifiable, Sendable {
    case tiny = "超小 (10 pt)"
    case small = "小号 (12 pt)"
    case normal = "标准 (14 pt - 默认)"
    case large = "大号 (16 pt)"
    case xlarge = "特大 (18 pt)"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        if !lang.isChinese {
            switch self {
            case .tiny: return "Tiny (10 pt)"
            case .small: return "Small (12 pt)"
            case .normal: return "Standard (14 pt - Default)"
            case .large: return "Large (16 pt)"
            case .xlarge: return "Extra Large (18 pt)"
            }
        } else if lang.isTraditionalChinese {
            switch self {
            case .tiny: return "超小 (10 pt)"
            case .small: return "小號 (12 pt)"
            case .normal: return "標準 (14 pt - 預設)"
            case .large: return "大號 (16 pt)"
            case .xlarge: return "特大 (18 pt)"
            }
        }
        return rawValue
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }

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

public enum SidebarSelectionStyle: String, Codable, CaseIterable, Identifiable, Sendable {
    case liquidGlass = "liquidGlass"
    case classic = "classic"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        switch self {
        case .liquidGlass: return L10n.sidebarStyleLiquidGlass(lang)
        case .classic: return L10n.sidebarStyleClassic(lang)
        }
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }
}

public enum ClientType: String, Codable, CaseIterable, Identifiable, Sendable {
    case qbittorrent = "qBittorrent"
    case transmission = "Transmission"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        rawValue
    }

    public func localizedTitle(isEn: Bool) -> String {
        rawValue
    }

    public var defaultPort: Int {
        switch self {
        case .qbittorrent: return 8080
        case .transmission: return 9091
        }
    }

    public var defaultBaseURL: String {
        switch self {
        case .qbittorrent: return "http://127.0.0.1:8080"
        case .transmission: return "http://127.0.0.1:9091"
        }
    }

    public var defaultApiPrefix: String {
        switch self {
        case .qbittorrent: return "/api/v2"
        case .transmission: return "/transmission/rpc"
        }
    }
}

public struct APIConfig: Codable, Equatable, Sendable {
    public var clientType: ClientType
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
    public var enableWidgetSync: Bool
    public var widgetProgressStyle: WidgetProgressStyle
    public var sidebarSelectionStyle: SidebarSelectionStyle

    public static let defaultConfig = APIConfig(
        clientType: .qbittorrent,
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
        showPinnedProgress: true,
        enableWidgetSync: true,
        widgetProgressStyle: .circularGlass,
        sidebarSelectionStyle: .liquidGlass
    )

    private static let userDefaultsKey = "QBMenubar.APIConfig"

    public init(
        clientType: ClientType = .qbittorrent,
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
        showPinnedProgress: Bool = true,
        enableWidgetSync: Bool = true,
        widgetProgressStyle: WidgetProgressStyle = .circularGlass,
        sidebarSelectionStyle: SidebarSelectionStyle = .liquidGlass
    ) {
        self.clientType = clientType
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
        self.enableWidgetSync = enableWidgetSync
        self.widgetProgressStyle = widgetProgressStyle
        self.sidebarSelectionStyle = sidebarSelectionStyle
    }

    private enum CodingKeys: String, CodingKey {
        case clientType
        case baseURL
        case apiPrefix
        case username
        case password
        case bypassLocalhost
        case pollInterval
        case chartHistorySeconds
        case showCompleted
        case maxDisplayTorrents
        case enableNotifications
        case notifyOnStart
        case notifyOnComplete
        case menuBarStyle
        case iconTheme
        case arrowTheme
        case iconSize
        case language
        case pinnedTorrentHash
        case showPinnedProgress
        case enableWidgetSync
        case widgetProgressStyle
        case sidebarSelectionStyle
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.clientType = try container.decodeIfPresent(ClientType.self, forKey: .clientType) ?? .qbittorrent
        self.baseURL = try container.decodeIfPresent(String.self, forKey: .baseURL) ?? "http://127.0.0.1:8080"
        self.apiPrefix = try container.decodeIfPresent(String.self, forKey: .apiPrefix) ?? "/api/v2"
        self.username = try container.decodeIfPresent(String.self, forKey: .username) ?? "admin"

        let legacyPassword = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        if !legacyPassword.isEmpty {
            self.password = legacyPassword
        } else {
            self.password = KeychainHelper.loadPassword() ?? ""
        }

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
        self.enableWidgetSync = try container.decodeIfPresent(Bool.self, forKey: .enableWidgetSync) ?? true
        self.widgetProgressStyle = try container.decodeIfPresent(WidgetProgressStyle.self, forKey: .widgetProgressStyle) ?? .circularGlass
        self.sidebarSelectionStyle = try container.decodeIfPresent(SidebarSelectionStyle.self, forKey: .sidebarSelectionStyle) ?? .liquidGlass
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(clientType, forKey: .clientType)
        try container.encode(baseURL, forKey: .baseURL)
        try container.encode(apiPrefix, forKey: .apiPrefix)
        try container.encode(username, forKey: .username)
        // Password is intentionally omitted from encoding to avoid plaintext persistence in UserDefaults
        try container.encode(bypassLocalhost, forKey: .bypassLocalhost)
        try container.encode(pollInterval, forKey: .pollInterval)
        try container.encode(chartHistorySeconds, forKey: .chartHistorySeconds)
        try container.encode(showCompleted, forKey: .showCompleted)
        try container.encode(maxDisplayTorrents, forKey: .maxDisplayTorrents)
        try container.encode(enableNotifications, forKey: .enableNotifications)
        try container.encode(notifyOnStart, forKey: .notifyOnStart)
        try container.encode(notifyOnComplete, forKey: .notifyOnComplete)
        try container.encode(menuBarStyle, forKey: .menuBarStyle)
        try container.encode(iconTheme, forKey: .iconTheme)
        try container.encode(arrowTheme, forKey: .arrowTheme)
        try container.encode(iconSize, forKey: .iconSize)
        try container.encode(language, forKey: .language)
        try container.encodeIfPresent(pinnedTorrentHash, forKey: .pinnedTorrentHash)
        try container.encode(showPinnedProgress, forKey: .showPinnedProgress)
        try container.encode(enableWidgetSync, forKey: .enableWidgetSync)
        try container.encode(widgetProgressStyle, forKey: .widgetProgressStyle)
        try container.encode(sidebarSelectionStyle, forKey: .sidebarSelectionStyle)
    }

    public static func load() -> APIConfig {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              var config = try? JSONDecoder().decode(APIConfig.self, from: data) else {
            var defaultConfig = APIConfig.defaultConfig
            if let keychainPassword = KeychainHelper.loadPassword() {
                defaultConfig.password = keychainPassword
            }
            return defaultConfig
        }
        if config.password.isEmpty, let keychainPassword = KeychainHelper.loadPassword() {
            config.password = keychainPassword
        }
        return config
    }

    public func save() {
        KeychainHelper.savePassword(self.password)
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

        var cleanPath = path.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanPath.isEmpty {
            return URL(string: normalizedBaseURL + cleanPrefix)
        }
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

extension WidgetProgressStyle {
    public func localizedTitle(lang: AppLanguage) -> String {
        switch self {
        case .circularGlass: return L10n.widgetStyleCircularGlass(lang)
        case .linear: return L10n.widgetStyleLinear(lang)
        }
    }
}

// MARK: - Keychain Helper

public enum KeychainHelper {
    public static let service = "com.antigravity.QBMenubar"
    public static let defaultAccount = "webui-password"
    nonisolated(unsafe) private static var inMemoryFallback: [String: String] = [:]
    private static let lock = NSLock()

    public static func savePassword(_ password: String, account: String = defaultAccount) {
        guard !password.isEmpty else {
            deletePassword(account: account)
            return
        }

        lock.lock()
        defer { lock.unlock() }

        inMemoryFallback[account] = password

        guard let data = password.data(using: .utf8) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemCopyMatching(query as CFDictionary, nil)
        if status == errSecSuccess {
            let attributesToUpdate: [String: Any] = [
                kSecValueData as String: data
            ]
            _ = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        } else if status == errSecItemNotFound {
            var newItem = query
            newItem[kSecValueData as String] = data
            _ = SecItemAdd(newItem as CFDictionary, nil)
        }
    }

    public static func loadPassword(account: String = defaultAccount) -> String? {
        lock.lock()
        defer { lock.unlock() }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess, let data = item as? Data, let str = String(data: data, encoding: .utf8) {
            return str
        }

        return inMemoryFallback[account]
    }

    public static func deletePassword(account: String = defaultAccount) {
        lock.lock()
        defer { lock.unlock() }

        inMemoryFallback.removeValue(forKey: account)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        _ = SecItemDelete(query as CFDictionary)
    }
}
