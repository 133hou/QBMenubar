import SwiftUI
import QBMenubarShared

public enum SettingsCategory: String, CaseIterable, Identifiable {
    case general = "通用"
    case connection = "WebUI 连接"
    case menubar = "菜单栏"
    case widgets = "小组件"
    case notifications = "通知"
    case advanced = "高级"
    case about = "关于"

    public var id: String { rawValue }

    public func localizedTitle(lang: AppLanguage) -> String {
        switch self {
        case .general: return L10n.general(lang)
        case .connection: return L10n.webUIConnection(lang)
        case .menubar: return L10n.menuBar(lang)
        case .widgets: return L10n.widgets(lang)
        case .notifications: return L10n.notifications(lang)
        case .advanced: return L10n.advanced(lang)
        case .about: return L10n.about(lang)
        }
    }

    public func localizedTitle(isEn: Bool) -> String {
        localizedTitle(lang: isEn ? .en : .zhHans)
    }

    public var iconName: String {
        switch self {
        case .general: return "gearshape.fill"
        case .connection: return "network"
        case .menubar: return "menubar.rectangle"
        case .widgets: return "square.grid.2x2.fill"
        case .notifications: return "bell.fill"
        case .advanced: return "slider.horizontal.3"
        case .about: return "info.circle.fill"
        }
    }

    public var badgeColor: Color {
        switch self {
        case .general: return Color(red: 0.16, green: 0.52, blue: 0.98) // Azure Blue
        case .connection: return Color(red: 0.08, green: 0.72, blue: 0.88) // Vivid Aqua Cyan
        case .menubar: return Color(red: 0.40, green: 0.40, blue: 0.96) // Deep Indigo Glass
        case .widgets: return Color(red: 0.18, green: 0.78, blue: 0.45) // Vivid Emerald Green
        case .notifications: return Color(red: 1.00, green: 0.28, blue: 0.28) // Vivid Ruby Red
        case .advanced: return Color(red: 0.72, green: 0.30, blue: 0.96) // Vivid Amethyst Purple
        case .about: return Color(red: 0.55, green: 0.58, blue: 0.65) // Frosted Titanium
        }
    }
}

public struct SettingsWindowView: View {
    @Bindable var viewModel: QBMenubarViewModel

    @State private var selectedCategory: SettingsCategory = .general
    @State private var hoveredCategory: SettingsCategory? = nil
    @State private var searchText: String = ""
    @State private var testState: TestStatus = .idle

    private var lang: AppLanguage { viewModel.config.language }
    private var isEn: Bool { !lang.isChinese }

    enum TestStatus: Equatable {
        case idle
        case testing
        case success(version: String, pingMs: Int)
        case failure(String)
    }

    public init(viewModel: QBMenubarViewModel, initialCategory: SettingsCategory = .general) {
        self.viewModel = viewModel
        self._selectedCategory = State(initialValue: initialCategory)
    }

    public var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            VStack(spacing: 0) {
                // Search bar
                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                    TextField(L10n.searchSettings(lang), text: $searchText)
                        .textFieldStyle(.plain)
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.primary.opacity(0.06))
                )
                .padding(.horizontal, 12)
                .padding(.top, 46) // Accommodate macOS traffic light buttons
                .padding(.bottom, 8)

                // Category List
                ScrollView {
                    VStack(spacing: 3) {
                        ForEach(SettingsCategory.allCases) { category in
                            Button {
                                withAnimation(AppMotion.selection) {
                                    selectedCategory = category
                                }
                            } label: {
                                HStack(spacing: 10) {
                                    LiquidGlassCategoryBadge(
                                        category: category,
                                        isSelected: selectedCategory == category
                                    )

                                    Text(category.localizedTitle(lang: lang))
                                        .font(.system(size: 13, weight: selectedCategory == category ? .medium : .regular))
                                        .foregroundStyle(selectedCategory == category ? Color.white : Color.primary)

                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .contentShape(Rectangle())
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(
                                            selectedCategory == category
                                                ? Color.accentColor
                                                : (hoveredCategory == category ? Color.primary.opacity(0.08) : Color.clear)
                                        )
                                )
                            }
                            .buttonStyle(.plain)
                            .onHover { isHovered in
                                if isHovered {
                                    hoveredCategory = category
                                } else if hoveredCategory == category {
                                    hoveredCategory = nil
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                }

                Divider()

                // Sidebar footer: Live Connection Status
                HStack(spacing: 6) {
                    Circle()
                        .fill(connectionColor)
                        .frame(width: 7, height: 7)

                    Text(connectionSummary)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
            }
            .frame(width: 220)
            .background(.ultraThinMaterial)

            Divider()

            // Detail Area
            VStack(spacing: 0) {
                // Top Breadcrumbs Navigation Bar
                HStack(spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.tertiary)

                    Text(selectedCategory.localizedTitle(lang: lang))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.primary)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 46)
                .padding(.bottom, 14)
                .background(.ultraThinMaterial)

                Divider()

                // Settings Content
                ScrollView {
                    AdaptiveGlassContainer(spacing: 16) {
                        VStack(alignment: .leading, spacing: 20) {
                            switch selectedCategory {
                            case .general:
                                generalPane
                            case .connection:
                                connectionPane
                            case .menubar:
                                menubarPane
                            case .widgets:
                                widgetsPane
                            case .notifications:
                                notificationsPane
                            case .advanced:
                                advancedPane
                            case .about:
                                aboutPane
                            }
                        }
                    }
                    .padding(24)
                }
            }
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 480, maxHeight: .infinity)
            .background(.regularMaterial)
        }
    }

    // MARK: - Panes

    @ViewBuilder
    private var generalPane: some View {
        SettingsGroup(title: L10n.systemGroup(lang)) {
            SettingsRow(
                title: L10n.language(lang),
                subtitle: L10n.languageSubtitle(lang)
            ) {
                GlassMenuPicker(
                    selection: $viewModel.config.language,
                    items: AppLanguage.allCases.map { ($0, $0.rawValue) },
                    width: 160
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.webConsole(lang),
                subtitle: L10n.webConsoleSubtitle(lang)
            ) {
                Button(L10n.openWebUI(lang)) {
                    viewModel.openWebUI()
                }
                .adaptiveGlassButton(prominent: false)
            }
        }
    }

    @ViewBuilder
    private var connectionPane: some View {
        SettingsGroup(title: L10n.networkConnectionGroup(lang)) {
            SettingsRow(
                title: L10n.serverAddress(lang),
                subtitle: L10n.serverAddressSubtitle(lang)
            ) {
                GlassTextField(
                    placeholder: "http://127.0.0.1:8080",
                    text: $viewModel.config.baseURL,
                    isMonospaced: true,
                    width: 220
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.apiPathPrefix(lang),
                subtitle: L10n.apiPathPrefixSubtitle(lang)
            ) {
                GlassTextField(
                    placeholder: "/api/v2",
                    text: $viewModel.config.apiPrefix,
                    isMonospaced: true,
                    width: 220
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.username(lang),
                subtitle: L10n.usernameSubtitle(lang)
            ) {
                GlassTextField(
                    placeholder: "admin",
                    text: $viewModel.config.username,
                    width: 220
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.password(lang),
                subtitle: L10n.passwordSubtitle(lang)
            ) {
                GlassTextField(
                    placeholder: L10n.passwordPlaceholder(lang),
                    text: $viewModel.config.password,
                    isSecure: true,
                    width: 220
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.bypassLocalhost(lang),
                subtitle: L10n.bypassLocalhostSubtitle(lang)
            ) {
                Toggle("", isOn: $viewModel.config.bypassLocalhost)
                    .toggleStyle(.switch)
            }
        }

        SettingsGroup(title: L10n.connectivityDiagnosticGroup(lang)) {
            SettingsRow(
                title: L10n.testConnectionTitle(lang),
                subtitle: L10n.testConnectionSubtitle(lang)
            ) {
                HStack(spacing: 8) {
                    switch testState {
                    case .idle:
                        EmptyView()
                    case .testing:
                        ProgressView().scaleEffect(0.6).frame(width: 14, height: 14)
                    case .success(let version, let ping):
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                            Text("\(version) • \(ping)ms")
                                .font(.system(size: 11, weight: .medium, design: .rounded))
                                .foregroundStyle(.green)
                        }
                    case .failure(let error):
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red)
                            Text(error)
                                .font(.system(size: 11))
                                .foregroundStyle(.red)
                                .lineLimit(1)
                        }
                    }

                    Button(L10n.testConnectionButton(lang)) {
                        runTestConnection()
                    }
                    .adaptiveGlassButton(prominent: true)
                    .disabled(testState == .testing)
                }
            }
        }
    }

    @ViewBuilder
    private var menubarPane: some View {
        // Live Preview of Menu Bar Appearance
        SettingsGroup(title: isEn ? "Live Appearance Preview" : "实时效果预览") {
            HStack(spacing: 12) {
                Spacer()

                HStack(spacing: 6) {
                    QBittorrentIcon(
                        size: CGFloat(viewModel.config.iconSize.points),
                        theme: viewModel.config.iconTheme
                    )

                    switch viewModel.config.menuBarStyle {
                    case .downloadOnly:
                        HStack(spacing: 2) {
                            Text("↓")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(previewArrowColor)
                            Text("12.6 MB/s")
                                .font(.system(size: 11, weight: .medium, design: .rounded))
                        }

                    case .twoLines:
                        VStack(alignment: .leading, spacing: -1) {
                            HStack(spacing: 2) {
                                Text("↑")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundStyle(.secondary)
                                Text("6 KB/s")
                                    .font(.system(size: 8.5, weight: .semibold, design: .monospaced))
                            }
                            HStack(spacing: 2) {
                                Text("↓")
                                    .font(.system(size: 8, weight: .bold))
                                    .foregroundStyle(previewArrowColor)
                                Text("121 KB/s")
                                    .font(.system(size: 8.5, weight: .semibold, design: .monospaced))
                            }
                        }

                    case .singleLineBoth:
                        HStack(spacing: 4) {
                            Text("↓ 12.6 MB/s")
                                .font(.system(size: 11, weight: .medium, design: .rounded))
                            Text("↑ 1.2 MB/s")
                                .font(.system(size: 11, weight: .regular, design: .rounded))
                                .foregroundStyle(.secondary)
                        }
                    }

                    if viewModel.config.showPinnedProgress && viewModel.config.pinnedTorrentHash != nil {
                        Text("78%")
                            .font(.system(size: 9.5, weight: .bold, design: .rounded))
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 1)
                            .background(
                                Capsule()
                                    .fill(Color.primary.opacity(0.12))
                            )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.primary.opacity(0.08))
                )

                Spacer()
            }
            .padding(.vertical, 8)
        }

        SettingsGroup(title: L10n.layoutStyleGroup(lang)) {
            SettingsRow(
                title: L10n.menuBarDisplayMode(lang),
                subtitle: L10n.menuBarDisplayModeSubtitle(lang)
            ) {
                GlassMenuPicker(
                    selection: $viewModel.config.menuBarStyle,
                    items: MenuBarStyle.allCases.map { ($0, $0.localizedTitle(lang: lang)) },
                    width: 210
                )
            }
        }

        SettingsGroup(title: L10n.taskProgressGroup(lang)) {
            SettingsRow(
                title: L10n.showTaskProgress(lang),
                subtitle: L10n.showTaskProgressSubtitle(lang)
            ) {
                Toggle("", isOn: $viewModel.config.showPinnedProgress)
                    .toggleStyle(.switch)
            }

            if viewModel.config.showPinnedProgress {
                SettingsDivider()

                SettingsRow(
                    title: L10n.selectedTorrent(lang),
                    subtitle: L10n.selectedTorrentSubtitle(lang)
                ) {
                    GlassMenuPicker(
                        selection: Binding(
                            get: { viewModel.config.pinnedTorrentHash ?? "none" },
                            set: { viewModel.config.pinnedTorrentHash = ($0 == "none" ? nil : $0) }
                        ),
                        items: pinnedTorrentOptions,
                        width: 230
                    )
                }
            }
        }

        SettingsGroup(title: L10n.iconColorsGroup(lang)) {
            SettingsRow(
                title: L10n.iconThemeTitle(lang),
                subtitle: L10n.iconThemeSubtitle(lang)
            ) {
                GlassMenuPicker(
                    selection: $viewModel.config.iconTheme,
                    items: IconTheme.allCases.map { ($0, $0.localizedTitle(lang: lang)) },
                    width: 210
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.iconSizeTitle(lang),
                subtitle: L10n.iconSizeSubtitle(lang)
            ) {
                GlassMenuPicker(
                    selection: $viewModel.config.iconSize,
                    items: IconSizeOption.allCases.map { ($0, $0.localizedTitle(lang: lang)) },
                    width: 210
                )
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.arrowThemeTitle(lang),
                subtitle: L10n.arrowThemeSubtitle(lang)
            ) {
                GlassMenuPicker(
                    selection: $viewModel.config.arrowTheme,
                    items: ArrowTheme.allCases.map { ($0, $0.localizedTitle(lang: lang)) },
                    width: 210
                )
            }
        }
    }

    @ViewBuilder
    private var widgetsPane: some View {
        // Group 1: Desktop Widget Synchronization & Permissions
        SettingsGroup(title: isEn ? "Desktop Widget Synchronization" : "桌面小组件同步与权限") {
            SettingsRow(
                title: L10n.enableWidgetSync(lang),
                subtitle: L10n.enableWidgetSyncSubtitle(lang)
            ) {
                Toggle("", isOn: Binding(
                    get: { viewModel.config.enableWidgetSync },
                    set: { newValue in
                        viewModel.config.enableWidgetSync = newValue
                        viewModel.config.save()
                        viewModel.updateWidgetSnapshot()
                    }
                ))
                .toggleStyle(.switch)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Full Disk Access" : "完全磁盘访问权限",
                subtitle: isEn ? "Required by macOS for cross-process widget data sharing" : "macOS 跨进程共享小组件数据所必需"
            ) {
                HStack(spacing: 6) {
                    if !viewModel.config.enableWidgetSync {
                        Circle().fill(Color.secondary).frame(width: 7, height: 7)
                        Text(L10n.widgetPermissionDisabled(lang))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.secondary)
                    } else if WidgetDataManager.checkGroupContainerPermission() {
                        Circle().fill(Color.green).frame(width: 7, height: 7)
                        Text(L10n.widgetPermissionGranted(lang))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.green)
                    } else {
                        Circle().fill(Color.orange).frame(width: 7, height: 7)
                        Text(L10n.widgetPermissionBlocked(lang))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.orange)
                    }
                }
            }

            if viewModel.config.enableWidgetSync && !WidgetDataManager.checkGroupContainerPermission() {
                SettingsDivider()

                VStack(alignment: .leading, spacing: 10) {
                    Text(L10n.widgetPermissionDesc(lang))
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineSpacing(2.5)
                        .fixedSize(horizontal: false, vertical: true)

                    Button {
                        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles") {
                            NSWorkspace.shared.open(url)
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "lock.shield.fill")
                            Text(L10n.openFullDiskAccessBtn(lang))
                        }
                        .font(.system(size: 11.5, weight: .medium))
                    }
                    .adaptiveGlassButton(prominent: true)

                    HStack(spacing: 6) {
                        Image(systemName: "checkmark.shield.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(.blue)
                        Text(L10n.widgetPrivacyPromise(lang))
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.primary.opacity(0.85))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 9)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.blue.opacity(0.08))
                    )

                    Text(L10n.terminalResetHint(lang))
                        .font(.system(size: 9, design: .monospaced))
                        .foregroundStyle(.tertiary)
                        .textSelection(.enabled)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
            }
        }

        // Group 2: Widget Sizes & Information
        SettingsGroup(
            title: isEn ? "Widget Types & Instructions" : "小组件规格与添加方式",
            footer: isEn
                ? "Right-click your macOS desktop or open Notification Center, click 'Edit Widgets', and select QBMenubar."
                : "在桌面空白处右键点击「编辑小组件」（或在通知中心底部点击），搜索「QBMenubar」即可添加。"
        ) {
            HStack(spacing: 10) {
                WidgetTypeBadge(title: "Small", desc: isEn ? "Single Task & Speeds" : "焦点任务与速率", icon: "square")
                WidgetTypeBadge(title: "Medium", desc: isEn ? "3 Tasks & Speeds" : "多任务列表与带宽", icon: "rectangle")
                WidgetTypeBadge(title: "Large", desc: isEn ? "Dashboard" : "全功能看板", icon: "square.fill")
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
    }

    @ViewBuilder
    private var notificationsPane: some View {
        SettingsGroup(title: L10n.notificationsGroup(lang)) {
            SettingsRow(
                title: L10n.enableNotifications(lang),
                subtitle: L10n.enableNotificationsSubtitle(lang)
            ) {
                Toggle("", isOn: $viewModel.config.enableNotifications)
                    .toggleStyle(.switch)
            }

            if viewModel.config.enableNotifications {
                SettingsDivider()

                SettingsRow(
                    title: L10n.notifyOnStartTitle(lang),
                    subtitle: L10n.notifyOnStartSubtitle(lang)
                ) {
                    Toggle("", isOn: $viewModel.config.notifyOnStart)
                        .toggleStyle(.switch)
                }

                SettingsDivider()

                SettingsRow(
                    title: L10n.notifyOnCompleteTitle(lang),
                    subtitle: L10n.notifyOnCompleteSubtitle(lang)
                ) {
                    Toggle("", isOn: $viewModel.config.notifyOnComplete)
                        .toggleStyle(.switch)
                }
            }
        }
    }

    @ViewBuilder
    private var advancedPane: some View {
        SettingsGroup(title: L10n.refreshPerformanceGroup(lang)) {
            SettingsRow(
                title: L10n.pollingIntervalTitle(lang, seconds: viewModel.config.pollInterval),
                subtitle: L10n.pollingIntervalSubtitle(lang)
            ) {
                Slider(value: $viewModel.config.pollInterval, in: 1.0...10.0, step: 0.5)
                    .frame(width: 180)
            }

            SettingsDivider()

            SettingsRow(
                title: L10n.chartDurationTitle(lang, seconds: viewModel.config.chartHistorySeconds),
                subtitle: L10n.chartDurationSubtitle(lang)
            ) {
                Slider(
                    value: Binding(
                        get: { Double(viewModel.config.chartHistorySeconds) },
                        set: { viewModel.config.chartHistorySeconds = Int($0) }
                    ),
                    in: 15...60,
                    step: 5
                )
                .frame(width: 180)
            }
        }

        SettingsGroup(title: L10n.resetGroup(lang)) {
            SettingsRow(
                title: L10n.restoreDefaultsTitle(lang),
                subtitle: L10n.restoreDefaultsSubtitle(lang)
            ) {
                Button(L10n.resetToDefaultsButton(lang)) {
                    viewModel.config = .defaultConfig
                }
                .adaptiveGlassButton(prominent: false)
            }
        }
    }

    @ViewBuilder
    private var aboutPane: some View {
        VStack(spacing: 16) {
            // App Hero Card
            VStack(spacing: 10) {
                AppHeroIconView(size: 64)

                VStack(spacing: 4) {
                    Text("QBMenubar")
                        .font(.system(size: 17, weight: .bold))

                    Text(L10n.tr(lang, zhHans: "版本 1.3.1 (Build 2026.11)", zhHant: "版本 1.3.1 (Build 2026.11)", en: "Version 1.3.1 (Build 2026.11)"))
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)

                    Text(L10n.appSubtitle(lang))
                        .font(.system(size: 11))
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)

            // Open Source & Community
            SettingsGroup(title: L10n.openSourceCommunityGroup(lang)) {
                SettingsRow(
                    title: L10n.githubRepoTitle(lang),
                    subtitle: "https://github.com/133hou/QBMenubar"
                ) {
                    LinkButton(
                        title: L10n.visitRepoButton(lang),
                        urlString: "https://github.com/133hou/QBMenubar"
                    )
                }

                SettingsDivider()

                SettingsRow(
                    title: L10n.releasesTitle(lang),
                    subtitle: L10n.releasesSubtitle(lang)
                ) {
                    LinkButton(
                        title: L10n.viewReleasesButton(lang),
                        urlString: "https://github.com/133hou/QBMenubar/releases"
                    )
                }

                SettingsDivider()

                SettingsRow(
                    title: L10n.issuesFeedbackTitle(lang),
                    subtitle: L10n.issuesFeedbackSubtitle(lang)
                ) {
                    LinkButton(
                        title: L10n.submitFeedbackButton(lang),
                        urlString: "https://github.com/133hou/QBMenubar/issues"
                    )
                }
            }

            // WebUI Quick Access
            SettingsGroup(title: L10n.webManagementGroup(lang)) {
                SettingsRow(
                    title: "qBittorrent WebUI",
                    subtitle: L10n.webManagementSubtitle(lang)
                ) {
                    Button {
                        viewModel.openWebUI()
                    } label: {
                        HStack(spacing: 4) {
                            Text(L10n.openWebUI(lang))
                                .font(.system(size: 12, weight: .medium))
                            Image(systemName: "arrow.up.forward.app")
                                .font(.system(size: 11))
                        }
                    }
                    .adaptiveGlassButton(prominent: false)
                }
            }

            // Software Specifications
            SettingsGroup(title: L10n.softwareInfoGroup(lang)) {
                SettingsRow(
                    title: L10n.openSourceLicenseTitle(lang)
                ) {
                    InfoBadge(text: "MIT License")
                }

                SettingsDivider()

                SettingsRow(
                    title: L10n.techStackTitle(lang)
                ) {
                    InfoBadge(text: "Swift 6 + SwiftUI + Liquid Glass")
                }

                SettingsDivider()

                SettingsRow(
                    title: L10n.compatibilityTitle(lang)
                ) {
                    InfoBadge(text: "macOS 14.0+ (Apple Silicon & Intel)")
                }
            }
        }
    }

    // MARK: - Helpers

    private var previewArrowColor: Color {
        switch viewModel.config.arrowTheme {
        case .adaptive: return .primary
        case .white: return .white
        case .black: return .black
        case .dynamicColor: return .green
        }
    }

    private var connectionColor: Color {
        switch viewModel.connectionState {
        case .connected: return .green
        case .connecting: return .yellow
        case .disconnected, .error: return .red
        }
    }

    private var connectionSummary: String {
        switch viewModel.connectionState {
        case .connected(let ping):
            return L10n.connected(lang, ping: ping)
        case .connecting:
            return L10n.connecting(lang)
        case .disconnected:
            return L10n.disconnected(lang)
        case .error:
            return L10n.connectionFailed(lang)
        }
    }

    private var pinnedTorrentOptions: [(tag: String, title: String)] {
        var options: [(tag: String, title: String)] = [
            ("none", L10n.doNotShow(lang)),
            ("auto", L10n.autoSelectMostActive(lang))
        ]
        for torrent in viewModel.torrents {
            let pct = String(format: "%.0f%%", torrent.progress * 100)
            options.append((torrent.hash, "\(torrent.name) (\(pct))"))
        }
        return options
    }

    private func runTestConnection() {
        testState = .testing
        Task {
            let testService = QBittorrentService(config: viewModel.config)
            do {
                _ = try await testService.login()
                let (version, ping) = try await testService.testConnection()
                testState = .success(version: version, pingMs: ping)
            } catch {
                testState = .failure(error.localizedDescription)
            }
        }
    }
}

// MARK: - Form Components matching macOS System Settings style

struct SettingsGroup<Content: View>: View {
    let title: String
    var footer: String? = nil
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.secondary)
                .padding(.leading, 4)

            VStack(spacing: 0) {
                content
            }
            .glassCard(cornerRadius: 10, padding: 0, isInteractive: false)

            if let footer = footer {
                Text(footer)
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                    .lineSpacing(2)
                    .padding(.leading, 4)
                    .padding(.top, 2)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct SettingsRow<Control: View>: View {
    let title: String
    var subtitle: String? = nil
    @ViewBuilder let control: Control

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.primary)

                if let sub = subtitle {
                    Text(sub)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            control
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
    }
}

struct SettingsDivider: View {
    var body: some View {
        Divider()
            .padding(.leading, 14)
    }
}

struct LinkButton: View {
    let title: String
    let urlString: String

    var body: some View {
        Button {
            if let url = URL(string: urlString) {
                let configuration = NSWorkspace.OpenConfiguration()
                configuration.activates = true
                NSWorkspace.shared.open(url, configuration: configuration) { _, _ in }
            }
        } label: {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 10, weight: .semibold))
            }
        }
        .adaptiveGlassButton(prominent: false)
    }
}

struct InfoBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .medium, design: .rounded))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(Color.primary.opacity(0.06))
            .clipShape(Capsule())
    }
}

public struct LiquidGlassCategoryBadge: View {
    public let category: SettingsCategory
    public var isSelected: Bool = false

    public init(category: SettingsCategory, isSelected: Bool = false) {
        self.category = category
        self.isSelected = isSelected
    }

    public var body: some View {
        ZStack {
            if #available(macOS 26.0, *) {
                RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                    .fill(category.badgeColor.opacity(0.25))
                    .glassEffect(.regular.tint(category.badgeColor), in: .rect(cornerRadius: 6.5))
                    .frame(width: 22, height: 22)
            } else {
                RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                category.badgeColor.opacity(0.85),
                                category.badgeColor.opacity(0.65)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 22, height: 22)
            }

            // Upper glass gloss reflection
            RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.40),
                            Color.white.opacity(0.0)
                        ],
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .frame(width: 22, height: 22)

            // Specular glass rim highlight
            RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.75),
                            Color.white.opacity(0.20),
                            category.badgeColor.opacity(0.45)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.65
                )
                .frame(width: 22, height: 22)

            // Crisp SF Symbol centered inside
            Image(systemName: category.iconName)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.35), radius: 0.5, x: 0, y: 0.5)
        }
        .frame(width: 22, height: 22)
        .shadow(color: category.badgeColor.opacity(isSelected ? 0.45 : 0.28), radius: 3, x: 0, y: 1.5)
    }
}

private struct WidgetTypeBadge: View {
    let title: String
    let desc: String
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(.tint)
            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 11, weight: .semibold))
                Text(desc)
                    .font(.system(size: 9.5))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.primary.opacity(0.04))
        )
    }
}
