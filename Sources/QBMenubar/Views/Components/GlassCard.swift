import SwiftUI

public struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 12
    var padding: CGFloat = 12
    var backgroundOpacity: Double = 0.55

    public func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .opacity(backgroundOpacity)
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

public extension View {
    func glassCard(cornerRadius: CGFloat = 12, padding: CGFloat = 12, opacity: Double = 0.65) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, padding: padding, backgroundOpacity: opacity))
    }
}
