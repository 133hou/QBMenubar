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

    @Test func testSidebarSelectionStyle() throws {
        let defaultConfig = APIConfig.defaultConfig
        #expect(defaultConfig.sidebarSelectionStyle == .liquidGlass)

        var classicConfig = defaultConfig
        classicConfig.sidebarSelectionStyle = .classic
        let encoded = try JSONEncoder().encode(classicConfig)
        let decoded = try JSONDecoder().decode(APIConfig.self, from: encoded)
        #expect(decoded.sidebarSelectionStyle == .classic)

        // Test fallback when decoding older JSON without sidebarSelectionStyle
        let legacyJSON = """
        {
            "baseURL": "http://127.0.0.1:8080",
            "apiPrefix": "/api/v2",
            "username": "admin",
            "password": ""
        }
        """.data(using: .utf8)!
        let legacyDecoded = try JSONDecoder().decode(APIConfig.self, from: legacyJSON)
        #expect(legacyDecoded.sidebarSelectionStyle == .liquidGlass)
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
            #expect(!L10n.clientTypeTitle(lang).isEmpty)
            #expect(!L10n.clientTypeSubtitle(lang).isEmpty)
            #expect(!L10n.sidebarSelectionStyleTitle(lang).isEmpty)
            #expect(!L10n.sidebarSelectionStyleSubtitle(lang).isEmpty)
            #expect(!L10n.sidebarStyleLiquidGlass(lang).isEmpty)
            #expect(!L10n.sidebarStyleClassic(lang).isEmpty)
            #expect(!L10n.widgetProgressStyleSection(lang).isEmpty)
            #expect(!L10n.widgetProgressIndicatorTitle(lang).isEmpty)
            #expect(!L10n.widgetProgressIndicatorSubtitle(lang).isEmpty)
            #expect(!L10n.widgetStyleCircularGlass(lang).isEmpty)
            #expect(!L10n.widgetStyleLinear(lang).isEmpty)
            #expect(!L10n.fullDiskAccessTitle(lang).isEmpty)
            #expect(!L10n.liveAppearancePreview(lang).isEmpty)
            #expect(!L10n.settingsWindowTitle(lang).isEmpty)
            #expect(!L10n.addTorrentWindowTitle(lang).isEmpty)
            #expect(!L10n.bannerAltSpeed(lang, enabled: true).isEmpty)
            #expect(!L10n.bannerAltSpeed(lang, enabled: false).isEmpty)
            #expect(!L10n.bannerPausedAll(lang).isEmpty)
            #expect(!L10n.bannerResumedAll(lang).isEmpty)
            #expect(!L10n.bannerDeletedTorrent(lang, deleteFiles: true).isEmpty)
            #expect(!L10n.bannerDeletedTorrent(lang, deleteFiles: false).isEmpty)
            #expect(!L10n.bannerRechecking(lang).isEmpty)
            #expect(!L10n.bannerPausedOne(lang).isEmpty)
            #expect(!L10n.bannerResumedOne(lang).isEmpty)
            #expect(!L10n.bannerClipboardEmpty(lang).isEmpty)
            #expect(!L10n.bannerNoValidLinks(lang).isEmpty)
            #expect(!L10n.bannerAddedTorrent(lang).isEmpty)
            #expect(!L10n.bannerAddFailed(lang, error: "timeout").isEmpty)
            #expect(!L10n.bannerLocalPathNotFound(lang).isEmpty)
            #expect(!L10n.bannerPinnedTorrent(lang, name: "Ubuntu").isEmpty)
            #expect(!L10n.bannerUnpinnedTorrent(lang).isEmpty)
            #expect(!L10n.bannerActionFailed(lang, error: "network").isEmpty)
        }
    }

    @Test func testNonEnglishLanguagesHaveDistinctCoreStrings() {
        let nonEnglishLanguages: [AppLanguage] = [.ja, .ko, .de, .fr, .es, .ru]
        for lang in nonEnglishLanguages {
            let general = L10n.general(lang)
            let menuBar = L10n.menuBar(lang)
            let widgets = L10n.widgets(lang)
            let notifications = L10n.notifications(lang)
            let settingsTitle = L10n.settingsWindowTitle(lang)
            let bannerPausedAll = L10n.bannerPausedAll(lang)

            #expect(!general.isEmpty)
            #expect(!menuBar.isEmpty)
            #expect(!widgets.isEmpty)
            #expect(!notifications.isEmpty)
            #expect(!settingsTitle.isEmpty)
            #expect(!bannerPausedAll.isEmpty)

            // Assert they return distinct localized strings (not falling back to English)
            #expect(general != L10n.general(.en), "Expected distinct translation for general in \(lang.rawValue), got \(general)")
            #expect(menuBar != L10n.menuBar(.en), "Expected distinct translation for menuBar in \(lang.rawValue), got \(menuBar)")
            #expect(widgets != L10n.widgets(.en), "Expected distinct translation for widgets in \(lang.rawValue), got \(widgets)")
            #expect(notifications != L10n.notifications(.en), "Expected distinct translation for notifications in \(lang.rawValue), got \(notifications)")
            #expect(settingsTitle != L10n.settingsWindowTitle(.en), "Expected distinct translation for settingsWindowTitle in \(lang.rawValue), got \(settingsTitle)")
            #expect(bannerPausedAll != L10n.bannerPausedAll(.en), "Expected distinct translation for bannerPausedAll in \(lang.rawValue), got \(bannerPausedAll)")
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

@Suite("Client Type & Backend Service Tests")
struct ClientTypeTests {
    @Test func testClientTypeDefaults() {
        #expect(ClientType.qbittorrent.defaultPort == 8080)
        #expect(ClientType.transmission.defaultPort == 9091)
        #expect(ClientType.qbittorrent.defaultApiPrefix == "/api/v2")
        #expect(ClientType.transmission.defaultApiPrefix == "/transmission/rpc")
        #expect(ClientType.qbittorrent.defaultBaseURL == "http://127.0.0.1:8080")
        #expect(ClientType.transmission.defaultBaseURL == "http://127.0.0.1:9091")
    }

    @Test func testClientTypeEncodingAndDecoding() throws {
        var config = APIConfig.defaultConfig
        #expect(config.clientType == .qbittorrent)

        config.clientType = .transmission
        config.baseURL = "http://127.0.0.1:9091"
        config.apiPrefix = "/transmission/rpc"

        let encoded = try JSONEncoder().encode(config)
        let decoded = try JSONDecoder().decode(APIConfig.self, from: encoded)

        #expect(decoded.clientType == .transmission)
        #expect(decoded.baseURL == "http://127.0.0.1:9091")
        #expect(decoded.apiPrefix == "/transmission/rpc")
        #expect(decoded.endpointURL(for: "")?.absoluteString == "http://127.0.0.1:9091/transmission/rpc")
    }

    @Test func testClientTypeFallbackFromLegacyJSON() throws {
        let legacyJSON = """
        {
            "baseURL": "http://192.168.1.50:8080",
            "apiPrefix": "/api/v2",
            "username": "admin",
            "password": ""
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(APIConfig.self, from: legacyJSON)
        #expect(decoded.clientType == .qbittorrent)
        #expect(decoded.baseURL == "http://192.168.1.50:8080")
    }

    @Test func testTorrentServiceFactory() {
        let qbConfig = APIConfig(clientType: .qbittorrent)
        let qbService = TorrentServiceFactory.create(for: qbConfig)
        #expect(qbService is QBittorrentService)

        let trConfig = APIConfig(clientType: .transmission)
        let trService = TorrentServiceFactory.create(for: trConfig)
        #expect(trService is TransmissionService)
    }
}

@Suite("Backend & Core Security Fixes Tests")
struct BackendCoreFixesTests {
    @Test func testQBittorrentFormURLEncode() {
        let specialChars = "hello & world = 1 + 2"
        let encoded = QBittorrentService.formURLEncode(specialChars)
        #expect(encoded == "hello%20%26%20world%20%3D%201%20%2B%202")
        #expect(!encoded.contains("&"))
        #expect(!encoded.contains("="))
        #expect(!encoded.contains("+"))

        let magnet = "magnet:?xt=urn:btih:da39a3ee5e6b4b0d3255bfef95601890afd80709&dn=Ubuntu+22.04&tr=https%3A%2F%2Ftracker.example.com%2Fannounce"
        let encodedMagnet = QBittorrentService.formURLEncode(magnet)
        #expect(!encodedMagnet.contains("&dn="))
        #expect(!encodedMagnet.contains("&tr="))
        #expect(encodedMagnet.contains("%26dn%3D"))
        #expect(encodedMagnet.contains("%26tr%3D"))
        #expect(encodedMagnet.contains("%2B"))
    }

    @Test func testBencodeParserOverflowStringLength() {
        // String length near Int64.max that would cause arithmetic overflow if checked with `strStart + len`
        let overflowData = "9223372036854775800:abc".data(using: .utf8)!
        let parser = BencodeParser(data: overflowData)
        #expect(throws: BencodeError.unexpectedEOF) {
            try parser.parse()
        }
    }

    @Test func testBencodeParserNegativeStringLength() {
        let negativeLenData = "-1:a".data(using: .utf8)!
        let parser = BencodeParser(data: negativeLenData)
        #expect(throws: BencodeError.self) {
            try parser.parse()
        }
    }

    @Test func testBencodeParserExcessiveNestingDepth() {
        // 300 nested lists exceed default maxDepth = 256
        let deeplyNested = String(repeating: "l", count: 300) + String(repeating: "e", count: 300)
        let data = deeplyNested.data(using: .utf8)!
        let parser = BencodeParser(data: data)
        #expect(throws: BencodeError.maxDepthExceeded) {
            try parser.parse()
        }
    }

    @Test func testAPIConfigOmitsPlaintextPasswordInJSON() throws {
        let secret = "SuperSecretP@ssw0rd!#$&=+"
        let config = APIConfig(
            username: "admin",
            password: secret
        )
        let encodedData = try JSONEncoder().encode(config)
        let jsonString = String(data: encodedData, encoding: .utf8)!

        // Verify JSON representation does NOT contain the secret password or password key
        #expect(!jsonString.contains(secret))
        #expect(!jsonString.contains("\"password\""))

        // Verify decoding legacy JSON that contained password still succeeds and migrates
        let legacyJSON = """
        {
            "baseURL": "http://127.0.0.1:8080",
            "apiPrefix": "/api/v2",
            "username": "legacyUser",
            "password": "\(secret)"
        }
        """.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(APIConfig.self, from: legacyJSON)
        #expect(decoded.password == secret)
        #expect(decoded.username == "legacyUser")
    }

    @Test func testKeychainHelperAndMigration() {
        let testAccount = "test-account-\(UUID().uuidString)"
        let testPassword = "MySecureKeychainPassword_123"

        KeychainHelper.savePassword(testPassword, account: testAccount)
        let loaded = KeychainHelper.loadPassword(account: testAccount)
        #expect(loaded == testPassword)

        // Saving empty password should delete without deadlocking on NSLock
        KeychainHelper.savePassword("", account: testAccount)
        let loadedAfterEmpty = KeychainHelper.loadPassword(account: testAccount)
        #expect(loadedAfterEmpty == nil)

        KeychainHelper.deletePassword(account: testAccount)
        let loadedAfterDelete = KeychainHelper.loadPassword(account: testAccount)
        #expect(loadedAfterDelete == nil)
    }
}

@Suite("Menu Bar & WidgetKit Real-Time Tests")
struct MenuBarAndWidgetKitRealTimeTests {
    @Test @MainActor func testPinnedTorrentFallbackWhenPinnedHashMissing() {
        let viewModel = QBMenubarViewModel(isMock: true)
        viewModel.config.showPinnedProgress = true
        viewModel.config.pinnedTorrentHash = "11111111111111111111"

        let activeDownloading = Torrent(
            hash: "active_download_hash",
            name: "ActiveDownload.iso",
            size: 2_000_000_000,
            progress: 0.45,
            dlspeed: 5_242_880,
            upspeed: 100_000,
            eta: 120,
            state: "downloading"
        )
        let pausedTorrent = Torrent(
            hash: "paused_hash",
            name: "Paused.iso",
            size: 1_000_000_000,
            progress: 0.10,
            dlspeed: 0,
            upspeed: 0,
            eta: -1,
            state: "pausedDL"
        )
        viewModel.torrents = [pausedTorrent, activeDownloading]

        // Pinned hash "11111111111111111111" does not exist in viewModel.torrents.
        // It must fall back to the active downloading torrent instead of returning nil.
        #expect(viewModel.pinnedTorrent != nil)
        #expect(viewModel.pinnedTorrent?.hash == "active_download_hash")
        #expect(viewModel.pinnedTorrentProgressText == "45%")

        // Explicit "none" should disable pinning
        viewModel.config.pinnedTorrentHash = "none"
        #expect(viewModel.pinnedTorrent == nil)

        // Matching existing hash should return that specific torrent
        viewModel.config.pinnedTorrentHash = "paused_hash"
        #expect(viewModel.pinnedTorrent?.hash == "paused_hash")

        // Disabling showPinnedProgress should return nil
        viewModel.config.showPinnedProgress = false
        #expect(viewModel.pinnedTorrent == nil)
    }

    @Test @MainActor func testMockViewModelMutatingConfigDoesNotPersistOrCrash() async throws {
        let initialSavedConfig = APIConfig.load()
        let viewModel = QBMenubarViewModel(isMock: true)

        // Mutating config on mock should not crash, should not trigger networking,
        // and should NOT overwrite saved UserDefaults config.
        viewModel.config.pinnedTorrentHash = "mock_hash_9999"
        viewModel.config.showPinnedProgress = true
        viewModel.config.pollInterval = 999.0
        viewModel.config.baseURL = "http://mock-invalid-host-should-not-persist:9999"

        let dummyTorrent = Torrent(
            hash: "test_dummy_hash",
            name: "Dummy.iso",
            size: 100,
            progress: 0.5,
            dlspeed: 0,
            upspeed: 0,
            eta: 0,
            state: "downloading"
        )
        viewModel.togglePinTorrent(dummyTorrent)
        viewModel.setPinnedTorrentHash("another_mock_hash")

        // Sleep briefly to exceed debounce window (400ms) used in live config.didSet
        try await Task.sleep(nanoseconds: 500_000_000)

        // UserDefaults should still reflect initialSavedConfig, not the mock values
        let reloadedConfig = APIConfig.load()
        #expect(reloadedConfig.pinnedTorrentHash == initialSavedConfig.pinnedTorrentHash)
        #expect(reloadedConfig.baseURL == initialSavedConfig.baseURL)
        #expect(reloadedConfig.pollInterval == initialSavedConfig.pollInterval)
        #expect(viewModel.isConnected == false)
    }

    @Test @MainActor func testWidgetSnapshotStateAndCooldowns() {
        let viewModel = QBMenubarViewModel(isMock: true)
        viewModel.config.enableWidgetSync = true

        let torrent1 = Torrent(
            hash: "hash_1",
            name: "Test1.iso",
            size: 1_000_000_000,
            progress: 0.30,
            dlspeed: 2_000_000,
            upspeed: 0,
            eta: 100,
            state: "downloading"
        )
        viewModel.torrents = [torrent1]
        viewModel.transferInfo = TransferInfo(
            dlInfoSpeed: 2_000_000,
            upInfoSpeed: 0,
            dlInfoData: 100_000_000,
            upInfoData: 0,
            connectionStatus: "connected",
            dhtNodes: 100
        )
        viewModel.connectionState = .connected(ping: 10)

        // Test calling updateWidgetSnapshot with forceReload
        viewModel.updateWidgetSnapshot(forceReload: true)
        let loaded = WidgetDataManager.loadSnapshot()
        #expect(loaded != nil)
        #expect(loaded?.activeDownloadsCount == 1)
        #expect(loaded?.tasks.first?.id == "hash_1")

        // Test updateWidgetSnapshotDisconnected
        viewModel.updateWidgetSnapshotDisconnected(forceReload: true)
        let disconnectedLoaded = WidgetDataManager.loadSnapshot()
        #expect(disconnectedLoaded?.isConnected == false)
        #expect(disconnectedLoaded?.dlSpeed == 0)
    }
}

@Suite("Download Completion & Notification Tests")
struct DownloadCompletionNotificationTests {
    @Test @MainActor func testIsTorrentCompletedStates() {
        // qBittorrent v5 stoppedUP
        let stoppedUPTorrent = Torrent(
            hash: "hash_stopped_up",
            name: "Completed_StoppedUP.iso",
            size: 1_000_000,
            progress: 1.0,
            dlspeed: 0,
            upspeed: 0,
            eta: 0,
            state: "stoppedUP"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(stoppedUPTorrent))

        // stalledUP
        let stalledUPTorrent = Torrent(
            hash: "hash_stalled_up",
            name: "Completed_StalledUP.iso",
            size: 1_000_000,
            progress: 0.95,
            dlspeed: 0,
            upspeed: 0,
            eta: 0,
            state: "stalledUP"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(stalledUPTorrent))

        // pausedUP
        let pausedUPTorrent = Torrent(
            hash: "hash_paused_up",
            name: "Completed_PausedUP.iso",
            size: 1_000_000,
            progress: 0.8,
            dlspeed: 0,
            upspeed: 0,
            eta: 0,
            state: "pausedUP"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(pausedUPTorrent))

        // uploading
        let uploadingTorrent = Torrent(
            hash: "hash_uploading",
            name: "Completed_Uploading.iso",
            size: 1_000_000,
            progress: 0.9,
            dlspeed: 0,
            upspeed: 50_000,
            eta: 0,
            state: "uploading"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(uploadingTorrent))

        // forcedUP and queuedUP
        let forcedUPTorrent = Torrent(
            hash: "hash_forced_up",
            name: "Completed_ForcedUP.iso",
            size: 1_000_000,
            progress: 0.7,
            dlspeed: 0,
            upspeed: 10_000,
            eta: 0,
            state: "forcedUP"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(forcedUPTorrent))

        let queuedUPTorrent = Torrent(
            hash: "hash_queued_up",
            name: "Completed_QueuedUP.iso",
            size: 1_000_000,
            progress: 0.7,
            dlspeed: 0,
            upspeed: 0,
            eta: 0,
            state: "queuedUP"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(queuedUPTorrent))

        // progress: 0.99995 (even when downloading)
        let highProgressTorrent = Torrent(
            hash: "hash_high_progress",
            name: "NearlyDone.iso",
            size: 1_000_000,
            progress: 0.99995,
            dlspeed: 10_000,
            upspeed: 0,
            eta: 1,
            state: "downloading"
        )
        #expect(QBMenubarViewModel.isTorrentCompleted(highProgressTorrent))

        // Returning false for downloading at 50%
        let downloading50Torrent = Torrent(
            hash: "hash_downloading_50",
            name: "Downloading50.iso",
            size: 1_000_000,
            progress: 0.50,
            dlspeed: 1_000_000,
            upspeed: 0,
            eta: 100,
            state: "downloading"
        )
        #expect(!QBMenubarViewModel.isTorrentCompleted(downloading50Torrent))

        // Returning false for pausedDL at 50%
        let pausedDL50Torrent = Torrent(
            hash: "hash_paused_dl_50",
            name: "PausedDL50.iso",
            size: 1_000_000,
            progress: 0.50,
            dlspeed: 0,
            upspeed: 0,
            eta: -1,
            state: "pausedDL"
        )
        #expect(!QBMenubarViewModel.isTorrentCompleted(pausedDL50Torrent))
    }

    @Test func testNotificationManagerMethodsSafeWithoutBundleId() async {
        let status = await NotificationManager.shared.checkAuthorizationStatus()
        #expect(status == .notDetermined || status == .authorized || status == .denied || status == .provisional)

        NotificationManager.shared.requestAuthorization()
        NotificationManager.shared.sendTestNotification(lang: .en)
        NotificationManager.shared.sendTestNotification(lang: .zhHans)
        NotificationManager.shared.sendNotification(title: "Test", subtitle: "Sub", body: "Body", savePath: nil)
    }
}
