import Foundation
import SwiftUI
import AppKit

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

    public func localizedTitle(isEn: Bool) -> String {
        if isEn {
            switch self {
            case .all: return "All"
            case .downloading: return "Downloading"
            case .seeding: return "Seeding"
            case .paused: return "Paused"
            }
        }
        return rawValue
    }
}

@Observable
@MainActor
public final class QBMenubarViewModel {
    public var config: APIConfig {
        didSet {
            config.save()
            Task {
                await service.updateConfig(config)
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

    public var service: QBittorrentService
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
        self.service = QBittorrentService(config: loadedConfig)
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
            // First attempt to test/login
            if case .disconnected = connectionState {
                connectionState = .connecting
            }

            _ = try await service.login()
            let (_, ping) = try await service.testConnection()
            connectionState = .connected(ping: ping)

            // Fetch speed and transfer
            async let transferTask = service.fetchTransferInfo()
            async let speedModeTask = service.fetchSpeedLimitsMode()
            async let torrentsTask = service.fetchTorrents()

            let (newTransfer, newSpeedMode, newTorrents) = try await (transferTask, speedModeTask, torrentsTask)

            self.transferInfo = newTransfer
            self.isAltSpeedLimits = newSpeedMode
            self.torrents = newTorrents

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
        } catch {
            let errorMsg = error.localizedDescription
            connectionState = .error(errorMsg)
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

        for t in newTorrents {
            // 1. Download Started Notification
            if !knownTorrentHashes.contains(t.hash) {
                knownTorrentHashes.insert(t.hash)
                if config.notifyOnStart {
                    NotificationManager.shared.sendNotification(
                        title: "📥 下载已开始",
                        subtitle: t.name,
                        body: "大小: \(t.formattedSize) • \(t.stateDescription)",
                        savePath: t.savePath
                    )
                }
            }

            // 2. Download Completed Notification
            let isDone = t.progress >= 1.0 || t.state == "pausedUP" || t.state == "uploading"
            if isDone && !completedTorrentHashes.contains(t.hash) {
                completedTorrentHashes.insert(t.hash)
                if config.notifyOnComplete {
                    NotificationManager.shared.sendNotification(
                        title: "🎉 下载已完成",
                        subtitle: t.name,
                        body: "已完成 \(t.formattedSize) 的下载，点击在 Finder 中定位",
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
        guard let url = URL(string: config.normalizedBaseURL) else { return }
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
}
