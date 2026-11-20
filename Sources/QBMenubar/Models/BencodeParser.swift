import Foundation

public enum BencodeError: Error, LocalizedError {
    case unexpectedEOF
    case invalidInteger
    case invalidStringLength
    case invalidDictKey
    case invalidByte(UInt8, Int)
    case missingInfoDictionary

    public var errorDescription: String? {
        switch self {
        case .unexpectedEOF:
            return "种子文件已损坏或不完整 (意外结束)"
        case .invalidInteger:
            return "解析种子整数格式错误"
        case .invalidStringLength:
            return "解析种子字符长度错误"
        case .invalidDictKey:
            return "字典键名解析错误"
        case .invalidByte(let byte, let index):
            return "解析错误，位置 \(index) 处存在非法字节: \(byte)"
        case .missingInfoDictionary:
            return "种子文件缺少必要的基础信息字典 (info)"
        }
    }
}

public enum BencodeValue: Sendable {
    case int(Int64)
    case string(Data)
    case list([BencodeValue])
    case dict([String: BencodeValue])

    public var stringValue: String? {
        if case .string(let data) = self {
            return String(data: data, encoding: .utf8) ?? String(decoding: data, as: UTF8.self)
        }
        return nil
    }

    public var rawData: Data? {
        if case .string(let data) = self { return data }
        return nil
    }

    public var intValue: Int64? {
        if case .int(let num) = self { return num }
        return nil
    }

    public var listValue: [BencodeValue]? {
        if case .list(let items) = self { return items }
        return nil
    }

    public var dictValue: [String: BencodeValue]? {
        if case .dict(let d) = self { return d }
        return nil
    }
}

public final class BencodeParser {
    private let data: Data
    private var index: Int = 0

    public init(data: Data) {
        self.data = data
        self.index = 0
    }

    public func parse() throws -> BencodeValue {
        index = 0
        return try parseValue()
    }

    private func parseValue() throws -> BencodeValue {
        guard index < data.count else { throw BencodeError.unexpectedEOF }
        let byte = data[index]
        if byte == UInt8(ascii: "i") {
            return try parseInteger()
        } else if byte == UInt8(ascii: "l") {
            return try parseList()
        } else if byte == UInt8(ascii: "d") {
            return try parseDictionary()
        } else if byte >= UInt8(ascii: "0") && byte <= UInt8(ascii: "9") {
            return try parseString()
        } else {
            throw BencodeError.invalidByte(byte, index)
        }
    }

    private func parseInteger() throws -> BencodeValue {
        index += 1 // skip 'i'
        var endIndex = index
        while endIndex < data.count && data[endIndex] != UInt8(ascii: "e") {
            endIndex += 1
        }
        guard endIndex < data.count else { throw BencodeError.unexpectedEOF }
        guard let numStr = String(data: data[index..<endIndex], encoding: .ascii),
              let num = Int64(numStr) else {
            throw BencodeError.invalidInteger
        }
        index = endIndex + 1 // skip 'e'
        return .int(num)
    }

    private func parseString() throws -> BencodeValue {
        var colonIndex = index
        while colonIndex < data.count && data[colonIndex] != UInt8(ascii: ":") {
            colonIndex += 1
        }
        guard colonIndex < data.count else { throw BencodeError.unexpectedEOF }
        guard let lenStr = String(data: data[index..<colonIndex], encoding: .ascii),
              let len = Int(lenStr), len >= 0 else {
            throw BencodeError.invalidStringLength
        }
        let strStart = colonIndex + 1
        let strEnd = strStart + len
        guard strEnd <= data.count else { throw BencodeError.unexpectedEOF }
        let strData = data.subdata(in: strStart..<strEnd)
        index = strEnd
        return .string(strData)
    }

    private func parseList() throws -> BencodeValue {
        index += 1 // skip 'l'
        var items: [BencodeValue] = []
        while index < data.count && data[index] != UInt8(ascii: "e") {
            items.append(try parseValue())
        }
        guard index < data.count else { throw BencodeError.unexpectedEOF }
        index += 1 // skip 'e'
        return .list(items)
    }

    private func parseDictionary() throws -> BencodeValue {
        index += 1 // skip 'd'
        var dict: [String: BencodeValue] = [:]
        while index < data.count && data[index] != UInt8(ascii: "e") {
            guard case .string(let keyData) = try parseValue() else {
                throw BencodeError.invalidDictKey
            }
            let key = String(data: keyData, encoding: .utf8) ?? String(decoding: keyData, as: UTF8.self)
            let val = try parseValue()
            dict[key] = val
        }
        guard index < data.count else { throw BencodeError.unexpectedEOF }
        index += 1 // skip 'e'
        return .dict(dict)
    }
}

public struct ParsedTorrentFileItem: Identifiable, Sendable {
    public var id: String { path }
    public let path: String
    public let fileName: String
    public let size: Int64

    public var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }

    public var systemIconName: String {
        let ext = (fileName as NSString).pathExtension.lowercased()
        switch ext {
        case "mp4", "mkv", "avi", "mov", "wmv", "flv", "webm", "m4v", "ts":
            return "play.rectangle.fill"
        case "mp3", "flac", "wav", "m4a", "aac", "ogg", "ape":
            return "music.note"
        case "zip", "rar", "7z", "tar", "gz", "iso", "dmg":
            return "doc.zipper"
        case "jpg", "jpeg", "png", "gif", "webp", "bmp", "svg":
            return "photo.fill"
        case "pdf", "epub", "mobi", "azw3":
            return "book.fill"
        case "txt", "nfo", "md", "json", "xml", "srt", "ass":
            return "doc.text.fill"
        case "exe", "app", "pkg", "deb", "rpm":
            return "shippingbox.fill"
        default:
            return "doc.fill"
        }
    }
}

public struct ParsedTorrentMeta: Identifiable, Sendable {
    public var id: String { name }
    public let name: String
    public let totalSize: Int64
    public let comment: String?
    public let createdBy: String?
    public let creationDate: Date?
    public let isMultiFile: Bool
    public let files: [ParsedTorrentFileItem]
    public let rawData: Data
    public let sourceFileName: String

    public var formattedTotalSize: String {
        ByteCountFormatter.string(fromByteCount: totalSize, countStyle: .file)
    }

    public static func parse(data: Data, originalFileName: String = "download.torrent") throws -> ParsedTorrentMeta {
        let parser = BencodeParser(data: data)
        let rootValue = try parser.parse()

        guard let rootDict = rootValue.dictValue,
              let infoDict = rootDict["info"]?.dictValue else {
            throw BencodeError.missingInfoDictionary
        }

        let name = infoDict["name.utf-8"]?.stringValue
            ?? infoDict["name"]?.stringValue
            ?? (originalFileName as NSString).deletingPathExtension

        let comment = rootDict["comment.utf-8"]?.stringValue ?? rootDict["comment"]?.stringValue
        let createdBy = rootDict["created by"]?.stringValue
        let creationDate: Date?
        if let timestamp = rootDict["creation date"]?.intValue {
            creationDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        } else {
            creationDate = nil
        }

        var files: [ParsedTorrentFileItem] = []
        var totalSize: Int64 = 0
        var isMulti = false

        if let filesList = infoDict["files"]?.listValue {
            // Multi-file torrent
            isMulti = true
            for item in filesList {
                guard let fileDict = item.dictValue else { continue }
                let fileSize = fileDict["length"]?.intValue ?? 0
                totalSize += fileSize

                var pathComponents: [String] = []
                if let pathList = (fileDict["path.utf-8"]?.listValue ?? fileDict["path"]?.listValue) {
                    for p in pathList {
                        if let s = p.stringValue {
                            pathComponents.append(s)
                        }
                    }
                }

                let fullPath = pathComponents.isEmpty ? name : pathComponents.joined(separator: "/")
                let fName = pathComponents.last ?? name
                files.append(ParsedTorrentFileItem(path: fullPath, fileName: fName, size: fileSize))
            }
        } else if let singleLength = infoDict["length"]?.intValue {
            // Single-file torrent
            isMulti = false
            totalSize = singleLength
            files.append(ParsedTorrentFileItem(path: name, fileName: name, size: singleLength))
        }

        return ParsedTorrentMeta(
            name: name,
            totalSize: totalSize,
            comment: comment,
            createdBy: createdBy,
            creationDate: creationDate,
            isMultiFile: isMulti,
            files: files,
            rawData: data,
            sourceFileName: originalFileName
        )
    }
}
