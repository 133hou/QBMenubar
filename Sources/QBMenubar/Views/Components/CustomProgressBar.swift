import SwiftUI

public struct CustomProgressBar: View {
    public var progress: Double // 0.0 ~ 1.0
    public var gradientColors: [Color]
    public var height: CGFloat = 6

    public init(
        progress: Double,
        gradientColors: [Color] = [.blue, .cyan],
        height: CGFloat = 6
    ) {
        self.progress = max(0.0, min(1.0, progress))
        self.gradientColors = gradientColors
        self.height = height
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                // Background Track
                Capsule(style: .continuous)
                    .fill(Color.primary.opacity(0.08))
                    .frame(height: height)

                // Fill
                Capsule(style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: max(height, proxy.size.width * CGFloat(progress)), height: height)
                    .animation(AppMotion.liveData, value: progress)
            }
        }
        .frame(height: height)
    }
}
