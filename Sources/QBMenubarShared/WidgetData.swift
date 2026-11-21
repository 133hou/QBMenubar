import Foundation

// MARK: - Widget Task Model

public struct WidgetTorrentTask: Codable, Identifiable, Sendable, Equatable {
    public var id: String
    public var name: String
    public var progress: Double // 0.0 ... 1.0
    public var progressPercent: Int // 0 ... 100
    public var dlspeed: Int64
    public var upspeed: Int64
    public var speedFormatted: String
    public var sizeFormatted: String
    public var completedFormatted: String
    public var etaFormatted: String
    public var state: String
    public var isDownloading: Bool
    public var isSeeding: Bool
    public var isPaused: Bool

    public init(
        id: String,
        name: String,
        progress: Double,
        progressPercent: Int,
        dlspeed: Int64,
        upspeed: Int64,
        speedFormatted: String,
        sizeFormatted: String,
        completedFormatted: String,
        etaFormatted: String,
        state: String,
        isDownloading: Bool,
        isSeeding: Bool,
        isPaused: Bool
    ) {
        self.id = id
        self.name = name
        self.progress = progress
        self.progressPercent = progressPercent
        self.dlspeed = dlspeed
        self.upspeed = upspeed
        self.speedFormatted = speedFormatted
        self.sizeFormatted = sizeFormatted
        self.completedFormatted = completedFormatted
        self.etaFormatted = etaFormatted
        self.state = state
        self.isDownloading = isDownloading
        self.isSeeding = isSeeding
        self.isPaused = isPaused
    }
}

// MARK: - Widget Data Snapshot

public struct WidgetData: Codable, Sendable, Equatable {
    public var updatedAt: Date
    public var isConnected: Bool
    public var dlSpeed: Int64
    public var upSpeed: Int64
    public var dlSpeedFormatted: String
    public var upSpeedFormatted: String
    public var activeDownloadsCount: Int
    public var activeSeedsCount: Int
    public var pausedCount: Int
    public var totalCount: Int
    public var tasks: [WidgetTorrentTask]
    public var syncEnabled: Bool
    public var permissionGranted: Bool
    public var statusMessage: String?

    public init(
        updatedAt: Date = Date(),
        isConnected: Bool = false,
        dlSpeed: Int64 = 0,
        upSpeed: Int64 = 0,
        dlSpeedFormatted: String = "0 B/s",
        upSpeedFormatted: String = "0 B/s",
        activeDownloadsCount: Int = 0,
        activeSeedsCount: Int = 0,
        pausedCount: Int = 0,
        totalCount: Int = 0,
        tasks: [WidgetTorrentTask] = [],
        syncEnabled: Bool = true,
        permissionGranted: Bool = true,
        statusMessage: String? = nil
    ) {
        self.updatedAt = updatedAt
        self.isConnected = isConnected
        self.dlSpeed = dlSpeed
        self.upSpeed = upSpeed
        self.dlSpeedFormatted = dlSpeedFormatted
        self.upSpeedFormatted = upSpeedFormatted
        self.activeDownloadsCount = activeDownloadsCount
        self.activeSeedsCount = activeSeedsCount
        self.pausedCount = pausedCount
        self.totalCount = totalCount
        self.tasks = tasks
        self.syncEnabled = syncEnabled
        self.permissionGranted = permissionGranted
        self.statusMessage = statusMessage
    }

    public static let placeholder = WidgetData(
        updatedAt: Date(),
        isConnected: true,
        dlSpeed: 0,
        upSpeed: 0,
        dlSpeedFormatted: "0 B/s",
        upSpeedFormatted: "0 B/s",
        activeDownloadsCount: 0,
        activeSeedsCount: 0,
        pausedCount: 0,
        totalCount: 0,
        tasks: [],
        syncEnabled: true,
        permissionGranted: true,
        statusMessage: nil
    )

    public static func disabled(permissionDenied: Bool = false) -> WidgetData {
        WidgetData(
            updatedAt: Date(),
            isConnected: false,
            dlSpeed: 0,
            upSpeed: 0,
            dlSpeedFormatted: "0 B/s",
            upSpeedFormatted: "0 B/s",
            activeDownloadsCount: 0,
            activeSeedsCount: 0,
            pausedCount: 0,
            totalCount: 0,
            tasks: [],
            syncEnabled: !permissionDenied,
            permissionGranted: !permissionDenied,
            statusMessage: permissionDenied ? "需数据共享权限" : "小组件已停用"
        )
    }

    public static let sample = WidgetData(
        updatedAt: Date(),
        isConnected: true,
        dlSpeed: 18_540_000,
        upSpeed: 2_410_000,
        dlSpeedFormatted: "18.5 MB/s",
        upSpeedFormatted: "2.4 MB/s",
        activeDownloadsCount: 2,
        activeSeedsCount: 8,
        pausedCount: 1,
        totalCount: 11,
        tasks: [
            WidgetTorrentTask(
                id: "sample_ubuntu_24_04",
                name: "Ubuntu 24.04.1 Desktop AMD64 ISO",
                progress: 0.74,
                progressPercent: 74,
                dlspeed: 12_800_000,
                upspeed: 320_000,
                speedFormatted: "12.8 MB/s",
                sizeFormatted: "5.8 GB",
                completedFormatted: "4.3 GB",
                etaFormatted: "2m 15s",
                state: "downloading",
                isDownloading: true,
                isSeeding: false,
                isPaused: false
            ),
            WidgetTorrentTask(
                id: "sample_debian_12_8",
                name: "Debian GNU/Linux 12.8 Live Cinnamon",
                progress: 0.42,
                progressPercent: 42,
                dlspeed: 5_740_000,
                upspeed: 180_000,
                speedFormatted: "5.7 MB/s",
                sizeFormatted: "3.2 GB",
                completedFormatted: "1.3 GB",
                etaFormatted: "5m 40s",
                state: "downloading",
                isDownloading: true,
                isSeeding: false,
                isPaused: false
            ),
            WidgetTorrentTask(
                id: "sample_arch_linux",
                name: "Arch Linux 2026.01 x86_64 Installation Media",
                progress: 1.0,
                progressPercent: 100,
                dlspeed: 0,
                upspeed: 1_200_000,
                speedFormatted: "1.2 MB/s",
                sizeFormatted: "1.1 GB",
                completedFormatted: "1.1 GB",
                etaFormatted: "∞",
                state: "uploading",
                isDownloading: false,
                isSeeding: true,
                isPaused: false
            )
        ]
    )
}

// MARK: - Widget Data Manager (Triple-Layer Shared Store)

public enum WidgetDataManager {
    public static let teamIDPrefix = "27F3GS56YW."
    public static let baseAppGroupID = "group.com.antigravity.QBMenubar"
    public static var appGroupID: String {
        // If container with team ID prefix exists or is accessible, prefer it
        let teamPrefixed = teamIDPrefix + baseAppGroupID
        if FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: teamPrefixed) != nil {
            return teamPrefixed
        }
        return baseAppGroupID
    }
    public static let candidateAppGroupIDs = [
        "27F3GS56YW.group.com.antigravity.QBMenubar",
        "group.com.antigravity.QBMenubar"
    ]
    public static let widgetKind = "QBMenubarWidget"
    public static let snapshotKey = "qb_widget_snapshot"
    public static let fileName = "widget_snapshot.json"

    /// Checks whether the application has permission to write to and read from the App Group container.
    public static func checkGroupContainerPermission() -> Bool {
        for groupID in candidateAppGroupIDs {
            if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID) {
                let probeFile = containerURL.appendingPathComponent(".probe_\(ProcessInfo.processInfo.processIdentifier).tmp")
                do {
                    try FileManager.default.createDirectory(at: containerURL, withIntermediateDirectories: true)
                    try "probe".write(to: probeFile, atomically: true, encoding: .utf8)
                    try? FileManager.default.removeItem(at: probeFile)
                    return true
                } catch {
                    continue
                }
            }
        }
        return false
    }

    /// Resets the TCC permission cache for the app and immediately attempts container access to re-trigger macOS system permission alert.
    @discardableResult
    public static func triggerPermissionPrompt() -> Bool {
        // Reset TCC approval for com.antigravity.QBMenubar via tccutil
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/tccutil")
        task.arguments = ["reset", "All", "com.antigravity.QBMenubar"]
        try? task.run()
        task.waitUntilExit()

        usleep(150_000)

        // Probe access to invoke macOS TCC prompt
        for groupID in candidateAppGroupIDs {
            if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID) {
                let probeFile = containerURL.appendingPathComponent(".probe_prompt.tmp")
                try? FileManager.default.createDirectory(at: containerURL, withIntermediateDirectories: true)
                try? "prompt".write(to: probeFile, atomically: true, encoding: .utf8)
                try? FileManager.default.removeItem(at: probeFile)
            }
        }

        return checkGroupContainerPermission()
    }

    /// Saves the latest widget snapshot across all shared storage locations.
    public static func saveSnapshot(_ data: WidgetData) {
        guard let encoded = try? JSONEncoder().encode(data) else { return }

        // 1. App Group suite UserDefaults (save to all candidate groups)
        for groupID in candidateAppGroupIDs {
            if let userDefaults = UserDefaults(suiteName: groupID) {
                userDefaults.set(encoded, forKey: snapshotKey)
            }
        }
        // Also save to standard UserDefaults
        UserDefaults.standard.set(encoded, forKey: snapshotKey)

        // 2. App Group Container file
        for groupID in candidateAppGroupIDs {
            if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID) {
                try? FileManager.default.createDirectory(at: containerURL, withIntermediateDirectories: true)
                let fileURL = containerURL.appendingPathComponent(fileName)
                try? encoded.write(to: fileURL, options: .atomic)
            }
        }

        // 3. Application Support fallback
        if let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let qbDir = appSupportURL.appendingPathComponent("QBMenubar")
            try? FileManager.default.createDirectory(at: qbDir, withIntermediateDirectories: true)
            let fileURL = qbDir.appendingPathComponent(fileName)
            try? encoded.write(to: fileURL, options: .atomic)
        }
    }

    /// Loads the latest snapshot, attempting App Group suite, standard suite, App Group container, and Application Support.
    public static func loadSnapshot() -> WidgetData? {
        let decoder = JSONDecoder()

        // 1. App Group suite UserDefaults
        for groupID in candidateAppGroupIDs {
            if let userDefaults = UserDefaults(suiteName: groupID),
               let data = userDefaults.data(forKey: snapshotKey),
               let snapshot = try? decoder.decode(WidgetData.self, from: data) {
                return snapshot
            }
        }

        // 2. Standard UserDefaults
        if let data = UserDefaults.standard.data(forKey: snapshotKey),
           let snapshot = try? decoder.decode(WidgetData.self, from: data) {
            return snapshot
        }

        // 3. App Group Container directory file
        for groupID in candidateAppGroupIDs {
            if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID) {
                let fileURL = containerURL.appendingPathComponent(fileName)
                if let data = try? Data(contentsOf: fileURL),
                   let snapshot = try? decoder.decode(WidgetData.self, from: data) {
                    return snapshot
                }
            }
        }

        // 4. Application Support fallback file
        if let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let fileURL = appSupportURL.appendingPathComponent("QBMenubar").appendingPathComponent(fileName)
            if let data = try? Data(contentsOf: fileURL),
               let snapshot = try? decoder.decode(WidgetData.self, from: data) {
                return snapshot
            }
        }

        return nil
    }
}
