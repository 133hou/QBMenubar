import SwiftUI
import WidgetKit

// MARK: - App Icon Badge

public struct QBIconBadge: View {
    public init() {}

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4.5, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.blue, Color(red: 0.1, green: 0.5, blue: 0.95)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 18, height: 18)

            Text("qb")
                .font(.system(size: 10, weight: .black, design: .rounded))
                .foregroundColor(.white)
                .offset(y: -0.5)
        }
    }
}

// MARK: - Progress Bar Component

public struct ProgressBarView: View {
    public let progress: Double
    public let height: CGFloat

    public init(progress: Double, height: CGFloat) {
        self.progress = progress
        self.height = height
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.secondary.opacity(0.18))
                    .frame(height: height)

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue, Color.cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(4, geo.size.width * CGFloat(min(max(progress, 0.0), 1.0))), height: height)
                    .widgetAccentable()
            }
        }
        .frame(height: height)
    }
}

// MARK: - Small Widget View

public struct TorrentSmallWidgetView: View {
    public let data: WidgetData

    public init(data: WidgetData) {
        self.data = data
    }

    private var activeTask: WidgetTorrentTask? {
        data.tasks.first(where: { $0.isDownloading }) ?? data.tasks.first
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Header Row
            HStack(spacing: 5) {
                QBIconBadge()
                Text("qBittorrent")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                Spacer()
                Circle()
                    .fill(data.isConnected ? Color.green : Color.orange)
                    .frame(width: 6, height: 6)
            }

            Spacer(minLength: 0)

            // Middle: Active Task or Idle State
            if let task = activeTask {
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.name)
                        .font(.system(size: 11, weight: .semibold))
                        .lineLimit(1)
                        .truncationMode(.middle)

                    ProgressBarView(progress: task.progress, height: 5)

                    HStack(alignment: .firstTextBaseline) {
                        Text("\(task.progressPercent)%")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .widgetAccentable()

                        Spacer()

                        Text(task.speedFormatted)
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                    }

                    HStack {
                        Text("\(task.completedFormatted) / \(task.sizeFormatted)")
                            .font(.system(size: 9))
                            .foregroundStyle(.secondary)

                        Spacer()

                        if task.isDownloading && !task.etaFormatted.isEmpty {
                            Text("⏱ \(task.etaFormatted)")
                                .font(.system(size: 9))
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            } else {
                VStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.green)
                        .widgetAccentable()

                    Text("All Tasks Done")
                        .font(.system(size: 11, weight: .semibold))

                    Text("\(data.activeSeedsCount) Seeding")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }

            Spacer(minLength: 0)

            // Bottom Speeds Summary
            HStack {
                Label(data.dlSpeedFormatted, systemImage: "arrow.down")
                    .font(.system(size: 9, weight: .semibold, design: .monospaced))
                    .foregroundColor(.blue)
                    .widgetAccentable()

                Spacer()

                Label(data.upSpeedFormatted, systemImage: "arrow.up")
                    .font(.system(size: 9, weight: .medium, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(2)
    }
}

// MARK: - Medium Widget View

public struct TorrentMediumWidgetView: View {
    public let data: WidgetData

    public init(data: WidgetData) {
        self.data = data
    }

    private var displayTasks: [WidgetTorrentTask] {
        let downloads = data.tasks.filter { $0.isDownloading }
        if !downloads.isEmpty {
            return Array(downloads.prefix(3))
        }
        return Array(data.tasks.prefix(3))
    }

    public var body: some View {
        HStack(spacing: 12) {
            // Left Column: Stats & Branding
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 5) {
                    QBIconBadge()
                    Text("qBittorrent")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                }

                Spacer(minLength: 0)

                VStack(alignment: .leading, spacing: 1) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.blue)
                            .widgetAccentable()
                        Text("DOWNLOAD")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundStyle(.secondary)
                    }
                    Text(data.dlSpeedFormatted)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        .widgetAccentable()
                }

                VStack(alignment: .leading, spacing: 1) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundColor(.green)
                        Text("UPLOAD")
                            .font(.system(size: 8, weight: .bold))
                            .foregroundStyle(.secondary)
                    }
                    Text(data.upSpeedFormatted)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)

                HStack(spacing: 4) {
                    Text("\(data.activeDownloadsCount) DL")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.blue.opacity(0.12)))

                    Text("\(data.activeSeedsCount) UP")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.green)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.green.opacity(0.12)))
                }
            }
            .frame(width: 95)

            // Divider
            Divider()
                .opacity(0.6)

            // Right Column: Task List
            VStack(alignment: .leading, spacing: 7) {
                if displayTasks.isEmpty {
                    VStack(spacing: 5) {
                        Image(systemName: "tray")
                            .font(.system(size: 22))
                            .foregroundStyle(.secondary)
                        Text("No Active Torrents")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(displayTasks) { task in
                        VStack(alignment: .leading, spacing: 3) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(task.name)
                                    .font(.system(size: 11, weight: .semibold))
                                    .lineLimit(1)
                                    .truncationMode(.middle)

                                Spacer()

                                Text("\(task.progressPercent)%")
                                    .font(.system(size: 11, weight: .bold, design: .rounded))
                                    .widgetAccentable()
                            }

                            ProgressBarView(progress: task.progress, height: 4.5)

                            HStack {
                                Text("\(task.completedFormatted) / \(task.sizeFormatted)")
                                    .font(.system(size: 8.5))
                                    .foregroundStyle(.secondary)

                                Spacer()

                                Text(task.speedFormatted)
                                    .font(.system(size: 8.5, weight: .medium, design: .monospaced))

                                if task.isDownloading && !task.etaFormatted.isEmpty {
                                    Text("• \(task.etaFormatted)")
                                        .font(.system(size: 8.5))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(2)
    }
}

// MARK: - Large Widget View

public struct TorrentLargeWidgetView: View {
    public let data: WidgetData

    public init(data: WidgetData) {
        self.data = data
    }

    private var displayTasks: [WidgetTorrentTask] {
        Array(data.tasks.prefix(5))
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack(spacing: 6) {
                QBIconBadge()
                Text("qBittorrent Dashboard")
                    .font(.system(size: 13, weight: .bold, design: .rounded))

                Spacer()

                HStack(spacing: 4) {
                    Circle()
                        .fill(data.isConnected ? Color.green : Color.orange)
                        .frame(width: 6, height: 6)
                    Text(data.isConnected ? "Connected" : "Offline")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(.secondary)
                }
            }

            // Transfer Summary Cards
            HStack(spacing: 8) {
                // DL Card
                VStack(alignment: .leading, spacing: 2) {
                    Label("Download", systemImage: "arrow.down")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.blue)
                        .widgetAccentable()
                    Text(data.dlSpeedFormatted)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        .widgetAccentable()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.blue.opacity(0.08)))

                // UP Card
                VStack(alignment: .leading, spacing: 2) {
                    Label("Upload", systemImage: "arrow.up")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.green)
                    Text(data.upSpeedFormatted)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .monospacedDigit()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.green.opacity(0.08)))

                // Counts Card
                VStack(alignment: .leading, spacing: 2) {
                    Text("Tasks")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(.secondary)
                    HStack(spacing: 4) {
                        Text("\(data.activeDownloadsCount) DL")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.blue)
                        Text("·")
                            .foregroundStyle(.secondary)
                        Text("\(data.activeSeedsCount) UP")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.green)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.secondary.opacity(0.08)))
            }

            Divider()

            // Task List
            VStack(alignment: .leading, spacing: 8) {
                if displayTasks.isEmpty {
                    VStack(spacing: 6) {
                        Image(systemName: "tray")
                            .font(.system(size: 28))
                            .foregroundStyle(.secondary)
                        Text("No Active Torrents")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(displayTasks) { task in
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Text(task.name)
                                    .font(.system(size: 11, weight: .semibold))
                                    .lineLimit(1)
                                    .truncationMode(.middle)

                                Spacer()

                                Text("\(task.progressPercent)%")
                                    .font(.system(size: 11, weight: .bold, design: .rounded))
                                    .widgetAccentable()
                            }

                            ProgressBarView(progress: task.progress, height: 4.5)

                            HStack {
                                Text("\(task.completedFormatted) / \(task.sizeFormatted)")
                                    .font(.system(size: 9))
                                    .foregroundStyle(.secondary)

                                Spacer()

                                Text(task.speedFormatted)
                                    .font(.system(size: 9, weight: .medium, design: .monospaced))

                                if task.isDownloading && !task.etaFormatted.isEmpty {
                                    Text("• ETA: \(task.etaFormatted)")
                                        .font(.system(size: 9))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Footer
            HStack {
                Text("Updated \(data.updatedAt, style: .time)")
                    .font(.system(size: 9))
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Click to open QBMenubar")
                    .font(.system(size: 9))
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(2)
    }
}

// MARK: - Entry View

public struct TorrentWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    public var entry: TorrentEntry

    public init(entry: TorrentEntry) {
        self.entry = entry
    }

    public var body: some View {
        Group {
            switch family {
            case .systemSmall:
                TorrentSmallWidgetView(data: entry.data)
            case .systemMedium:
                TorrentMediumWidgetView(data: entry.data)
            case .systemLarge:
                TorrentLargeWidgetView(data: entry.data)
            default:
                TorrentSmallWidgetView(data: entry.data)
            }
        }
        .widgetURL(URL(string: "qbmenubar://open"))
    }
}
