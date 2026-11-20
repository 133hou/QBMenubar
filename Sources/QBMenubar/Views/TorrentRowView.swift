import SwiftUI

public struct TorrentRowView: View {
    public let torrent: Torrent
    public let isExpanded: Bool
    public let files: [TorrentFile]?
    public let isLoadingFiles: Bool
    public let isPinned: Bool
    public var isEnglish: Bool = false

    public let onToggleExpand: () -> Void
    public let onPauseResume: () -> Void
    public let onDelete: (Bool) -> Void
    public let onOpenFolder: () -> Void
    public let onRecheck: () -> Void
    public let onTogglePin: () -> Void

    private var statusColor: Color {
        if torrent.isDownloading { return .green }
        if torrent.isSeeding { return .blue }
        if torrent.isPaused { return .secondary }
        if torrent.isError { return .red }
        return .orange
    }

    private var progressColors: [Color] {
        if torrent.isDownloading { return [.green, .mint] }
        if torrent.isSeeding { return [.blue, .cyan] }
        if torrent.isPaused { return [.secondary.opacity(0.6), .secondary.opacity(0.4)] }
        return [.orange, .yellow]
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            // Row 1: State Pill + Expand Badge + Action Buttons
            HStack(alignment: .center, spacing: 6) {
                // State Badge
                HStack(spacing: 3) {
                    Circle()
                        .fill(statusColor)
                        .frame(width: 5, height: 5)
                    Text(torrent.localizedStateDescription(isEn: isEnglish))
                        .font(.system(size: 10, weight: .semibold))
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(statusColor.opacity(0.12))
                .foregroundStyle(statusColor)
                .clipShape(Capsule())

                // Expand files toggle button
                Button(action: onToggleExpand) {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 8, weight: .bold))
                            .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        Text(isExpanded ? (isEnglish ? "Hide" : "收起文件") : (isEnglish ? "Files" : "查看文件"))
                            .font(.system(size: 10))
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 2)
                    .background(Color.primary.opacity(0.05))
                    .clipShape(Capsule())
                    .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)

                Spacer()

                // Action Buttons (Pin, Pause/Resume, Folder, More)
                HStack(spacing: 5) {
                    Button(action: onTogglePin) {
                        Image(systemName: isPinned ? "pin.fill" : "pin")
                            .font(.system(size: 9))
                            .foregroundStyle(isPinned ? Color.accentColor : .secondary)
                            .frame(width: 22, height: 22)
                            .background(isPinned ? Color.accentColor.opacity(0.16) : Color.primary.opacity(0.07))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .help(isPinned ? "取消在菜单栏显示" : "在菜单栏显示此任务完成度")

                    Button(action: onPauseResume) {
                        Image(systemName: torrent.isPaused ? "play.fill" : "pause.fill")
                            .font(.system(size: 9))
                            .frame(width: 22, height: 22)
                            .background(Color.primary.opacity(0.07))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .help(torrent.isPaused ? "恢复任务" : "暂停任务")

                    if let path = torrent.savePath, !path.isEmpty {
                        Button(action: onOpenFolder) {
                            Image(systemName: "folder")
                                .font(.system(size: 10))
                                .frame(width: 22, height: 22)
                                .background(Color.primary.opacity(0.07))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .help(isEnglish ? "Show in Finder" : "在 Finder 中打开")
                    }

                    Menu {
                        Button(
                            isPinned
                                ? (isEnglish ? "Unpin from Menu Bar" : "取消在菜单栏显示")
                                : (isEnglish ? "Pin Task Progress to Menu Bar" : "在菜单栏显示此任务进度"),
                            action: onTogglePin
                        )
                        Divider()
                        Button(isEnglish ? "Force Recheck" : "重新校验完整性", action: onRecheck)
                        Divider()
                        Button(isEnglish ? "Delete Task (Keep Files)" : "删除任务 (保留文件)") { onDelete(false) }
                        Button(isEnglish ? "Delete Task and Local Files" : "删除任务及本地文件", role: .destructive) { onDelete(true) }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 10))
                            .frame(width: 22, height: 22)
                            .background(Color.primary.opacity(0.07))
                            .clipShape(Circle())
                    }
                    .menuStyle(.borderlessButton)
                    .menuIndicator(.hidden)
                    .frame(width: 22, height: 22)
                }
            }

            // Row 2: Prominent Torrent Task Name (Up to 2 lines, unclipped, full tooltip)
            Text(torrent.name)
                .font(.system(size: 12, weight: .semibold))
                .lineLimit(2)
                .truncationMode(.middle)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(.primary)
                .help(torrent.name)

            // Row 3: Progress Bar
            CustomProgressBar(progress: torrent.progress, gradientColors: progressColors, height: 5)

            // Row 4: Metrics (Progress %, Sizes, Speed, ETA)
            HStack(spacing: 6) {
                Text(String(format: "%.1f%%", torrent.progress * 100))
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)

                Text("•")
                    .font(.system(size: 9))
                    .foregroundStyle(.secondary)

                Text("\(torrent.formattedCompletedSize) / \(torrent.formattedSize)")
                    .font(.system(size: 10, design: .rounded))
                    .foregroundStyle(.secondary)

                Spacer(minLength: 4)

                if torrent.isDownloading {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 8, weight: .bold))
                        Text(torrent.formattedDLSpeed)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                    }
                    .foregroundStyle(.green)

                    if torrent.eta > 0 && torrent.eta < 8640000 {
                        Text("ETA \(torrent.formattedETA)")
                            .font(.system(size: 10, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                } else if torrent.isSeeding {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 8, weight: .bold))
                        Text(torrent.formattedUPSpeed)
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                    }
                    .foregroundStyle(.blue)

                    if let ratio = torrent.ratio {
                        Text(isEnglish ? String(format: "Ratio %.2f", ratio) : String(format: "比率 %.2f", ratio))
                            .font(.system(size: 10, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                } else if torrent.isPaused {
                    Text(isEnglish ? "Paused" : "已暂停")
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                }
            }

            // Expandable Internal Files List
            if isExpanded {
                TorrentFilesListView(files: files, isLoading: isLoadingFiles)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .top)),
                            removal: .opacity
                        )
                    )
            }
        }
        .glassCard(cornerRadius: 10, padding: 10, isInteractive: true)
        .contextMenu {
            Button(
                isPinned
                    ? (isEnglish ? "Unpin from Menu Bar" : "取消在菜单栏显示")
                    : (isEnglish ? "Pin Task Progress to Menu Bar" : "在菜单栏显示此任务进度"),
                action: onTogglePin
            )
            Divider()
            Button(
                torrent.isPaused
                    ? (isEnglish ? "Resume Task" : "恢复任务")
                    : (isEnglish ? "Pause Task" : "暂停任务"),
                action: onPauseResume
            )
            if let path = torrent.savePath, !path.isEmpty {
                Button(isEnglish ? "Show in Finder" : "在 Finder 中定位文件", action: onOpenFolder)
            }
            Button(isEnglish ? "Force Recheck" : "重新校验完整性", action: onRecheck)
            Divider()
            Button(isEnglish ? "Delete Task (Keep Files)" : "删除任务 (保留文件)") { onDelete(false) }
            Button(isEnglish ? "Delete Task and Local Files" : "删除任务及本地文件", role: .destructive) { onDelete(true) }
        }
        .animation(AppMotion.expand, value: isExpanded)
    }
}
