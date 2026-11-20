import SwiftUI
import AppKit

public struct GlassTextField: View {
    public let placeholder: String
    @Binding public var text: String
    public var isMonospaced: Bool = false
    public var isSecure: Bool = false
    public var width: CGFloat? = 220
    @FocusState private var isFocused: Bool

    public init(
        placeholder: String,
        text: Binding<String>,
        isMonospaced: Bool = false,
        isSecure: Bool = false,
        width: CGFloat? = 220
    ) {
        self.placeholder = placeholder
        self._text = text
        self.isMonospaced = isMonospaced
        self.isSecure = isSecure
        self.width = width
    }

    public var body: some View {
        HStack(spacing: 6) {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(.plain)
                    .font(isMonospaced ? .system(size: 12, design: .monospaced) : .system(size: 12))
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(.plain)
                    .font(isMonospaced ? .system(size: 12, design: .monospaced) : .system(size: 12))
                    .focused($isFocused)
            }
        }
        .padding(.horizontal, 9)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .fill(Color.primary.opacity(isFocused ? 0.08 : 0.05))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 7, style: .continuous)
                .strokeBorder(
                    isFocused
                        ? LinearGradient(
                            colors: [Color.accentColor.opacity(0.85), Color.accentColor.opacity(0.40)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        : LinearGradient(
                            colors: [Color.white.opacity(0.24), Color.white.opacity(0.06)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                    lineWidth: isFocused ? 1.0 : 0.65
                )
        )
        .modifier(FrameModifier(width: width))
    }
}

private struct FrameModifier: ViewModifier {
    let width: CGFloat?

    func body(content: Content) -> some View {
        if let width = width {
            content.frame(width: width)
        } else {
            content.frame(maxWidth: .infinity)
        }
    }
}
