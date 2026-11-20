import SwiftUI
import Charts

public struct SpeedChartView: View {
    public var points: [SpeedHistoryPoint]
    public var currentDLSpeed: Int64
    public var currentUPSpeed: Int64

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Speed header metrics
            HStack(alignment: .firstTextBaseline) {
                HStack(spacing: 4) {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundStyle(.green)
                    Text(ByteCountFormatter.string(fromByteCount: currentDLSpeed, countStyle: .file) + "/s")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.primary)
                }

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundStyle(.blue)
                    Text(ByteCountFormatter.string(fromByteCount: currentUPSpeed, countStyle: .file) + "/s")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(.primary)
                }
            }

            // Real-time Wave Chart
            if points.count >= 2 {
                Chart {
                    ForEach(points) { point in
                        // Download Area
                        AreaMark(
                            x: .value("Time", point.timestamp),
                            y: .value("Download", point.downloadSpeed)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.green.opacity(0.35), .green.opacity(0.02)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .interpolationMethod(.monotone)

                        // Download Line
                        LineMark(
                            x: .value("Time", point.timestamp),
                            y: .value("Download", point.downloadSpeed)
                        )
                        .foregroundStyle(.green)
                        .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        .interpolationMethod(.monotone)

                        // Upload Line
                        LineMark(
                            x: .value("Time", point.timestamp),
                            y: .value("Upload", point.uploadSpeed)
                        )
                        .foregroundStyle(.blue.opacity(0.85))
                        .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4, 3]))
                        .interpolationMethod(.monotone)
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .chartLegend(.hidden)
                .frame(height: 52)
                .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8), value: points)
            } else {
                HStack {
                    Spacer()
                    Text("正在采集实时带宽数据...")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .frame(height: 52)
            }
        }
        .glassCard(cornerRadius: 12, padding: 10, opacity: 0.5)
    }
}
