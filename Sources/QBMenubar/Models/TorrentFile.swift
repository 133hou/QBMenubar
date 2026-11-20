import Foundation

public struct TorrentFile: Codable, Identifiable, Sendable, Equatable {
    public var id: Int { index }

    public let index: Int
    public let name: String
    public let size: Int64
    public let progress: Double
    public let priority: Int
    public let isSeed: Bool?

    enum CodingKeys: String, CodingKey {
        case index
        case name
        case size
        case progress
        case priority
        case isSeed = "is_seed"
    }

    public init(
        index: Int,
        name: String,
        size: Int64 = 0,
        progress: Double = 0.0,
        priority: Int = 1,
        isSeed: Bool? = nil
    ) {
        self.index = index
        self.name = name
        self.size = size
        self.progress = progress
        self.priority = priority
        self.isSeed = isSeed
    }

    public var fileName: String {
        (name as NSString).lastPathComponent
    }

    public var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }

    public var systemIconName: String {
        let ext = (name as NSString).pathExtension.lowercased()
        switch ext {
        case "mp4", "mkv", "avi", "mov", "wmv", "flv", "webm":
            return "film"
        case "mp3", "flac", "wav", "aac", "ogg", "m4a":
            return "music.note"
        case "zip", "rar", "7z", "tar", "gz":
            return "archivebox"
        case "iso", "img", "dmg":
            return "opticaldisc"
        case "pdf", "epub", "mobi":
            return "book.closed"
        case "jpg", "jpeg", "png", "webp", "gif":
            return "photo"
        case "txt", "nfo", "md":
            return "doc.plaintext"
        default:
            return "doc"
        }
    }
}
