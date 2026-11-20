import SwiftUI

public struct MenuBarHeaderView: View {
    public let viewModel: QBMenubarViewModel

    private var iconSize: CGFloat {
        CGFloat(viewModel.config.iconSize.points)
    }

    private var iconTheme: IconTheme {
        viewModel.config.iconTheme
    }

    private var arrowTheme: ArrowTheme {
        viewModel.config.arrowTheme
    }

    private func downloadArrowColor(dlSpeed: Int64) -> Color {
        switch arrowTheme {
        case .adaptive:
            return .primary
        case .white:
            return .white
        case .black:
            return .black
        case .dynamicColor:
            return dlSpeed > 0 ? .green : .secondary
        }
    }

    private func uploadArrowColor(upSpeed: Int64) -> Color {
        switch arrowTheme {
        case .adaptive:
            return .secondary
        case .white:
            return .white.opacity(0.85)
        case .black:
            return .black.opacity(0.85)
        case .dynamicColor:
            return upSpeed > 0 ? .blue : .secondary
        }
    }

    @ViewBuilder
    private var progressBadge: some View {
        if viewModel.config.showPinnedProgress, let progress = viewModel.pinnedTorrentProgressText {
            Text(progress)
                .font(.system(size: 9.5, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
                .padding(.horizontal, 4)
                .padding(.vertical, 1)
                .background(
                    Capsule()
                        .fill(Color.primary.opacity(0.12))
                )
        }
    }

    public var body: some View {
        HStack(spacing: 5) {
            switch viewModel.connectionState {
            case .connected:
                let dlSpeed = viewModel.transferInfo.dlInfoSpeed
                let upSpeed = viewModel.transferInfo.upInfoSpeed

                // 1. qBittorrent Logo Icon (Customizable size & theme)
                QBittorrentIcon(size: iconSize, theme: iconTheme)

                // 2. Speed Display according to user preference
                switch viewModel.config.menuBarStyle {
                case .downloadOnly:
                    // Default: Download Speed Only
                    HStack(spacing: 2) {
                        Text("↓")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(downloadArrowColor(dlSpeed: dlSpeed))
                        Text(APIConfig.formatSpeed(dlSpeed))
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundStyle(dlSpeed > 0 ? .primary : .secondary)
                    }
                    .fixedSize()

                    progressBadge

                case .twoLines:
                    // Two-line vertical layout (Upload top, Download bottom)
                    VStack(alignment: .leading, spacing: -1) {
                        HStack(spacing: 2) {
                            Text("↑")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundStyle(uploadArrowColor(upSpeed: upSpeed))
                            Text(APIConfig.formatSpeed(upSpeed))
                                .font(.system(size: 8.5, weight: .semibold, design: .monospaced))
                                .foregroundStyle(.secondary)
                        }

                        HStack(spacing: 2) {
                            Text("↓")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundStyle(downloadArrowColor(dlSpeed: dlSpeed))
                            Text(APIConfig.formatSpeed(dlSpeed))
                                .font(.system(size: 8.5, weight: .semibold, design: .monospaced))
                                .foregroundStyle(dlSpeed > 0 ? .primary : .secondary)
                        }
                    }
                    .fixedSize()

                    progressBadge

                case .singleLineBoth:
                    // Single line displaying both download and upload
                    HStack(spacing: 4) {
                        HStack(spacing: 2) {
                            Text("↓")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(downloadArrowColor(dlSpeed: dlSpeed))
                            Text(APIConfig.formatSpeed(dlSpeed))
                                .font(.system(size: 11, weight: .medium, design: .rounded))
                        }

                        HStack(spacing: 2) {
                            Text("↑")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(uploadArrowColor(upSpeed: upSpeed))
                            Text(APIConfig.formatSpeed(upSpeed))
                                .font(.system(size: 11, weight: .regular, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .fixedSize()

                    progressBadge
                }

                // 3. Alternative Speed Limit indicator
                if viewModel.isAltSpeedLimits {
                    Text("🐢")
                        .font(.system(size: 10))
                }

            case .connecting:
                QBittorrentIcon(size: iconSize, theme: iconTheme)
                ProgressView()
                    .scaleEffect(0.5)
                    .frame(width: 12, height: 12)
                Text(L10n.tr(viewModel.config.language, zhHans: "连接中", zhHant: "連線中", en: "Connecting"))
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)

            case .disconnected, .error:
                QBittorrentIcon(size: iconSize, theme: iconTheme)
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 10))
                    .foregroundStyle(.orange)
                Text(L10n.tr(viewModel.config.language, zhHans: "离线", zhHant: "離線", en: "Offline"))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.orange)
            }
        }
    }
}
