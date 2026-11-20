import SwiftUI

public struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 12
    var padding: CGFloat = 12
    var isInteractive: Bool = false

    @ViewBuilder
    public func body(content: Content) -> some View {
        if #available(macOS 26.0, *) {
            content
                .padding(padding)
                .glassEffect(isInteractive ? .regular.interactive() : .regular, in: .rect(cornerRadius: cornerRadius))
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.22),
                                    .white.opacity(0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.5
                        )
                )
                .shadow(color: .black.opacity(0.04), radius: 4, x: 0, y: 2)
        } else {
            content
                .padding(padding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.18),
                                    .white.opacity(0.04)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 3)
        }
    }
}

/// Adaptive container that uses `GlassEffectContainer` on macOS 26.0+ to share sampling buffers
/// and prevent border tearing / distortion across adjacent glass surfaces.
public struct AdaptiveGlassContainer<Content: View>: View {
    var spacing: CGFloat? = 8
    @ViewBuilder var content: () -> Content

    public init(spacing: CGFloat? = 8, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        if #available(macOS 26.0, *) {
            GlassEffectContainer(spacing: spacing) {
                content()
            }
        } else {
            content()
        }
    }
}

public extension View {
    func glassCard(cornerRadius: CGFloat = 12, padding: CGFloat = 12, isInteractive: Bool = false) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, padding: padding, isInteractive: isInteractive))
    }

    @available(*, deprecated, message: "Setting opacity < 1 on glass violates Liquid Glass Hard Rule 6 (refraction collapses). Use isInteractive instead.")
    func glassCard(cornerRadius: CGFloat = 12, padding: CGFloat = 12, opacity: Double) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, padding: padding, isInteractive: false))
    }
}

