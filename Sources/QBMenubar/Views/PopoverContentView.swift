import SwiftUI

public struct PopoverContentView: View {
    @Bindable var viewModel: QBMenubarViewModel

    private var isEn: Bool { viewModel.config.language == .en }

    public var body: some View {
        VStack(spacing: 0) {
            // 1. Top Header Bar
            HStack(spacing: 8) {
                // Connection Indicator + Title
                HStack(spacing: 6) {
                    Circle()
                        .fill(connectionColor)
                        .frame(width: 8, height: 8)

                    Text("qBittorrent")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.primary)

                    if case .connected(let ping) = viewModel.connectionState {
                        Text("\(ping)ms")
                            .font(.system(size: 9, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                // Actions: Add Torrent (+) / Paste from Clipboard / Settings / Refresh
                HStack(spacing: 7) {
                    Button {
                        viewModel.showAddTorrentDialog()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.tint)
                    }
                    .buttonStyle(.plain)
                    .help(isEn ? "Add .torrent File" : "添加上传种子文件 (.torrent)")

                    Button {
                        viewModel.addFromClipboard()
                    } label: {
                        Image(systemName: "doc.on.clipboard")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.tint)
                    }
                    .buttonStyle(.plain)
                    .help(isEn ? "Add Magnet or URL from Clipboard" : "从剪贴板粘贴添加磁力/下载链接")

                    Button {
                        SettingsWindowController.shared.show(viewModel: viewModel)
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .help(isEn ? "Preferences" : "偏好设置")

                    Button {
                        Task { await viewModel.refresh() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 12))
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                    .help(isEn ? "Refresh" : "刷新")
                }
            }
            .padding(.horizontal, 14)
            .padding(.top, 12)
            .padding(.bottom, 8)

            // Banner notification toast (if any)
            if let banner = viewModel.bannerMessage {
                HStack(spacing: 6) {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(.tint)
                    Text(banner)
                        .font(.system(size: 11, weight: .medium))
                    Spacer()
                }
                .glassCard(cornerRadius: 8, padding: 8, isInteractive: false)
                .padding(.horizontal, 14)
                .padding(.bottom, 6)
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            // 2. Bandwidth Wave Chart
            SpeedChartView(
                points: viewModel.speedHistory,
                currentDLSpeed: viewModel.transferInfo.dlInfoSpeed,
                currentUPSpeed: viewModel.transferInfo.upInfoSpeed
            )
            .padding(.horizontal, 14)
            .padding(.bottom, 8)

            // 3. Quick Action Buttons
            let isEn = viewModel.config.language == .en
            HStack(spacing: 6) {
                QuickActionButton(
                    title: isEn ? "Pause All" : "暂停全部",
                    icon: "pause.fill",
                    color: .orange
                ) {
                    viewModel.pauseAll()
                }

                QuickActionButton(
                    title: isEn ? "Resume All" : "全部继续",
                    icon: "play.fill",
                    color: .green
                ) {
                    viewModel.resumeAll()
                }

                QuickActionButton(
                    title: viewModel.isAltSpeedLimits ? (isEn ? "Alt Active" : "备用限速中") : (isEn ? "Alt Speeds" : "备用限速"),
                    icon: "tortoise.fill",
                    color: viewModel.isAltSpeedLimits ? .blue : .secondary
                ) {
                    viewModel.toggleAltSpeedLimits()
                }

                QuickActionButton(
                    title: "WebUI",
                    icon: "safari.fill",
                    color: .indigo
                ) {
                    viewModel.openWebUI()
                }
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 10)

            // 4. Torrent Filter Tabs & Menu Bar Pin Selector
            HStack(spacing: 6) {
                ForEach(FilterTab.allCases) { tab in
                    let count = countForTab(tab)
                    Button {
                        withAnimation(AppMotion.selection) {
                            viewModel.selectedTab = tab
                        }
                    } label: {
                        HStack(spacing: 3) {
                            Text(tab.localizedTitle(isEn: isEn))
                                .font(.system(size: 11, weight: viewModel.selectedTab == tab ? .semibold : .regular))
                            if count > 0 {
                                Text("\(count)")
                                    .font(.system(size: 9, weight: .bold, design: .rounded))
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 1)
                                    .background(viewModel.selectedTab == tab ? Color.primary.opacity(0.14) : Color.primary.opacity(0.06))
                                    .clipShape(Capsule())
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            viewModel.selectedTab == tab
                                ? Capsule().fill(Color.primary.opacity(0.12))
                                : Capsule().fill(Color.clear)
                        )
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(viewModel.selectedTab == tab ? .primary : .secondary)
                }

                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 8)

            Divider()
                .padding(.horizontal, 14)

            // 5. Scrollable Torrents List (With always visible, draggable scrollbar)
            ScrollView(.vertical) {
                AdaptiveGlassContainer(spacing: 8) {
                    VStack(spacing: 8) {
                        if viewModel.filteredTorrents.isEmpty {
                            VStack(spacing: 8) {
                                Image(systemName: "tray")
                                    .font(.system(size: 26))
                                    .foregroundStyle(.tertiary)
                                Text(emptyStateText)
                                    .font(.system(size: 11))
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            ForEach(viewModel.filteredTorrents) { torrent in
                                TorrentRowView(
                                    torrent: torrent,
                                    isExpanded: viewModel.expandedTorrentHash == torrent.hash,
                                    files: viewModel.torrentFiles[torrent.hash],
                                    isLoadingFiles: viewModel.isLoadingFiles[torrent.hash] == true,
                                    isPinned: viewModel.isTorrentPinned(torrent),
                                    isEnglish: isEn,
                                    onToggleExpand: {
                                        viewModel.toggleExpandTorrent(torrent.hash)
                                    },
                                    onPauseResume: {
                                        if torrent.isPaused {
                                            viewModel.resumeTorrent(torrent.hash)
                                        } else {
                                            viewModel.pauseTorrent(torrent.hash)
                                        }
                                    },
                                    onDelete: { deleteFiles in
                                        viewModel.deleteTorrent(torrent.hash, deleteFiles: deleteFiles)
                                    },
                                    onOpenFolder: {
                                        viewModel.openInFinder(path: torrent.savePath)
                                    },
                                    onRecheck: {
                                        viewModel.recheckTorrent(torrent.hash)
                                    },
                                    onTogglePin: {
                                        viewModel.togglePinTorrent(torrent)
                                    }
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
            }
            .scrollIndicators(.visible)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Divider()

            // 6. Bottom Status Footer
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "network")
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                    Text(isEn ? "DHT: \(viewModel.transferInfo.dhtNodes) nodes" : "DHT: \(viewModel.transferInfo.dhtNodes) 节点")
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                HStack(spacing: 8) {
                    Text(isEn ? "DL: \(APIConfig.formatBytes(viewModel.transferInfo.dlInfoData))" : "总下: \(APIConfig.formatBytes(viewModel.transferInfo.dlInfoData))")
                        .font(.system(size: 10, design: .rounded))
                        .foregroundStyle(.secondary)

                    Text(isEn ? "UL: \(APIConfig.formatBytes(viewModel.transferInfo.upInfoData))" : "总上: \(APIConfig.formatBytes(viewModel.transferInfo.upInfoData))")
                        .font(.system(size: 10, design: .rounded))
                        .foregroundStyle(.secondary)

                    Button(isEn ? "Quit" : "退出") {
                        NSApp.terminate(nil)
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
        }
        .frame(width: 380, height: 550)
        .background(.regularMaterial)
    }

    private var connectionColor: Color {
        switch viewModel.connectionState {
        case .connected: return .green
        case .connecting: return .yellow
        case .disconnected, .error: return .red
        }
    }

    private func countForTab(_ tab: FilterTab) -> Int {
        switch tab {
        case .all: return viewModel.torrents.count
        case .downloading: return viewModel.torrents.filter { $0.isDownloading }.count
        case .seeding: return viewModel.torrents.filter { $0.isSeeding }.count
        case .paused: return viewModel.torrents.filter { $0.isPaused }.count
        }
    }

    private var emptyStateText: String {
        if isEn {
            switch viewModel.connectionState {
            case .disconnected:
                return "Not Connected to qBittorrent"
            case .error(let error):
                return "Connection Error: \(error)"
            case .connecting:
                return "Connecting to qBittorrent WebUI..."
            case .connected:
                switch viewModel.selectedTab {
                case .all: return "No active torrents"
                case .downloading: return "No downloading torrents"
                case .seeding: return "No seeding torrents"
                case .paused: return "No paused torrents"
                }
            }
        } else {
            switch viewModel.connectionState {
            case .disconnected:
                return "未连接到 qBittorrent"
            case .error(let error):
                return "无法连接: \(error)"
            case .connecting:
                return "正在连接 qBittorrent WebUI..."
            case .connected:
                switch viewModel.selectedTab {
                case .all: return "暂无任何种子任务"
                case .downloading: return "当前没有正在下载的任务"
                case .seeding: return "当前没有做种中的任务"
                case .paused: return "当前没有暂停的任务"
                }
            }
        }
    }
}

private struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        if #available(macOS 26.0, *) {
            Button(action: action) {
                HStack(spacing: 3) {
                    Image(systemName: icon)
                        .font(.system(size: 8.5))
                    Text(title)
                        .font(.system(size: 9.5, weight: .medium))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 2)
            }
            .buttonStyle(.glass)
            .tint(color)
        } else {
            Button(action: action) {
                HStack(spacing: 4) {
                    Image(systemName: icon)
                        .font(.system(size: 9))
                    Text(title)
                        .font(.system(size: 10, weight: .medium))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.primary.opacity(0.06))
                )
                .foregroundStyle(color)
            }
            .buttonStyle(.plain)
        }
    }
}
