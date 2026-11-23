import SwiftUI
import AppKit

public struct MenuBarHeaderView: View {
    public let viewModel: QBMenubarViewModel

    public init(viewModel: QBMenubarViewModel) {
        self.viewModel = viewModel
    }

    private var iconSize: CGFloat {
        CGFloat(viewModel.config.iconSize.points)
    }

    private var iconTheme: IconTheme {
        viewModel.config.iconTheme
    }

    private var arrowTheme: ArrowTheme {
        viewModel.config.arrowTheme
    }

    // MARK: - SVG String for qBittorrent Icon
    private static let svgString = """
    <svg role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M11.911 23.994c-1.31 0-2.605-.232-3.831-.705-3.4-1.024-6.2-3.865-7.433-7.58-1.23-3.708-.685-7.654 1.459-10.554C4.062 2.038 7.677.094 11.742.008c4.064-.079 7.758 1.703 9.882 4.785a12.066 12.066 0 0 1 2.369 7.145c.138 3.733-1.75 7.368-5.052 9.728-2.147 1.535-4.61 2.328-7.03 2.328zm.11-22.314c-.081 0-.162 0-.244.002-3.5.074-6.599 1.725-8.29 4.415-1.856 2.516-2.31 5.893-1.25 9.086 1.06 3.197 3.448 5.636 6.386 6.523 3.025 1.165 6.496.633 9.345-1.402 2.847-2.035 4.473-5.144 4.351-8.318v-.032c0-2.214-.73-4.41-2.055-6.185-1.78-2.58-4.84-4.09-8.243-4.09zM9.406 20.246v-4.578a2.663 2.663 0 0 1-.952.863 2.573 2.573 0 0 1-1.29.344c-1.016 0-1.893-.444-2.63-1.33-.731-.887-1.097-2.102-1.097-3.646 0-.939.148-1.781.444-2.527.301-.746.734-1.309 1.299-1.69A3.26 3.26 0 0 1 7.052 7.1c1.058 0 1.891.487 2.5 1.46v-1.25h1.306v12.935H9.406zm-4.477-8.285c0 1.203.232 2.108.694 2.711.463.6 1.016.9 1.662.9.619 0 1.15-.286 1.597-.855.446-.576.67-1.447.67-2.615 0-1.245-.237-2.18-.71-2.81-.468-.627-1.02-.941-1.654-.941-.63 0-1.164.293-1.605.88-.435.581-.654 1.491-.654 2.73m9.55 4.702h-1.346V3.755h1.452v4.604c.613-.84 1.395-1.258 2.347-1.258.526 0 1.024.117 1.492.351.464.222.864.558 1.161.978.307.416.546.922.718 1.514.172.593.258 1.227.258 1.902 0 1.603-.363 2.841-1.088 3.716-.727.874-1.598 1.312-2.614 1.312-1.011 0-1.804-.46-2.379-1.382v1.17m-.016-4.746c0 1.122.14 1.932.42 2.432.456.815 1.074 1.223 1.854 1.223.635 0 1.183-.3 1.646-.898.462-.604.693-1.503.693-2.695 0-1.22-.224-2.122-.67-2.703-.44-.58-.975-.872-1.605-.872-.634 0-1.182.303-1.645.907-.463.6-.694 1.468-.694 2.607"/></svg>
    """

    @MainActor
    private static var svgCache: [CGFloat: NSImage] = [:]

    @MainActor
    private static var iconCache: [String: NSImage] = [:]

    @MainActor
    private static func getBaseSvg(size: CGFloat) -> NSImage? {
        if let cached = svgCache[size] {
            return cached
        }
        guard let data = svgString.data(using: .utf8),
              let img = NSImage(data: data) else { return nil }
        img.size = NSSize(width: size, height: size)
        img.isTemplate = true
        svgCache[size] = img
        return img
    }

    @MainActor
    private static func tintedImage(_ image: NSImage, color: NSColor) -> NSImage {
        let tinted = NSImage(size: image.size, flipped: false) { rect in
            image.draw(in: rect)
            color.set()
            rect.fill(using: .sourceAtop)
            return true
        }
        tinted.isTemplate = false
        return tinted
    }

    @MainActor
    private func makeIconNSImage(size: CGFloat, theme: IconTheme, isTemplate: Bool) -> NSImage? {
        let cacheKey = "\(size)-\(theme.rawValue)-\(isTemplate)"
        if let cached = Self.iconCache[cacheKey] {
            return cached
        }

        guard let base = Self.getBaseSvg(size: size) else { return nil }
        let result: NSImage

        if isTemplate {
            result = base
        } else {
            switch theme {
            case .adaptive:
                result = Self.tintedImage(base, color: NSColor.labelColor)
            case .white:
                result = Self.tintedImage(base, color: NSColor.white)
            case .black:
                result = Self.tintedImage(base, color: NSColor.black)
            case .original:
                let innerSize = size * 0.88
                guard let innerBase = Self.getBaseSvg(size: innerSize) else { return nil }
                let circleImg = NSImage(size: NSSize(width: size, height: size), flipped: false) { rect in
                    let circlePath = NSBezierPath(ovalIn: rect)
                    NSColor(srgbRed: 47/255.0, green: 103/255.0, blue: 186/255.0, alpha: 1.0).setFill()
                    circlePath.fill()

                    let innerOffset = (size - innerSize) / 2.0
                    let innerRect = NSRect(x: innerOffset, y: innerOffset, width: innerSize, height: innerSize)
                    let tintedInner = Self.tintedImage(innerBase, color: .white)
                    tintedInner.draw(in: innerRect)
                    return true
                }
                circleImg.isTemplate = false
                result = circleImg
            }
        }

        Self.iconCache[cacheKey] = result
        return result
    }

    // MARK: - Single Line Text Builder
    private func singleLineText(dlSpeed: Int64, upSpeed: Int64) -> String {
        var text = ""
        switch viewModel.config.menuBarStyle {
        case .downloadOnly:
            text = "↓ \(APIConfig.formatSpeed(dlSpeed))"
        case .singleLineBoth:
            text = "↓ \(APIConfig.formatSpeed(dlSpeed))  ↑ \(APIConfig.formatSpeed(upSpeed))"
        case .twoLines:
            break
        }

        if viewModel.config.showPinnedProgress, let progress = viewModel.pinnedTorrentProgressText {
            text += " \(progress)"
        }

        if viewModel.isAltSpeedLimits {
            text += " 🐢"
        }

        return text
    }

    // MARK: - Two-Line Retina NSImage Renderer
    @MainActor
    private func renderTwoLinesImage(
        dlSpeed: Int64,
        upSpeed: Int64,
        showProgress: Bool,
        progressText: String?,
        isAltSpeedLimits: Bool
    ) -> NSImage {
        let isTemplate = (iconTheme == .adaptive && arrowTheme == .adaptive)
        let size = iconSize

        // 1. Icon
        let iconImg = makeIconNSImage(size: size, theme: iconTheme, isTemplate: isTemplate)

        // 2. Prepare text attributes
        let arrowFont = NSFont.systemFont(ofSize: 8.5, weight: .bold)
        let speedFont = NSFont.monospacedDigitSystemFont(ofSize: 8.5, weight: .semibold)

        let dlArrowColor: NSColor
        let dlTextColor: NSColor
        let upArrowColor: NSColor
        let upTextColor: NSColor

        if isTemplate {
            dlArrowColor = NSColor.black
            dlTextColor = dlSpeed > 0 ? NSColor.black : NSColor.black.withAlphaComponent(0.65)
            upArrowColor = NSColor.black.withAlphaComponent(0.65)
            upTextColor = NSColor.black.withAlphaComponent(0.65)
        } else {
            switch arrowTheme {
            case .adaptive:
                dlArrowColor = NSColor.labelColor
                dlTextColor = dlSpeed > 0 ? NSColor.labelColor : NSColor.secondaryLabelColor
                upArrowColor = NSColor.secondaryLabelColor
                upTextColor = NSColor.secondaryLabelColor
            case .white:
                dlArrowColor = NSColor.white
                dlTextColor = dlSpeed > 0 ? NSColor.white : NSColor.white.withAlphaComponent(0.7)
                upArrowColor = NSColor.white.withAlphaComponent(0.85)
                upTextColor = NSColor.white.withAlphaComponent(0.85)
            case .black:
                dlArrowColor = NSColor.black
                dlTextColor = dlSpeed > 0 ? NSColor.black : NSColor.black.withAlphaComponent(0.7)
                upArrowColor = NSColor.black.withAlphaComponent(0.85)
                upTextColor = NSColor.black.withAlphaComponent(0.85)
            case .dynamicColor:
                dlArrowColor = dlSpeed > 0 ? NSColor.systemGreen : NSColor.secondaryLabelColor
                dlTextColor = dlSpeed > 0 ? NSColor.labelColor : NSColor.secondaryLabelColor
                upArrowColor = upSpeed > 0 ? NSColor.systemBlue : NSColor.secondaryLabelColor
                upTextColor = NSColor.secondaryLabelColor
            }
        }

        let upStr = NSMutableAttributedString(string: "↑ ", attributes: [.font: arrowFont, .foregroundColor: upArrowColor])
        upStr.append(NSAttributedString(string: APIConfig.formatSpeed(upSpeed), attributes: [.font: speedFont, .foregroundColor: upTextColor]))

        let dlStr = NSMutableAttributedString(string: "↓ ", attributes: [.font: arrowFont, .foregroundColor: dlArrowColor])
        dlStr.append(NSAttributedString(string: APIConfig.formatSpeed(dlSpeed), attributes: [.font: speedFont, .foregroundColor: dlTextColor]))

        let upSize = upStr.size()
        let dlSize = dlStr.size()
        let textWidth = max(upSize.width, dlSize.width)

        // 3. Progress badge
        var progressAttrStr: NSAttributedString? = nil
        var badgeWidth: CGFloat = 0
        var badgeHeight: CGFloat = 0
        if showProgress, let progress = progressText {
            let pFont = NSFont.boldSystemFont(ofSize: 9.0)
            let pTextColor: NSColor
            if isTemplate {
                pTextColor = NSColor.black
            } else {
                switch arrowTheme {
                case .white:
                    pTextColor = NSColor.white
                case .black:
                    pTextColor = NSColor.black
                default:
                    pTextColor = NSColor.labelColor
                }
            }
            let attr = NSAttributedString(string: progress, attributes: [.font: pFont, .foregroundColor: pTextColor])
            progressAttrStr = attr
            let pSize = attr.size()
            badgeWidth = pSize.width + 8
            badgeHeight = pSize.height + 2
        }

        // 4. Turtle
        var turtleAttrStr: NSAttributedString? = nil
        var turtleWidth: CGFloat = 0
        if isAltSpeedLimits {
            let tFont = NSFont.systemFont(ofSize: 10.0)
            let tAttr = NSAttributedString(string: "🐢", attributes: [.font: tFont])
            turtleAttrStr = tAttr
            turtleWidth = tAttr.size().width
        }

        // 5. Total width & layout
        let iconSpacing: CGFloat = 4
        let progressSpacing: CGFloat = 4
        let turtleSpacing: CGFloat = 3

        var totalWidth: CGFloat = size + iconSpacing + textWidth
        if progressAttrStr != nil {
            totalWidth += progressSpacing + badgeWidth
        }
        if turtleAttrStr != nil {
            totalWidth += turtleSpacing + turtleWidth
        }
        totalWidth = ceil(totalWidth)

        let totalHeight: CGFloat = 22.0

        let image = NSImage(size: NSSize(width: totalWidth, height: totalHeight), flipped: false) { rect in
            var x: CGFloat = 0

            // 1. Draw icon
            if let iconImg = iconImg {
                let iconY = (totalHeight - size) / 2.0
                iconImg.draw(in: NSRect(x: x, y: iconY, width: size, height: size))
            }
            x += size + iconSpacing

            // 2. Draw text lines
            dlStr.draw(at: NSPoint(x: x, y: 1.0))
            upStr.draw(at: NSPoint(x: x, y: 11.0))
            x += textWidth

            // 3. Draw progress badge
            if let pAttr = progressAttrStr {
                x += progressSpacing
                let badgeY = (totalHeight - badgeHeight) / 2.0
                let badgeRect = NSRect(x: x, y: badgeY, width: badgeWidth, height: badgeHeight)
                let cornerRadius = badgeHeight / 2.0
                let capsule = NSBezierPath(roundedRect: badgeRect, xRadius: cornerRadius, yRadius: cornerRadius)

                let badgeBgColor: NSColor
                if isTemplate {
                    badgeBgColor = NSColor.black.withAlphaComponent(0.14)
                } else {
                    switch arrowTheme {
                    case .white:
                        badgeBgColor = NSColor.white.withAlphaComponent(0.2)
                    case .black:
                        badgeBgColor = NSColor.black.withAlphaComponent(0.12)
                    default:
                        badgeBgColor = NSColor.labelColor.withAlphaComponent(0.12)
                    }
                }
                badgeBgColor.setFill()
                capsule.fill()

                pAttr.draw(at: NSPoint(x: x + 4, y: badgeY + 1))
                x += badgeWidth
            }

            // 4. Draw turtle
            if let tAttr = turtleAttrStr {
                x += turtleSpacing
                let tHeight = tAttr.size().height
                let tY = (totalHeight - tHeight) / 2.0
                tAttr.draw(at: NSPoint(x: x, y: tY))
                x += turtleWidth
            }

            return true
        }

        image.isTemplate = isTemplate
        return image
    }

    // MARK: - Body
    public var body: some View {
        switch viewModel.connectionState {
        case .connected:
            let dlSpeed = viewModel.transferInfo.dlInfoSpeed
            let upSpeed = viewModel.transferInfo.upInfoSpeed

            switch viewModel.config.menuBarStyle {
            case .twoLines:
                Image(nsImage: renderTwoLinesImage(
                    dlSpeed: dlSpeed,
                    upSpeed: upSpeed,
                    showProgress: viewModel.config.showPinnedProgress,
                    progressText: viewModel.pinnedTorrentProgressText,
                    isAltSpeedLimits: viewModel.isAltSpeedLimits
                ))

            case .downloadOnly, .singleLineBoth:
                HStack(spacing: 4) {
                    QBittorrentIcon(size: iconSize, theme: iconTheme)
                    Text(singleLineText(dlSpeed: dlSpeed, upSpeed: upSpeed))
                        .monospacedDigit()
                }
            }

        case .connecting:
            let connectingText = L10n.tr(viewModel.config.language, zhHans: "连接中", zhHant: "連線中", en: "Connecting")
            HStack(spacing: 4) {
                QBittorrentIcon(size: iconSize, theme: iconTheme)
                Text("… \(connectingText)")
            }

        case .disconnected, .error:
            let offlineText = L10n.tr(viewModel.config.language, zhHans: "离线", zhHant: "離線", en: "Offline")
            HStack(spacing: 4) {
                QBittorrentIcon(size: iconSize, theme: iconTheme)
                Text("⚠ \(offlineText)")
            }
        }
    }
}
