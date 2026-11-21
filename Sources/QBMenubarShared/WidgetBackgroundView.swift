import SwiftUI
import WidgetKit

public struct WidgetBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.widgetRenderingMode) private var renderingMode

    public init() {}

    public var body: some View {
        ZStack {
            if renderingMode == .fullColor {
                // Adaptive Liquid Glass background styling
                LinearGradient(
                    colors: [
                        colorScheme == .dark
                            ? Color(nsColor: .windowBackgroundColor).opacity(0.95)
                            : Color.white.opacity(0.85),
                        colorScheme == .dark
                            ? Color(nsColor: .controlBackgroundColor).opacity(0.90)
                            : Color(nsColor: .windowBackgroundColor).opacity(0.92)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Azure accent glow in top-left
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(colorScheme == .dark ? 0.22 : 0.12),
                        Color.cyan.opacity(colorScheme == .dark ? 0.08 : 0.04),
                        Color.clear
                    ]),
                    center: .topLeading,
                    startRadius: 8,
                    endRadius: 220
                )
            } else {
                // In accented / vibrant mode, system provides tinted or translucent plate
                Color.clear
            }
        }
    }
}
