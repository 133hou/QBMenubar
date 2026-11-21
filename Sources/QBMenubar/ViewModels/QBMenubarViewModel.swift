import Foundation
import SwiftUI
import AppKit
import QBMenubarShared
#if canImport(WidgetKit)
import WidgetKit
#endif

public enum ConnectionState: Equatable, Sendable {
    case disconnected
    case connecting
    case connected(ping: Int)
    case error(String)
}

public enum FilterTab: String, CaseIterable, Identifiable, Sendable {
    case all = "全部"
    case downloading = "下载中"
    case seeding = "做种中"
    case paused = "已暂停"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        if !lang.isChinese {
            switch self {
            case .all: return "All"
            case .downloading: return "Downloading"
            case .seeding: return "Seeding"
            case .paused: return "Paused"
            }
        } else if lang.isTraditionalChinese {
            switch self {
            case .all: return "全部"
            case .downloading: return "下載中"
            case .seeding: return "做種中"
            case .paused: return "已暫停"
            }
        }
        return rawValue
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }
}

@Observable
@MainActor
public final class QBMenubarViewModel {
    public var config: APIConfig {
        didSet {
            config.save()
            Task {
                if config.clientType != oldValue.clientType {
                    self.service = TorrentServiceFactory.create(for: config)
                } else {
                    await service.updateConfig(config)
                }
                await refresh()
            }
        }
    }

    public var transferInfo = TransferInfo()
    public var torrents: [Torrent] = []
    public var isAltSpeedLimits: Bool = false
    public var connectionState: ConnectionState = .disconnected
    public var speedHistory: [SpeedHistoryPoint] = []
    public var expandedTorrentHash: String? = nil
    public var torrentFiles: [String: [TorrentFile]] = [:]
    public var isLoadingFiles: [String: Bool] = [:]
    public var selectedTab: FilterTab = .all
    public var isSettingsPresented: Bool = false
    public var bannerMessage: String? = nil

    public var isConnected: Bool {
        if case .connected = connectionState { return true }
        return false
    }

    public var service: any TorrentClientService
    @ObservationIgnored
    private var pollingTask: Task<Void, Never>?
    @ObservationIgnored
    private var knownTorrentHashes: Set<String> = []
    @ObservationIgnored
    private var completedTorrentHashes: Set<String> = []
    @ObservationIgnored
    private var isFirstPoll: Bool = true

    public var isMock: Bool = false

    public init(isMock: Bool = false) {
        self.isMock = isMock
        let loadedConfig = APIConfig.load()
        self.config = loadedConfig
        self.service = TorrentServiceFactory.create(for: loadedConfig)
        if !isMock {
            startPolling()
        }
    }

    isolated deinit {
        pollingTask?.cancel()
    }

    // MARK: - Polling

    public func startPolling() {
        if isMock { return }
        pollingTask?.cancel()
        pollingTask = Task { [weak self] in
            while !Task.isCancelled {
                guard let self = self else { break }
                await self.refresh()
                let interval = UInt64(max(1.0, self.config.pollInterval) * 1_000_000_000)
                try? await Task.sleep(nanoseconds: interval)
            }
        }
    }

    public func stopPolling() {
        pollingTask?.cancel()
        pollingTask = nil
    }

    public func refresh() async {
        if isMock { return }
        do {
            // Only perform initial login if currently disconnected
            if case .disconnected = connectionState {
                connectionState = .connecting
                _ = try await service.login()
                let (_, ping) = try await service.testConnection()
                connectionState = .connected(ping: ping)
            }

            // Fetch speed and transfer using existing session cookie (non-blocking)
            async let transferTask = service.fetchTransferInfo()
            async let speedModeTask = service.fetchSpeedLimitsMode()
            async let torrentsTask = service.fetchTorrents()

            let (newTransfer, newSpeedMode, newTorrents) = try await (transferTask, speedModeTask, torrentsTask)

            self.transferInfo = newTransfer
            self.isAltSpeedLimits = newSpeedMode
            self.torrents = newTorrents

            if case .connected = connectionState {
                // maintain connected
            } else {
                connectionState = .connected(ping: 1)
            }

            // Process notifications for download started & completed
            checkNotifications(newTorrents: newTorrents)

            // Record to chart history
            let point = SpeedHistoryPoint(
                downloadBytes: newTransfer.dlInfoSpeed,
                uploadBytes: newTransfer.upInfoSpeed
            )
            speedHistory.append(point)
            let maxPoints = max(10, config.chartHistorySeconds)
            if speedHistory.count > maxPoints {
                speedHistory.removeFirst(speedHistory.count - maxPoints)
            }

            // If an item is expanded, refresh its files
            if let expandedHash = expandedTorrentHash {
                await fetchFiles(for: expandedHash)
            }

            // Sync snapshot for macOS Desktop & Notification Center Widget
            updateWidgetSnapshot()
        } catch {
            // When request fails (e.g. cookie expired), attempt re-auth once
            if let _ = try? await service.login(), let (_, ping) = try? await service.testConnection() {
                connectionState = .connected(ping: ping)
                updateWidgetSnapshot()
            } else {
                let errorMsg = error.localizedDescription
                connectionState = .error(errorMsg)
                updateWidgetSnapshotDisconnected()
            }
        }
    }

    private func checkNotifications(newTorrents: [Torrent]) {
        if isFirstPoll {
            for t in newTorrents {
                knownTorrentHashes.insert(t.hash)
                if t.progress >= 1.0 || t.state == "pausedUP" || t.state == "uploading" {
                    completedTorrentHashes.insert(t.hash)
                }
            }
            isFirstPoll = false
            return
        }

        guard config.enableNotifications else { return }

        let lang = config.language
        for t in newTorrents {
            // 1. Download Started Notification
            if !knownTorrentHashes.contains(t.hash) {
                knownTorrentHashes.insert(t.hash)
                if config.notifyOnStart {
                    let title = L10n.tr(lang, zhHans: "📥 下载已开始", zhHant: "📥 下載已開始", en: "📥 Download Started")
                    let body = L10n.tr(
                        lang,
                        zhHans: "大小: \(t.formattedSize) • \(t.stateDescription)",
                        zhHant: "大小: \(t.formattedSize) • \(t.localizedStateDescription(lang: lang))",
                        en: "Size: \(t.formattedSize) • \(t.localizedStateDescription(lang: lang))"
                    )
                    NotificationManager.shared.sendNotification(
                        title: title,
                        subtitle: t.name,
                        body: body,
                        savePath: t.savePath
                    )
                }
            }

            // 2. Download Completed Notification
            let isDone = t.progress >= 1.0 || t.state == "pausedUP" || t.state == "uploading"
            if isDone && !completedTorrentHashes.contains(t.hash) {
                completedTorrentHashes.insert(t.hash)
                if config.notifyOnComplete {
                    let title = L10n.tr(lang, zhHans: "🎉 下载已完成", zhHant: "🎉 下載已完成", en: "🎉 Download Completed")
                    let body = L10n.tr(
                        lang,
                        zhHans: "已完成 \(t.formattedSize) 的下载，点击在 Finder 中定位",
                        zhHant: "已完成 \(t.formattedSize) 的下載，點擊在 Finder 中定位",
                        en: "Finished downloading \(t.formattedSize). Click to reveal in Finder."
                    )
                    NotificationManager.shared.sendNotification(
                        title: title,
                        subtitle: t.name,
                        body: body,
                        savePath: t.savePath
                    )
                }
            }
        }

        // Clean up removed torrent hashes
        let currentHashes = Set(newTorrents.map { $0.hash })
        knownTorrentHashes = knownTorrentHashes.intersection(currentHashes)
        completedTorrentHashes = completedTorrentHashes.intersection(currentHashes)
    }

    // MARK: - Filtered Torrents

    public var filteredTorrents: [Torrent] {
        switch selectedTab {
        case .all:
            return torrents
        case .downloading:
            return torrents.filter { $0.isDownloading }
        case .seeding:
            return torrents.filter { $0.isSeeding }
        case .paused:
            return torrents.filter { $0.isPaused }
        }
    }

    // MARK: - Torrent Detail & Files

    public func toggleExpandTorrent(_ hash: String) {
        if expandedTorrentHash == hash {
            expandedTorrentHash = nil
        } else {
            expandedTorrentHash = hash
            Task {
                await fetchFiles(for: hash)
            }
        }
    }

    public func fetchFiles(for hash: String) async {
        guard isLoadingFiles[hash] != true else { return }
        isLoadingFiles[hash] = true
        defer { isLoadingFiles[hash] = false }

        do {
            let files = try await service.fetchTorrentFiles(hash: hash)
            self.torrentFiles[hash] = files
        } catch {
            // keep old if failed
        }
    }

    // MARK: - Actions

    public func toggleAltSpeedLimits() {
        Task {
            do {
                try await service.toggleSpeedLimitsMode()
                isAltSpeedLimits.toggle()
                showBanner("已\(isAltSpeedLimits ? "开启" : "关闭")备用限速 🐢")
            } catch {
                showBanner("切换限速失败: \(error.localizedDescription)")
            }
        }
    }

    public func pauseTorrent(_ hash: String) {
        Task {
            do {
                try await service.pauseTorrents(hashes: [hash])
                await refresh()
            } catch {
                showBanner("暂停失败: \(error.localizedDescription)")
            }
        }
    }

    public func resumeTorrent(_ hash: String) {
        Task {
            do {
                try await service.resumeTorrents(hashes: [hash])
                await refresh()
            } catch {
                showBanner("恢复失败: \(error.localizedDescription)")
            }
        }
    }

    public func pauseAll() {
        Task {
            do {
                try await service.pauseTorrents(hashes: ["all"])
                await refresh()
                showBanner("已暂停所有任务")
            } catch {
                showBanner("操作失败: \(error.localizedDescription)")
            }
        }
    }

    public func resumeAll() {
        Task {
            do {
                try await service.resumeTorrents(hashes: ["all"])
                await refresh()
                showBanner("已恢复所有任务")
            } catch {
                showBanner("操作失败: \(error.localizedDescription)")
            }
        }
    }

    public func deleteTorrent(_ hash: String, deleteFiles: Bool) {
        Task {
            do {
                try await service.deleteTorrents(hashes: [hash], deleteFiles: deleteFiles)
                if expandedTorrentHash == hash {
                    expandedTorrentHash = nil
                }
                await refresh()
                showBanner(deleteFiles ? "已彻底删除任务与文件" : "已删除任务")
            } catch {
                showBanner("删除失败: \(error.localizedDescription)")
            }
        }
    }

    public func recheckTorrent(_ hash: String) {
        Task {
            do {
                try await service.recheckTorrents(hashes: [hash])
                await refresh()
                showBanner("已触发校验")
            } catch {
                showBanner("校验失败: \(error.localizedDescription)")
            }
        }
    }

    public func addFromClipboard() {
        guard let string = NSPasteboard.general.string(forType: .string)?.trimmingCharacters(in: .whitespacesAndNewlines),
              !string.isEmpty else {
            showBanner("剪贴板中没有文本")
            return
        }

        if string.starts(with: "magnet:") || string.starts(with: "http://") || string.starts(with: "https://") {
            Task {
                do {
                    try await service.addTorrent(urls: [string])
                    await refresh()
                    showBanner("已成功添加下载任务 📥")
                } catch {
                    showBanner("添加失败: \(error.localizedDescription)")
                }
            }
        } else {
            showBanner("剪贴板内容不是有效下载链接")
        }
    }

    public func openInFinder(path: String?) {
        guard let path = path, !path.isEmpty else { return }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if FileManager.default.fileExists(atPath: path) {
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: path)
            } else {
                Task { @MainActor in
                    self?.showBanner("本地路径不存在或为远程服务器路径")
                }
            }
        }
    }

    public func openWebUI() {
        let targetURLString: String
        if config.clientType == .transmission {
            targetURLString = config.normalizedBaseURL + "/transmission/web/"
        } else {
            targetURLString = config.normalizedBaseURL
        }
        guard let url = URL(string: targetURLString) else { return }
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.activates = true
        // Use non-blocking asynchronous LaunchServices API to eliminate main-thread UI hitching
        NSWorkspace.shared.open(url, configuration: configuration) { _, _ in }
    }

    // MARK: - Add Torrent Dialog

    public func showAddTorrentDialog(fileURL: URL? = nil) {
        AddTorrentWindowController.shared.show(viewModel: self, initialFileURL: fileURL)
    }

    // MARK: - Menu Bar Task Progress Pinning

    public var pinnedTorrent: Torrent? {
        guard config.showPinnedProgress else { return nil }
        let target = config.pinnedTorrentHash ?? "auto"
        if target == "none" {
            return nil
        }
        if target == "auto" {
            // Find most active downloading task, or first downloading task, or first unfinished task, or first torrent
            return torrents.filter { $0.isDownloading && $0.dlspeed > 0 }.max(by: { $0.dlspeed < $1.dlspeed })
                ?? torrents.first(where: { $0.isDownloading })
                ?? torrents.first(where: { $0.progress < 1.0 && !$0.isPaused })
                ?? torrents.first(where: { $0.progress < 1.0 })
                ?? torrents.first
        }
        return torrents.first(where: { $0.hash.caseInsensitiveCompare(target) == .orderedSame })
    }

    public var pinnedTorrentProgressText: String? {
        guard let torrent = pinnedTorrent else { return nil }
        let pct = torrent.progress * 100.0
        if pct >= 100.0 {
            return "100%"
        } else if pct >= 99.9 {
            return "99.9%"
        } else if pct < 10.0 && pct > 0 {
            return String(format: "%.1f%%", pct)
        } else {
            return String(format: "%.0f%%", pct)
        }
    }

    public func togglePinTorrent(_ torrent: Torrent) {
        if config.pinnedTorrentHash?.caseInsensitiveCompare(torrent.hash) == .orderedSame {
            config.pinnedTorrentHash = "auto"
            showBanner("已恢复菜单栏自动选择任务")
        } else {
            config.pinnedTorrentHash = torrent.hash
            config.showPinnedProgress = true
            showBanner("📌 已在菜单栏固定显示「\(torrent.name)」进度")
        }
        config.save()
    }

    public func isTorrentPinned(_ torrent: Torrent) -> Bool {
        return config.pinnedTorrentHash?.caseInsensitiveCompare(torrent.hash) == .orderedSame
    }

    public func setPinnedTorrentHash(_ hash: String?) {
        config.pinnedTorrentHash = hash
        if hash != nil && hash != "none" {
            config.showPinnedProgress = true
        }
        config.save()
    }

    private func showBanner(_ message: String) {
        self.bannerMessage = message
        Task {
            try? await Task.sleep(nanoseconds: 2_500_000_000)
            if self.bannerMessage == message {
                self.bannerMessage = nil
            }
        }
    }

    // MARK: - Widget Snapshot Sync

    public func updateWidgetSnapshot() {
        guard config.enableWidgetSync else {
            let disabledSnapshot = WidgetData.disabled(permissionDenied: false)
            WidgetDataManager.saveSnapshot(disabledSnapshot)
            #if canImport(WidgetKit)
            WidgetCenter.shared.reloadTimelines(ofKind: WidgetDataManager.widgetKind)
            #endif
            return
        }

        let hasPermission = WidgetDataManager.checkGroupContainerPermission()
        guard hasPermission else {
            let noPermSnapshot = WidgetData.disabled(permissionDenied: true)
            WidgetDataManager.saveSnapshot(noPermSnapshot)
            #if canImport(WidgetKit)
            WidgetCenter.shared.reloadTimelines(ofKind: WidgetDataManager.widgetKind)
            #endif
            return
        }

        let sorted = torrents.sorted { (t1, t2) -> Bool in
            if let pinned = config.pinnedTorrentHash, pinned != "auto", pinned != "none" {
                if t1.hash.caseInsensitiveCompare(pinned) == .orderedSame { return true }
                if t2.hash.caseInsensitiveCompare(pinned) == .orderedSame { return false }
            }
            if t1.isDownloading != t2.isDownloading {
                return t1.isDownloading && !t2.isDownloading
            }
            if t1.dlspeed != t2.dlspeed {
                return t1.dlspeed > t2.dlspeed
            }
            return t1.progress > t2.progress
        }

        let widgetTasks: [WidgetTorrentTask] = sorted.prefix(10).map { t in
            let speedStr = t.isDownloading ? t.formattedDLSpeed : (t.isSeeding ? t.formattedUPSpeed : "0 B/s")
            return WidgetTorrentTask(
                id: t.hash,
                name: t.name,
                progress: t.progress,
                progressPercent: Int(t.progress * 100),
                dlspeed: t.dlspeed,
                upspeed: t.upspeed,
                speedFormatted: speedStr,
                sizeFormatted: t.formattedSize,
                completedFormatted: t.formattedCompletedSize,
                etaFormatted: t.formattedETA,
                state: t.state,
                isDownloading: t.isDownloading,
                isSeeding: t.isSeeding,
                isPaused: t.isPaused
            )
        }

        let activeDL = torrents.filter { $0.isDownloading }.count
        let activeUP = torrents.filter { $0.isSeeding }.count
        let paused = torrents.filter { $0.isPaused }.count

        let snapshot = WidgetData(
            updatedAt: Date(),
            isConnected: isConnected,
            dlSpeed: transferInfo.dlInfoSpeed,
            upSpeed: transferInfo.upInfoSpeed,
            dlSpeedFormatted: transferInfo.formattedDLSpeed,
            upSpeedFormatted: transferInfo.formattedUPSpeed,
            activeDownloadsCount: activeDL,
            activeSeedsCount: activeUP,
            pausedCount: paused,
            totalCount: torrents.count,
            tasks: widgetTasks,
            syncEnabled: true,
            permissionGranted: true,
            statusMessage: nil,
            progressStyle: config.widgetProgressStyle
        )

        WidgetDataManager.saveSnapshot(snapshot)
        #if canImport(WidgetKit)
        WidgetCenter.shared.reloadTimelines(ofKind: WidgetDataManager.widgetKind)
        #endif
    }

    public func updateWidgetSnapshotDisconnected() {
        guard config.enableWidgetSync else { return }
        guard WidgetDataManager.checkGroupContainerPermission() else { return }

        var snapshot = WidgetDataManager.loadSnapshot() ?? WidgetData.placeholder
        snapshot.isConnected = false
        snapshot.updatedAt = Date()
        snapshot.dlSpeed = 0
        snapshot.upSpeed = 0
        snapshot.dlSpeedFormatted = "0 B/s"
        snapshot.upSpeedFormatted = "0 B/s"
        WidgetDataManager.saveSnapshot(snapshot)
        #if canImport(WidgetKit)
        WidgetCenter.shared.reloadTimelines(ofKind: WidgetDataManager.widgetKind)
        #endif
    }
}
