import Foundation
import WidgetKit

public struct TorrentEntry: TimelineEntry {
    public let date: Date
    public let data: WidgetData

    public init(date: Date, data: WidgetData) {
        self.date = date
        self.data = data
    }
}

public struct TorrentTimelineProvider: TimelineProvider {
    public init() {}

    public func placeholder(in context: Context) -> TorrentEntry {
        TorrentEntry(date: Date(), data: .sample)
    }

    public func getSnapshot(in context: Context, completion: @escaping (TorrentEntry) -> Void) {
        if context.isPreview {
            completion(TorrentEntry(date: Date(), data: .sample))
            return
        }
        let data = WidgetDataManager.loadSnapshot() ?? .placeholder
        completion(TorrentEntry(date: Date(), data: data))
    }

    public func getTimeline(in context: Context, completion: @escaping (Timeline<TorrentEntry>) -> Void) {
        let currentData = WidgetDataManager.loadSnapshot() ?? .placeholder
        let entry = TorrentEntry(date: Date(), data: currentData)
        let nextReload = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date().addingTimeInterval(300)
        let timeline = Timeline(entries: [entry], policy: .after(nextReload))
        completion(timeline)
    }
}
