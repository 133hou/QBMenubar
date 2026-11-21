import SwiftUI
import WidgetKit
import QBMenubarShared

public struct TorrentProgressWidget: Widget {
    public let kind: String = WidgetDataManager.widgetKind

    public init() {}

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TorrentTimelineProvider()) { entry in
            TorrentWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    WidgetBackgroundView()
                }
        }
        .configurationDisplayName("qBittorrent")
        .description("Monitor active downloads, transfer speeds, and task progress.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Previews

#Preview(as: .systemSmall) {
    TorrentProgressWidget()
} timeline: {
    TorrentEntry(date: Date(), data: .sample)
}

#Preview(as: .systemMedium) {
    TorrentProgressWidget()
} timeline: {
    TorrentEntry(date: Date(), data: .sample)
}

#Preview(as: .systemLarge) {
    TorrentProgressWidget()
} timeline: {
    TorrentEntry(date: Date(), data: .sample)
}
