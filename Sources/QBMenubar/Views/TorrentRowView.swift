import SwiftUI

public struct TorrentRowView: View {
    public let torrent: Torrent
    public let isExpanded: Bool
    public let files: [TorrentFile]?
    public let isLoadingFiles: Bool
    public let isPinned: Bool
    public var lang: AppLanguage = .zhHans
    public var isEnglish: Bool { !lang.isChinese }

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
                    Text(torrent.localizedStateDescription(lang: lang))
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
                        Text(isExpanded ? L10n.hideFiles(lang) : L10n.showFiles(lang))
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
                    .help(isPinned ? L10n.unpinFromMenuBar(lang) : L10n.pinToMenuBar(lang))

                    Button(action: onPauseResume) {
                        Image(systemName: torrent.isPaused ? "play.fill" : "pause.fill")
                            .font(.system(size: 9))
                            .frame(width: 22, height: 22)
                            .background(Color.primary.opacity(0.07))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .help(torrent.isPaused ? L10n.resumeTask(lang) : L10n.pauseTask(lang))

                    if let path = torrent.savePath, !path.isEmpty {
                        Button(action: onOpenFolder) {
                            Image(systemName: "folder")
                                .font(.system(size: 10))
                                .frame(width: 22, height: 22)
                                .background(Color.primary.opacity(0.07))
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)
                        .help(L10n.showInFinder(lang))
                    }

                    Menu {
                        Button(
                            isPinned
                                ? L10n.unpinFromMenuBar(lang)
                                : L10n.pinToMenuBar(lang),
                            action: onTogglePin
                        )
                        Divider()
                        Button(L10n.forceRecheck(lang), action: onRecheck)
                        Divider()
                        Button(L10n.deleteTaskKeepFiles(lang)) { onDelete(false) }
                        Button(L10n.deleteTaskWithFiles(lang), role: .destructive) { onDelete(true) }
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
                        let ratioFormat = L10n.tr(lang, zhHans: "比率 %.2f", zhHant: "分享率 %.2f", en: "Ratio %.2f")
                        Text(String(format: ratioFormat, ratio))
                            .font(.system(size: 10, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                } else if torrent.isPaused {
                    Text(L10n.tr(lang, zhHans: "已暂停", zhHant: "已暫停", en: "Paused"))
                        .font(.system(size: 10))
                        .foregroundStyle(.secondary)
                }
            }

            // Expandable Internal Files List
            if isExpanded {
                TorrentFilesListView(files: files, isLoading: isLoadingFiles, lang: lang)
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
                    ? L10n.unpinFromMenuBar(lang)
                    : L10n.pinToMenuBar(lang),
                action: onTogglePin
            )
            Divider()
            Button(
                torrent.isPaused
                    ? L10n.resumeTask(lang)
                    : L10n.pauseTask(lang),
                action: onPauseResume
            )
            if let path = torrent.savePath, !path.isEmpty {
                Button(L10n.showInFinder(lang), action: onOpenFolder)
            }
            Button(L10n.forceRecheck(lang), action: onRecheck)
            Divider()
            Button(L10n.deleteTaskKeepFiles(lang)) { onDelete(false) }
            Button(L10n.deleteTaskWithFiles(lang), role: .destructive) { onDelete(true) }
        }
        .animation(AppMotion.expand, value: isExpanded)
    }
}
