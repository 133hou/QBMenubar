import SwiftUI

public enum SettingsCategory: String, CaseIterable, Identifiable {
    case general = "通用"
    case connection = "WebUI 连接"
    case menubar = "菜单栏"
    case notifications = "通知"
    case advanced = "高级"
    case about = "关于"

    public var id: String { rawValue }

    public func localizedTitle(isEn: Bool) -> String {
        if isEn {
            switch self {
            case .general: return "General"
            case .connection: return "WebUI Connection"
            case .menubar: return "Menu Bar"
            case .notifications: return "Notifications"
            case .advanced: return "Advanced"
            case .about: return "About"
            }
        }
        return rawValue
    }

    public var iconName: String {
        switch self {
        case .general: return "gearshape.fill"
        case .connection: return "network"
        case .menubar: return "menubar.rectangle"
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

    private var isEn: Bool { viewModel.config.language == .en }

    enum TestStatus: Equatable {
        case idle
        case testing
        case success(version: String, pingMs: Int)
        case failure(String)
    }

    public init(viewModel: QBMenubarViewModel) {
        self.viewModel = viewModel
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
                    TextField(isEn ? "Search settings" : "搜索设置", text: $searchText)
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

                                    Text(category.localizedTitle(isEn: isEn))
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

                    Text(selectedCategory.localizedTitle(isEn: isEn))
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
        SettingsGroup(title: isEn ? "System" : "系统") {
            SettingsRow(
                title: isEn ? "Language" : "语言",
                subtitle: isEn ? "Change display language. Requires app restart to take full effect." : "更改显示语言。需要重启应用才能完全生效。"
            ) {
                Picker("", selection: $viewModel.config.language) {
                    ForEach(AppLanguage.allCases) { lang in
                        Text(lang.rawValue).tag(lang)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 160)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "qBittorrent Web Console" : "qBittorrent 网页控制台",
                subtitle: isEn ? "Open WebUI directly in your default browser" : "直接在系统默认浏览器中打开 WebUI"
            ) {
                Button(isEn ? "Open WebUI" : "打开 WebUI") {
                    viewModel.openWebUI()
                }
                .adaptiveGlassButton(prominent: false)
            }
        }
    }

    @ViewBuilder
    private var connectionPane: some View {
        SettingsGroup(title: isEn ? "Network Connection" : "网络连接") {
            SettingsRow(
                title: isEn ? "Server Address" : "服务器地址",
                subtitle: isEn ? "qBittorrent WebUI URL (supports localhost, LAN IP, NAS, or domain)" : "qBittorrent WebUI 访问地址 (支持本地、NAS 或域名)"
            ) {
                TextField("http://127.0.0.1:8080", text: $viewModel.config.baseURL)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 12, design: .monospaced))
                    .frame(width: 220)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "API Path Prefix" : "API 路径前缀",
                subtitle: isEn ? "Default /api/v2; modify if using reverse proxy subpath" : "默认 /api/v2，使用反代子目录时可在此修改"
            ) {
                TextField("/api/v2", text: $viewModel.config.apiPrefix)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 12, design: .monospaced))
                    .frame(width: 220)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Username" : "用户名",
                subtitle: isEn ? "WebUI login account" : "WebUI 登录账户"
            ) {
                TextField("admin", text: $viewModel.config.username)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 220)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Password" : "密码",
                subtitle: isEn ? "WebUI login password" : "WebUI 访问密码"
            ) {
                SecureField(isEn ? "WebUI Password" : "WebUI 密码", text: $viewModel.config.password)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 220)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Bypass Localhost Authentication" : "跳过本地主机验证",
                subtitle: isEn ? "Enable if 'Bypass authentication for clients on localhost' is checked in qBittorrent" : "在 qBittorrent 首选项开启了 Localhost Bypass 时可启用"
            ) {
                Toggle("", isOn: $viewModel.config.bypassLocalhost)
                    .toggleStyle(.switch)
            }
        }

        SettingsGroup(title: isEn ? "Connectivity Diagnostic" : "连通性检测") {
            SettingsRow(
                title: isEn ? "Test Connection to qBittorrent" : "测试与 qBittorrent 连通性",
                subtitle: isEn ? "Probe target endpoint and fetch server version & latency" : "即时探测目标地址与服务端版本号"
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

                    Button(isEn ? "Test Connection" : "测试连接") {
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
                            .foregroundStyle(.tint)
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

        SettingsGroup(title: isEn ? "Layout Style" : "显示布局") {
            SettingsRow(
                title: isEn ? "Menu Bar Display Mode" : "状态栏显示布局",
                subtitle: isEn ? "Select download/upload speed presentation mode" : "选择屏幕顶部的速度展示模式"
            ) {
                Picker("", selection: $viewModel.config.menuBarStyle) {
                    ForEach(MenuBarStyle.allCases) { style in
                        Text(style.localizedTitle(isEn: isEn)).tag(style)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 210)
            }
        }

        SettingsGroup(title: isEn ? "Task Progress Display" : "任务完成度显示") {
            SettingsRow(
                title: isEn ? "Show Task Progress in Menu Bar" : "在菜单栏显示任务进度",
                subtitle: isEn ? "Display active downloading torrent percentage badge next to speed" : "在状态栏速度旁以百分比气泡显示正在下载任务的完成度"
            ) {
                Toggle("", isOn: $viewModel.config.showPinnedProgress)
                    .toggleStyle(.switch)
            }

            if viewModel.config.showPinnedProgress {
                SettingsDivider()

                SettingsRow(
                    title: isEn ? "Selected Torrent" : "选择展示的任务",
                    subtitle: isEn ? "Pin specific torrent or auto-select most active download" : "固定特定任务或由系统自动选择最活跃下载任务"
                ) {
                    Picker("", selection: Binding(
                        get: { viewModel.config.pinnedTorrentHash ?? "none" },
                        set: { viewModel.config.pinnedTorrentHash = ($0 == "none" ? nil : $0) }
                    )) {
                        Text(isEn ? "Do Not Show" : "不显示").tag("none")
                        Text(isEn ? "Auto (Most Active Torrent)" : "自动选择 (最活跃下载任务)").tag("auto")
                        if !viewModel.torrents.isEmpty {
                            Divider()
                            ForEach(viewModel.torrents) { torrent in
                                Text("\(torrent.name) (\(String(format: "%.0f%%", torrent.progress * 100)))")
                                    .tag(torrent.hash)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 230)
                }
            }
        }

        SettingsGroup(title: isEn ? "Icon & Colors" : "图标与外观") {
            SettingsRow(
                title: isEn ? "Logo Icon Theme" : "图标色彩主题",
                subtitle: isEn ? "Choose qBittorrent menu bar logo color scheme" : "选择 qBittorrent 状态栏图标色彩"
            ) {
                Picker("", selection: $viewModel.config.iconTheme) {
                    ForEach(IconTheme.allCases) { theme in
                        Text(theme.localizedTitle(isEn: isEn)).tag(theme)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 210)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Icon Size" : "图标大小",
                subtitle: isEn ? "Adjust status bar icon rendering scale" : "调整菜单栏图标渲染尺寸"
            ) {
                Picker("", selection: $viewModel.config.iconSize) {
                    ForEach(IconSizeOption.allCases) { sizeOpt in
                        Text(sizeOpt.localizedTitle(isEn: isEn)).tag(sizeOpt)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 210)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Arrow Color Scheme" : "下载箭头颜色",
                subtitle: isEn ? "Choose upload/download arrow color mode" : "设置下载指示箭头的展示颜色 (支持黑/白)"
            ) {
                Picker("", selection: $viewModel.config.arrowTheme) {
                    ForEach(ArrowTheme.allCases) { theme in
                        Text(theme.localizedTitle(isEn: isEn)).tag(theme)
                    }
                }
                .pickerStyle(.menu)
                .frame(width: 210)
            }
        }
    }

    @ViewBuilder
    private var notificationsPane: some View {
        SettingsGroup(title: isEn ? "System Notifications" : "系统通知") {
            SettingsRow(
                title: isEn ? "Enable macOS Notifications" : "启用系统通知",
                subtitle: isEn ? "Receive task status change alerts in Notification Center" : "在 macOS 屏幕右上角接收任务状态横幅"
            ) {
                Toggle("", isOn: $viewModel.config.enableNotifications)
                    .toggleStyle(.switch)
            }

            if viewModel.config.enableNotifications {
                SettingsDivider()

                SettingsRow(
                    title: isEn ? "📥 Download Started" : "📥 下载开始时通知",
                    subtitle: isEn ? "Notify when a newly added task begins downloading" : "检测到新任务开始下载时提醒"
                ) {
                    Toggle("", isOn: $viewModel.config.notifyOnStart)
                        .toggleStyle(.switch)
                }

                SettingsDivider()

                SettingsRow(
                    title: isEn ? "🎉 Download Completed" : "🎉 下载完成时通知",
                    subtitle: isEn ? "Notify when a task finishes downloading (click to reveal in Finder)" : "任务下载完成时提醒，点击通知可直接在 Finder 中定位"
                ) {
                    Toggle("", isOn: $viewModel.config.notifyOnComplete)
                        .toggleStyle(.switch)
                }
            }
        }
    }

    @ViewBuilder
    private var advancedPane: some View {
        SettingsGroup(title: isEn ? "Refresh & Performance" : "刷新与频率") {
            SettingsRow(
                title: isEn ? "Background Polling Interval: \(String(format: "%.1f", viewModel.config.pollInterval))s" : "后台轮询刷新间隔: \(String(format: "%.1f", viewModel.config.pollInterval)) 秒",
                subtitle: isEn ? "Frequency of polling speed and task list from qBittorrent" : "向 qBittorrent 请求最新下载速率与任务列表的频率"
            ) {
                Slider(value: $viewModel.config.pollInterval, in: 1.0...10.0, step: 0.5)
                    .frame(width: 180)
            }

            SettingsDivider()

            SettingsRow(
                title: isEn ? "Speed Chart History Duration: \(viewModel.config.chartHistorySeconds)s" : "带宽图表历史时长: \(viewModel.config.chartHistorySeconds) 秒",
                subtitle: isEn ? "Time window span recorded in top bandwidth wave chart" : "顶部波形图记录的秒数跨度"
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

        SettingsGroup(title: isEn ? "Reset" : "重置") {
            SettingsRow(
                title: isEn ? "Restore Factory Defaults" : "恢复出厂默认配置",
                subtitle: isEn ? "Reset all API endpoints, appearances, and notification preferences" : "将所有 API 地址、外观与通知重置为初始状态"
            ) {
                Button(isEn ? "Reset to Defaults" : "恢复默认") {
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
                ZStack {
                    if #available(macOS 26.0, *) {
                        Circle()
                            .fill(Color(red: 47/255, green: 120/255, blue: 220/255).opacity(0.85))
                            .frame(width: 58, height: 58)
                            .glassEffect(.regular.tint(Color(red: 47/255, green: 120/255, blue: 220/255)), in: .circle)
                            .overlay(
                                Circle()
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.65),
                                                Color.white.opacity(0.15)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: Color.blue.opacity(0.35), radius: 8, x: 0, y: 4)

                        Text("qb")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 1)
                    } else {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 47/255, green: 120/255, blue: 220/255),
                                        Color(red: 35/255, green: 80/255, blue: 170/255)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 58, height: 58)
                            .overlay(
                                Circle()
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.65),
                                                Color.white.opacity(0.15)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: Color.blue.opacity(0.28), radius: 6, x: 0, y: 3)

                        Text("qb")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                }

                VStack(spacing: 4) {
                    Text("QBMenubar")
                        .font(.system(size: 17, weight: .bold))

                    Text(isEn ? "Version 1.2.0 (Build 2026.11)" : "版本 1.2.0 (Build 2026.11)")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)

                    Text(isEn ? "Lightweight & elegant native qBittorrent macOS menu bar controller" : "轻量优雅的 qBittorrent macOS 原生菜单栏控制中心")
                        .font(.system(size: 11))
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)

            // Open Source & Community
            SettingsGroup(title: isEn ? "Open Source & Community" : "开源与社区") {
                SettingsRow(
                    title: isEn ? "GitHub Repository" : "GitHub 开源仓库",
                    subtitle: "https://github.com/133hou/QBMenubar"
                ) {
                    LinkButton(
                        title: isEn ? "Repository" : "访问仓库",
                        urlString: "https://github.com/133hou/QBMenubar"
                    )
                }

                SettingsDivider()

                SettingsRow(
                    title: isEn ? "Releases & Updates" : "版本发布与更新日志",
                    subtitle: isEn ? "Get the latest releases and changelogs" : "查看历史构建与最新更新说明"
                ) {
                    LinkButton(
                        title: isEn ? "Releases" : "查看发布",
                        urlString: "https://github.com/133hou/QBMenubar/releases"
                    )
                }

                SettingsDivider()

                SettingsRow(
                    title: isEn ? "Issues & Feedback" : "问题反馈与功能建议",
                    subtitle: isEn ? "Report bugs or submit feature suggestions" : "在 GitHub 提交 Issue 或改进建议"
                ) {
                    LinkButton(
                        title: isEn ? "Feedback" : "提交反馈",
                        urlString: "https://github.com/133hou/QBMenubar/issues"
                    )
                }
            }

            // WebUI Quick Access
            SettingsGroup(title: isEn ? "Web Management" : "Web 管理页面") {
                SettingsRow(
                    title: "qBittorrent WebUI",
                    subtitle: isEn ? "Open WebUI management interface in default browser" : "在默认浏览器中打开当前配置的 Web 管理页面"
                ) {
                    Button {
                        viewModel.openWebUI()
                    } label: {
                        HStack(spacing: 4) {
                            Text(isEn ? "Open WebUI" : "打开 WebUI")
                                .font(.system(size: 12, weight: .medium))
                            Image(systemName: "arrow.up.forward.app")
                                .font(.system(size: 11))
                        }
                    }
                    .adaptiveGlassButton(prominent: false)
                }
            }

            // Software Specifications
            SettingsGroup(title: isEn ? "Software Info" : "软件信息") {
                SettingsRow(
                    title: isEn ? "Open Source License" : "开源许可协议"
                ) {
                    InfoBadge(text: "MIT License")
                }

                SettingsDivider()

                SettingsRow(
                    title: isEn ? "Architecture & Stack" : "技术架构"
                ) {
                    InfoBadge(text: "Swift 6 + SwiftUI + Liquid Glass")
                }

                SettingsDivider()

                SettingsRow(
                    title: isEn ? "Compatibility" : "系统兼容性"
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
        if isEn {
            switch viewModel.connectionState {
            case .connected(let ping):
                return "Connected (\(ping)ms)"
            case .connecting:
                return "Connecting..."
            case .disconnected:
                return "Disconnected"
            case .error:
                return "Connection Failed"
            }
        } else {
            switch viewModel.connectionState {
            case .connected(let ping):
                return "已连接 (\(ping)ms)"
            case .connecting:
                return "正在连接..."
            case .disconnected:
                return "未连接"
            case .error:
                return "连接失败"
            }
        }
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
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(.secondary)
                .padding(.leading, 4)

            VStack(spacing: 0) {
                content
            }
            .glassCard(cornerRadius: 10, padding: 0, isInteractive: false)
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
            // Luminous Liquid Glass gradient core
            RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            category.badgeColor.opacity(0.94),
                            category.badgeColor.opacity(0.72)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 22, height: 22)
                .overlay(
                    // Upper glass gloss reflection
                    RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.34),
                                    Color.white.opacity(0.0)
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                )
                .overlay(
                    // Specular glass rim highlight
                    RoundedRectangle(cornerRadius: 6.5, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.70),
                                    Color.white.opacity(0.18),
                                    category.badgeColor.opacity(0.40)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.65
                        )
                )
                .shadow(color: category.badgeColor.opacity(isSelected ? 0.45 : 0.28), radius: 3, x: 0, y: 1.5)

            // Crisp SF Symbol centered inside
            Image(systemName: category.iconName)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.30), radius: 0.5, x: 0, y: 0.5)
        }
        .frame(width: 22, height: 22)
    }
}
