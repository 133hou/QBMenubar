import SwiftUI
import AppKit

public struct AppHeroIconView: View {
    public let size: CGFloat

    public init(size: CGFloat = 64) {
        self.size = size
    }

    public var body: some View {
        let squircleRadius = size * (185.0 / 824.0)

        if let nsImage = NSImage(named: "AppIcon") ?? (NSApp.applicationIconImage.isValid ? NSApp.applicationIconImage : nil),
           nsImage.size.width > 0 {
            Image(nsImage: nsImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .shadow(color: Color.blue.opacity(0.35), radius: 8, x: 0, y: 4)
        } else {
            // High-fidelity Liquid Glass vector fallback matching AppIcon.icns exactly
            ZStack {
                RoundedRectangle(cornerRadius: squircleRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.18, green: 0.54, blue: 0.98),
                                Color(red: 0.12, green: 0.42, blue: 0.88),
                                Color(red: 0.08, green: 0.28, blue: 0.74)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: squircleRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.28), Color.white.opacity(0.0)],
                                    startPoint: .top,
                                    endPoint: .center
                                )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: squircleRadius, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.70),
                                        Color.white.opacity(0.18),
                                        Color.blue.opacity(0.30)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.0
                            )
                    )
                    .shadow(color: Color(red: 0.12, green: 0.42, blue: 0.88).opacity(0.40), radius: 8, x: 0, y: 4)

                Text("qb")
                    .font(.system(size: size * (390.0 / 824.0), weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.30), radius: 1.5, x: 0, y: 1.0)
                    .offset(y: -size * 0.015)
            }
            .frame(width: size, height: size)
        }
    }
}
