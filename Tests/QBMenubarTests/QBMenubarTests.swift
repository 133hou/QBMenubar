import Testing
import Foundation
@testable import QBMenubar
@testable import QBMenubarShared

@Suite("Bencode Parser Tests")
struct BencodeParserTests {
    @Test func testParseInteger() throws {
        let data = "i42e".data(using: .utf8)!
        let parser = BencodeParser(data: data)
        let value = try parser.parse()
        #expect(value.intValue == 42)
    }

    @Test func testParseNegativeInteger() throws {
        let data = "i-100e".data(using: .utf8)!
        let parser = BencodeParser(data: data)
        let value = try parser.parse()
        #expect(value.intValue == -100)
    }

    @Test func testParseString() throws {
        let data = "4:spam".data(using: .utf8)!
        let parser = BencodeParser(data: data)
        let value = try parser.parse()
        #expect(value.stringValue == "spam")
    }

    @Test func testParseList() throws {
        let data = "l4:spami42ee".data(using: .utf8)!
        let parser = BencodeParser(data: data)
        let value = try parser.parse()
        if case .list(let items) = value {
            #expect(items.count == 2)
            #expect(items[0].stringValue == "spam")
            #expect(items[1].intValue == 42)
        } else {
            Issue.record("Expected list value")
        }
    }

    @Test func testParseDictionary() throws {
        let data = "d3:bar4:spam3:fooi42ee".data(using: .utf8)!
        let parser = BencodeParser(data: data)
        let value = try parser.parse()
        if case .dict(let dict) = value {
            #expect(dict["bar"]?.stringValue == "spam")
            #expect(dict["foo"]?.intValue == 42)
        } else {
            Issue.record("Expected dict value")
        }
    }
}

@Suite("APIConfig & Formatting Tests")
struct APIConfigTests {
    @Test func testNormalizedBaseURL() {
        let config1 = APIConfig(baseURL: "192.168.1.100:8080/")
        #expect(config1.normalizedBaseURL == "http://192.168.1.100:8080")

        let config2 = APIConfig(baseURL: "https://myqbit.local///")
        #expect(config2.normalizedBaseURL == "https://myqbit.local")
    }

    @Test func testEndpointURL() {
        let config = APIConfig(baseURL: "http://127.0.0.1:8080", apiPrefix: "/api/v2")
        let url = config.endpointURL(for: "/torrents/info")
        #expect(url?.absoluteString == "http://127.0.0.1:8080/api/v2/torrents/info")
    }

    @Test func testFormatSpeed() {
        #expect(APIConfig.formatSpeed(0) == "0 KB/s")
        #expect(APIConfig.formatSpeed(512 * 1024) == "512 KB/s")
        #expect(APIConfig.formatSpeed(12 * 1024 * 1024) == "12.0 MB/s")
        #expect(APIConfig.formatSpeed(2 * 1024 * 1024 * 1024) == "2.00 GB/s")
    }

    @Test func testFormatBytes() {
        let formatted = APIConfig.formatBytes(1_000_000_000)
        #expect(!formatted.isEmpty)
    }
}

@Suite("Localization Coverage Tests")
struct LocalizationTests {
    @Test func testAllLanguagesHaveValidStrings() {
        for lang in AppLanguage.allCases {
            #expect(!L10n.general(lang).isEmpty)
            #expect(!L10n.webUIConnection(lang).isEmpty)
            #expect(!L10n.menuBar(lang).isEmpty)
            #expect(!L10n.notifications(lang).isEmpty)
            #expect(!L10n.advanced(lang).isEmpty)
            #expect(!L10n.about(lang).isEmpty)
            #expect(!L10n.serverAddress(lang).isEmpty)
            #expect(!L10n.testConnectionButton(lang).isEmpty)
            #expect(!L10n.pauseAll(lang).isEmpty)
            #expect(!L10n.resumeAll(lang).isEmpty)
            #expect(!L10n.altSpeeds(lang).isEmpty)
        }
    }

    @Test func testSettingsCategoryProperties() {
        for category in SettingsCategory.allCases {
            #expect(!category.iconName.isEmpty)
            #expect(!category.localizedTitle(lang: .en).isEmpty)
            #expect(!category.localizedTitle(lang: .zhHans).isEmpty)
            #expect(!category.localizedTitle(lang: .ja).isEmpty)
        }
    }

    @Test func testFilterTabProperties() {
        for tab in FilterTab.allCases {
            for lang in AppLanguage.allCases {
                #expect(!tab.localizedTitle(lang: lang).isEmpty)
            }
        }
    }
}

@Suite("Torrent Model Tests")
struct TorrentModelTests {
    @Test func testTorrentProperties() {
        let torrent = Torrent(
            hash: "abcd1234ef",
            name: "ArchLinux-2026.iso",
            size: 2_000_000_000,
            progress: 0.75,
            dlspeed: 5_242_880,
            upspeed: 104_857,
            eta: 120,
            state: "downloading"
        )

        #expect(torrent.id == "abcd1234ef")
        #expect(torrent.name == "ArchLinux-2026.iso")
        #expect(torrent.progress == 0.75)
        #expect(torrent.dlspeed == 5_242_880)
    }
}

@Suite("Widget Data & Storage Tests")
struct WidgetDataTests {
    @Test func testWidgetDataSerialization() throws {
        let sample = WidgetData.sample
        let encoded = try JSONEncoder().encode(sample)
        let decoded = try JSONDecoder().decode(WidgetData.self, from: encoded)

        #expect(decoded.tasks.count == sample.tasks.count)
        #expect(decoded.dlSpeedFormatted == sample.dlSpeedFormatted)
        #expect(decoded.tasks.first?.name == sample.tasks.first?.name)
        #expect(decoded.tasks.first?.progressPercent == 74)
        #expect(decoded.progressStyle == .circularGlass)

        // Test with linear style
        var linearData = sample
        linearData.progressStyle = .linear
        let linearEncoded = try JSONEncoder().encode(linearData)
        let linearDecoded = try JSONDecoder().decode(WidgetData.self, from: linearEncoded)
        #expect(linearDecoded.progressStyle == .linear)

        // Test backward compatibility fallback with missing progressStyle
        let legacyJSON = """
        {
            "updatedAt": 0,
            "isConnected": true,
            "dlSpeed": 1000,
            "upSpeed": 500,
            "dlSpeedFormatted": "1 KB/s",
            "upSpeedFormatted": "500 B/s",
            "activeDownloadsCount": 1,
            "activeSeedsCount": 0,
            "pausedCount": 0,
            "totalCount": 1,
            "tasks": [],
            "syncEnabled": true,
            "permissionGranted": true
        }
        """.data(using: .utf8)!
        let legacyDecoded = try JSONDecoder().decode(WidgetData.self, from: legacyJSON)
        #expect(legacyDecoded.progressStyle == .circularGlass)
    }

    @Test func testWidgetDataManagerSaveAndLoad() {
        let testData = WidgetData(
            updatedAt: Date(),
            isConnected: true,
            dlSpeed: 99_999,
            upSpeed: 11_111,
            dlSpeedFormatted: "99.9 KB/s",
            upSpeedFormatted: "11.1 KB/s",
            activeDownloadsCount: 5,
            activeSeedsCount: 3,
            pausedCount: 1,
            totalCount: 9,
            tasks: [
                WidgetTorrentTask(
                    id: "unit_test_hash",
                    name: "Test ISO Task",
                    progress: 0.85,
                    progressPercent: 85,
                    dlspeed: 99_999,
                    upspeed: 0,
                    speedFormatted: "99.9 KB/s",
                    sizeFormatted: "1.0 GB",
                    completedFormatted: "850 MB",
                    etaFormatted: "15s",
                    state: "downloading",
                    isDownloading: true,
                    isSeeding: false,
                    isPaused: false
                )
            ]
        )

        WidgetDataManager.saveSnapshot(testData)
        let loaded = WidgetDataManager.loadSnapshot()

        #expect(loaded != nil)
        #expect(loaded?.dlSpeedFormatted == "99.9 KB/s")
        #expect(loaded?.tasks.first?.name == "Test ISO Task")
        #expect(loaded?.tasks.first?.progressPercent == 85)
    }
}
