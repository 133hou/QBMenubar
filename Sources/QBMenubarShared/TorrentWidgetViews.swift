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

// MARK: - Arrow Head Shape

public struct ArrowHead: Shape {
    public init() {}

    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + w * 0.25, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Liquid Glass Circular Progress View

public struct LiquidGlassCircularProgressView: View {
    public let progress: Double
    public let size: CGFloat
    public let lineWidth: CGFloat
    public let iconName: String?
    public let centerText: String?
    public let tintColor: Color
    public let showArrow: Bool

    public init(
        progress: Double,
        size: CGFloat = 58,
        lineWidth: CGFloat? = nil,
        iconName: String? = "arrow.down",
        centerText: String? = nil,
        tintColor: Color = Color.blue,
        showArrow: Bool = true
    ) {
        self.progress = max(0.0, min(1.0, progress))
        self.size = size
        self.lineWidth = lineWidth ?? max(3.2, size * 0.10)
        self.iconName = iconName
        self.centerText = centerText
        self.tintColor = tintColor
        self.showArrow = showArrow
    }

    public var body: some View {
        let radius = (size - lineWidth) / 2
        let angle = Angle.degrees(progress * 360.0 - 90.0)
        let arrowSize: CGFloat = lineWidth * 1.6

        ZStack {
            // 1. Frosted Glass Background Track
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.14),
                            Color.white.opacity(0.04)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .frame(width: size - lineWidth, height: size - lineWidth)

            // Inner & outer subtle specular rim
            Circle()
                .stroke(Color.white.opacity(0.08), lineWidth: 0.6)
                .frame(width: size, height: size)
            Circle()
                .stroke(Color.black.opacity(0.35), lineWidth: 0.6)
                .frame(width: max(0, size - lineWidth * 2), height: max(0, size - lineWidth * 2))

            // 2. Active Liquid Glass Progress Arc
            if progress > 0.005 {
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(
                        LinearGradient(
                            colors: [
                                tintColor.opacity(0.7),
                                tintColor,
                                .white
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: (showArrow && progress > 0.05) ? .butt : .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: size - lineWidth, height: size - lineWidth)
                    .shadow(color: tintColor.opacity(0.45), radius: lineWidth * 0.5)
            }

            // 3. Directional Arrow Head at the Progress Tip
            if showArrow && progress > 0.04 && progress < 0.995 {
                let center = CGPoint(x: size / 2, y: size / 2)
                let x = center.x + radius * cos(CGFloat(angle.radians))
                let y = center.y + radius * sin(CGFloat(angle.radians))
                let tangentAngle = angle + Angle.degrees(90)

                ArrowHead()
                    .fill(Color.white)
                    .frame(width: arrowSize, height: arrowSize * 0.95)
                    .rotationEffect(tangentAngle)
                    .position(x: x, y: y)
                    .shadow(color: tintColor.opacity(0.6), radius: 2)
            }

            // 4. Center Floating Liquid Glass Squircle Button
            let innerSize = size * 0.52
            ZStack {
                // Glass Base
                RoundedRectangle(cornerRadius: innerSize * 0.28, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.20),
                                Color.white.opacity(0.06)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: innerSize, height: innerSize)
                    .background(
                        RoundedRectangle(cornerRadius: innerSize * 0.28, style: .continuous)
                            .fill(Color.black.opacity(0.35))
                    )
                    .shadow(color: Color.black.opacity(0.35), radius: 4, y: 2)

                // Glass Specular Rim Border
                RoundedRectangle(cornerRadius: innerSize * 0.28, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.7),
                                Color.white.opacity(0.12),
                                Color.white.opacity(0.05),
                                Color.white.opacity(0.35)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: max(0.8, innerSize * 0.035)
                    )
                    .frame(width: innerSize, height: innerSize)

                // Center Icon or Text
                if let centerText = centerText {
                    Text(centerText)
                        .font(.system(size: innerSize * 0.40, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 1, y: 1)
                } else if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.system(size: innerSize * 0.44, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, Color.white.opacity(0.85)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .shadow(color: Color.black.opacity(0.3), radius: 1, y: 1)
                }
            }
        }
        .frame(width: size + 4, height: size + 4)
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
            if !data.syncEnabled {
                VStack(spacing: 4) {
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 22))
                        .foregroundStyle(.secondary)

                    Text("Widget Disabled")
                        .font(.system(size: 11, weight: .semibold))

                    Text("Enable in Settings")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            } else if !data.permissionGranted {
                VStack(spacing: 4) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(.orange)

                    Text("Permission Required")
                        .font(.system(size: 10, weight: .semibold))

                    Text("Check System Settings")
                        .font(.system(size: 8.5))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            } else if let task = activeTask {
                if data.progressStyle == .circularGlass {
                    VStack(spacing: 3) {
                        LiquidGlassCircularProgressView(
                            progress: task.progress,
                            size: 54,
                            lineWidth: 5.5,
                            iconName: task.isDownloading ? "arrow.down" : (task.isSeeding ? "arrow.up" : "pause.fill"),
                            tintColor: task.isDownloading ? Color.blue : (task.isSeeding ? Color.green : Color.orange),
                            showArrow: true
                        )
                        .widgetAccentable()

                        Text(task.name)
                            .font(.system(size: 10, weight: .semibold))
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .padding(.top, 1)

                        HStack(spacing: 5) {
                            Text("\(task.progressPercent)%")
                                .font(.system(size: 11, weight: .bold, design: .rounded))
                                .foregroundStyle(task.isDownloading ? Color.blue : (task.isSeeding ? Color.green : Color.primary))
                                .widgetAccentable()

                            Text(task.speedFormatted)
                                .font(.system(size: 9.5, weight: .medium, design: .monospaced))

                            if task.isDownloading && !task.etaFormatted.isEmpty {
                                Text("• \(task.etaFormatted)")
                                    .font(.system(size: 8.5))
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                } else {
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
        if !data.syncEnabled {
            HStack(spacing: 12) {
                VStack(spacing: 6) {
                    QBIconBadge()
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 24))
                        .foregroundStyle(.secondary)
                }
                .frame(width: 50)

                Divider()

                VStack(alignment: .leading, spacing: 3) {
                    Text("Desktop Widget Sync Disabled")
                        .font(.system(size: 11, weight: .bold))
                    Text("Enable widget synchronization in QBMenubar Settings > Widgets to view live tasks and transfer speeds.")
                        .font(.system(size: 9.5))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(2)
        } else if !data.permissionGranted {
            HStack(spacing: 12) {
                VStack(spacing: 6) {
                    QBIconBadge()
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.orange)
                }
                .frame(width: 50)

                Divider()

                VStack(alignment: .leading, spacing: 3) {
                    Text("Data Sharing Permission Required")
                        .font(.system(size: 11, weight: .bold))
                    Text("macOS blocked access to shared widget data. Open QBMenubar Settings > Widgets and click 'Re-trigger Permission Prompt'.")
                        .font(.system(size: 9.5))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(2)
        } else {
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
                        if data.progressStyle == .circularGlass {
                            HStack(spacing: 8) {
                                LiquidGlassCircularProgressView(
                                    progress: task.progress,
                                    size: 28,
                                    lineWidth: 3.2,
                                    iconName: task.isDownloading ? "arrow.down" : (task.isSeeding ? "arrow.up" : "pause.fill"),
                                    tintColor: task.isDownloading ? Color.blue : (task.isSeeding ? Color.green : Color.orange),
                                    showArrow: true
                                )
                                .widgetAccentable()

                                VStack(alignment: .leading, spacing: 2) {
                                    HStack(alignment: .firstTextBaseline) {
                                        Text(task.name)
                                            .font(.system(size: 10.5, weight: .semibold))
                                            .lineLimit(1)
                                            .truncationMode(.middle)

                                        Spacer()

                                        Text("\(task.progressPercent)%")
                                            .font(.system(size: 10.5, weight: .bold, design: .rounded))
                                            .widgetAccentable()
                                    }

                                    HStack {
                                        Text(task.speedFormatted)
                                            .font(.system(size: 8.5, weight: .medium, design: .monospaced))

                                        if task.isDownloading && !task.etaFormatted.isEmpty {
                                            Text("• \(task.etaFormatted)")
                                                .font(.system(size: 8.5))
                                                .foregroundStyle(.secondary)
                                        }

                                        Spacer()

                                        Text("\(task.completedFormatted)/\(task.sizeFormatted)")
                                            .font(.system(size: 8.5))
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        } else {
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
            }
            .frame(maxWidth: .infinity)
        }
        .padding(2)
        }
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
        if !data.syncEnabled {
            VStack(spacing: 12) {
                HStack(spacing: 6) {
                    QBIconBadge()
                    Text("qBittorrent Dashboard")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                    Spacer()
                }

                Spacer()

                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 36))
                    .foregroundStyle(.secondary)

                Text("Desktop Widget Sync Disabled")
                    .font(.system(size: 14, weight: .bold))

                Text("Enable widget synchronization in QBMenubar Settings > Widgets to view real-time speeds, task progress, and queue statistics on your desktop.")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                Spacer()
            }
            .padding(4)
        } else if !data.permissionGranted {
            VStack(spacing: 12) {
                HStack(spacing: 6) {
                    QBIconBadge()
                    Text("qBittorrent Dashboard")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                    Spacer()
                }

                Spacer()

                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.orange)

                Text("Data Sharing Permission Required")
                    .font(.system(size: 14, weight: .bold))

                Text("macOS blocked cross-app access to widget data. Due to macOS 15+ security policies, please open QBMenubar Settings > Widgets to re-trigger authorization or grant access in System Settings > Privacy & Security.")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)

                Spacer()
            }
            .padding(4)
        } else {
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
                        if data.progressStyle == .circularGlass {
                            HStack(spacing: 9) {
                                LiquidGlassCircularProgressView(
                                    progress: task.progress,
                                    size: 30,
                                    lineWidth: 3.3,
                                    iconName: task.isDownloading ? "arrow.down" : (task.isSeeding ? "arrow.up" : "pause.fill"),
                                    tintColor: task.isDownloading ? Color.blue : (task.isSeeding ? Color.green : Color.orange),
                                    showArrow: true
                                )
                                .widgetAccentable()

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
                        } else {
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
