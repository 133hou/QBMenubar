import Foundation

public struct L10n {
    public static func tr(_ lang: AppLanguage, zhHans: String, zhHant: String? = nil, en: String) -> String {
        switch lang {
        case .zhHans:
            return zhHans
        case .zhHant:
            return zhHant ?? zhHans
        case .en, .ja, .ko, .de, .fr, .es, .ru:
            // For all international languages, use English as standard lingua franca
            return en
        }
    }

    // Common UI Titles & Actions
    public static func searchSettings(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "搜索设置", zhHant: "搜尋設定", en: "Search settings")
    }

    public static func general(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "通用", zhHant: "一般", en: "General")
    }

    public static func webUIConnection(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "WebUI 连接", zhHant: "WebUI 連線", en: "WebUI Connection")
    }

    public static func menuBar(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "菜单栏", zhHant: "選單列", en: "Menu Bar")
    }

    public static func widgets(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "小组件", zhHant: "小工具", en: "Widgets")
    }

    public static func notifications(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "通知", zhHant: "通知", en: "Notifications")
    }

    public static func advanced(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "高级", zhHant: "進階", en: "Advanced")
    }

    public static func about(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "关于", zhHant: "關於", en: "About")
    }

    // Connection Status
    public static func connected(_ lang: AppLanguage, ping: Int) -> String {
        tr(lang, zhHans: "已连接 (\(ping)ms)", zhHant: "已連線 (\(ping)ms)", en: "Connected (\(ping)ms)")
    }

    public static func connecting(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "正在连接...", zhHant: "正在連線...", en: "Connecting...")
    }

    public static func disconnected(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "未连接", zhHant: "未連線", en: "Disconnected")
    }

    public static func connectionFailed(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "连接失败", zhHant: "連線失敗", en: "Connection Failed")
    }

    // General Pane
    public static func systemGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "系统", zhHant: "系統", en: "System")
    }

    public static func language(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "语言", zhHant: "語言", en: "Language")
    }

    public static func languageSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "更改显示语言，即时生效", zhHant: "更改顯示語言，即時生效", en: "Change display language, takes effect immediately")
    }

    public static func webConsole(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "qBittorrent 网页控制台", zhHant: "qBittorrent 網頁主控台", en: "qBittorrent Web Console")
    }

    public static func webConsoleSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "直接在系统默认浏览器中打开 WebUI", zhHant: "直接在系統預設瀏覽器中開啟 WebUI", en: "Open WebUI directly in your default browser")
    }

    public static func openWebUI(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "打开 WebUI", zhHant: "開啟 WebUI", en: "Open WebUI")
    }

    // Connection Pane
    public static func networkConnectionGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "网络连接", zhHant: "網路連線", en: "Network Connection")
    }

    public static func serverAddress(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "服务器地址", zhHant: "伺服器位址", en: "Server Address")
    }

    public static func serverAddressSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "qBittorrent WebUI 访问地址 (支持本地、NAS 或域名)", zhHant: "qBittorrent WebUI 訪問位址 (支援本機、NAS 或網域)", en: "qBittorrent WebUI URL (supports localhost, LAN IP, NAS, or domain)")
    }

    public static func apiPathPrefix(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "API 路径前缀", zhHant: "API 路徑前綴", en: "API Path Prefix")
    }

    public static func apiPathPrefixSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "默认 /api/v2，使用反代子目录时可在此修改", zhHant: "預設 /api/v2，使用反向代理子目錄時可在此修改", en: "Default /api/v2; modify if using reverse proxy subpath")
    }

    public static func username(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "用户名", zhHant: "使用者名稱", en: "Username")
    }

    public static func usernameSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "WebUI 登录账户", zhHant: "WebUI 登入帳號", en: "WebUI login account")
    }

    public static func password(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "密码", zhHant: "密碼", en: "Password")
    }

    public static func passwordSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "WebUI 访问密码", zhHant: "WebUI 訪問密碼", en: "WebUI login password")
    }

    public static func passwordPlaceholder(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "WebUI 密码", zhHant: "WebUI 密碼", en: "WebUI Password")
    }

    public static func bypassLocalhost(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "跳过本地主机验证", zhHant: "略過本機主機驗證", en: "Bypass Localhost Authentication")
    }

    public static func bypassLocalhostSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在 qBittorrent 首选项开启了 Localhost Bypass 时可启用", zhHant: "在 qBittorrent 偏好設定啟用了 Localhost Bypass 時可啟用", en: "Enable if 'Bypass authentication for clients on localhost' is checked in qBittorrent")
    }

    public static func connectivityDiagnosticGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "连通性检测", zhHant: "連線能力診斷", en: "Connectivity Diagnostic")
    }

    public static func testConnectionTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "测试与 qBittorrent 连通性", zhHant: "測試與 qBittorrent 連線", en: "Test Connection to qBittorrent")
    }

    public static func testConnectionSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "即时探测目标地址与服务端版本号", zhHant: "即時探測目標位址與伺服器版本號", en: "Probe target endpoint and fetch server version & latency")
    }

    public static func testConnectionButton(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "测试连接", zhHant: "測試連線", en: "Test Connection")
    }

    // Menu Bar Pane
    public static func appearancePreviewGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "实时效果预览", zhHant: "即時外觀預覽", en: "Live Appearance Preview")
    }

    public static func layoutStyleGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "显示布局", zhHant: "顯示版面配置", en: "Layout Style")
    }

    public static func menuBarDisplayMode(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "状态栏显示布局", zhHant: "狀態列顯示版面配置", en: "Menu Bar Display Mode")
    }

    public static func menuBarDisplayModeSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "选择屏幕顶部的速度展示模式", zhHant: "選擇螢幕頂部的速度展示模式", en: "Select download/upload speed presentation mode")
    }

    public static func taskProgressGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "任务完成度显示", zhHant: "任務完成度顯示", en: "Task Progress Display")
    }

    public static func showTaskProgress(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在菜单栏显示任务进度", zhHant: "在選單列顯示任務進度", en: "Show Task Progress in Menu Bar")
    }

    public static func showTaskProgressSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在状态栏速度旁以百分比气泡显示正在下载任务的完成度", zhHant: "在狀態列速度旁以百分比氣泡顯示正在下載任務的完成度", en: "Display active downloading torrent percentage badge next to speed")
    }

    public static func selectedTorrent(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "选择展示的任务", zhHant: "選擇展示的任務", en: "Selected Torrent")
    }

    public static func selectedTorrentSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "固定特定任务或由系统自动选择最活跃下载任务", zhHant: "固定特定任務或由系統自動選擇最活躍下載任務", en: "Pin specific torrent or auto-select most active download")
    }

    public static func doNotShow(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "不显示", zhHant: "不顯示", en: "Do Not Show")
    }

    public static func autoSelectMostActive(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "自动选择 (最活跃下载任务)", zhHant: "自動選擇 (最活躍下載任務)", en: "Auto (Most Active Torrent)")
    }

    public static func iconColorsGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "图标与外观", zhHant: "圖示與外觀", en: "Icon & Colors")
    }

    public static func iconThemeTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "图标色彩主题", zhHant: "圖示色彩主題", en: "Logo Icon Theme")
    }

    public static func iconThemeSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "选择 qBittorrent 状态栏图标色彩", zhHant: "選擇 qBittorrent 狀態列圖示色彩", en: "Choose qBittorrent menu bar logo color scheme")
    }

    public static func iconSizeTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "图标大小", zhHant: "圖示大小", en: "Icon Size")
    }

    public static func iconSizeSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "调整菜单栏图标渲染尺寸", zhHant: "調整選單列圖示渲染尺寸", en: "Adjust status bar icon rendering scale")
    }

    public static func arrowThemeTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "下载箭头颜色", zhHant: "下載箭頭顏色", en: "Arrow Color Scheme")
    }

    public static func arrowThemeSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "设置下载指示箭头的展示颜色 (支持黑/白)", zhHant: "設定下載指示箭頭的展示顏色 (支援黑/白)", en: "Choose upload/download arrow color mode")
    }

    // Notifications Pane
    public static func notificationsGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "系统通知", zhHant: "系統通知", en: "System Notifications")
    }

    public static func enableNotifications(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "启用系统通知", zhHant: "啟用系統通知", en: "Enable macOS Notifications")
    }

    public static func enableNotificationsSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在 macOS 屏幕右上角接收任务状态横幅", zhHant: "在 macOS 螢幕右上角接收任務狀態橫幅", en: "Receive task status change alerts in Notification Center")
    }

    public static func notifyOnStartTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "📥 下载开始时通知", zhHant: "📥 下載開始時通知", en: "📥 Download Started")
    }

    public static func notifyOnStartSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "检测到新任务开始下载时提醒", zhHant: "偵測到新任務開始下載時提醒", en: "Notify when a newly added task begins downloading")
    }

    public static func notifyOnCompleteTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "🎉 下载完成时通知", zhHant: "🎉 下載完成時通知", en: "🎉 Download Completed")
    }

    public static func notifyOnCompleteSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "任务下载完成时提醒，点击通知可直接在 Finder 中定位", zhHant: "任務下載完成時提醒，點擊通知可直接在 Finder 中定位", en: "Notify when a task finishes downloading (click to reveal in Finder)")
    }

    // Advanced Pane
    public static func refreshPerformanceGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "刷新与频率", zhHant: "重新整理與頻率", en: "Refresh & Performance")
    }

    public static func pollingIntervalTitle(_ lang: AppLanguage, seconds: Double) -> String {
        tr(lang, zhHans: "后台轮询刷新间隔: \(String(format: "%.1f", seconds)) 秒", zhHant: "背景輪詢間隔: \(String(format: "%.1f", seconds)) 秒", en: "Background Polling Interval: \(String(format: "%.1f", seconds))s")
    }

    public static func pollingIntervalSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "向 qBittorrent 请求最新下载速率与任务列表的频率", zhHant: "向 qBittorrent 請求最新下載速率與任務清單的頻率", en: "Frequency of polling speed and task list from qBittorrent")
    }

    public static func chartDurationTitle(_ lang: AppLanguage, seconds: Int) -> String {
        tr(lang, zhHans: "带宽图表历史时长: \(seconds) 秒", zhHant: "頻寬圖表歷史長度: \(seconds) 秒", en: "Speed Chart History Duration: \(seconds)s")
    }

    public static func chartDurationSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "顶部波形图记录的秒数跨度", zhHant: "頂部波形圖記錄的秒數跨度", en: "Time window span recorded in top bandwidth wave chart")
    }

    public static func resetGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "重置", zhHant: "重設", en: "Reset")
    }

    public static func restoreDefaultsTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "恢复出厂默认配置", zhHant: "恢復原廠預設設定", en: "Restore Factory Defaults")
    }

    public static func restoreDefaultsSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "将所有 API 地址、外观与通知重置为初始状态", zhHant: "將所有 API 位址、外觀與通知重設為初始狀態", en: "Reset all API endpoints, appearances, and notification preferences")
    }

    public static func resetToDefaultsButton(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "恢复默认", zhHant: "恢復預設", en: "Reset to Defaults")
    }

    // About Pane
    public static func appSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "轻量优雅的 qBittorrent macOS 原生菜单栏控制中心", zhHant: "輕量優雅的 qBittorrent macOS 原生選單列控制中心", en: "Lightweight & elegant native qBittorrent macOS menu bar controller")
    }

    public static func openSourceCommunityGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "开源与社区", zhHant: "開源與社群", en: "Open Source & Community")
    }

    public static func githubRepoTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "GitHub 开源仓库", zhHant: "GitHub 開源儲存庫", en: "GitHub Repository")
    }

    public static func visitRepoButton(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "访问仓库", zhHant: "造訪儲存庫", en: "Repository")
    }

    public static func releasesTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "版本发布与更新日志", zhHant: "版本發布與更新日誌", en: "Releases & Updates")
    }

    public static func releasesSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "查看历史构建与最新更新说明", zhHant: "查看歷史建置與最新更新說明", en: "Get the latest releases and changelogs")
    }

    public static func viewReleasesButton(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "查看发布", zhHant: "查看發布", en: "Releases")
    }

    public static func issuesFeedbackTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "问题反馈与功能建议", zhHant: "問題回報與功能建議", en: "Issues & Feedback")
    }

    public static func issuesFeedbackSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在 GitHub 提交 Issue 或改进建议", zhHant: "在 GitHub 提交 Issue 或改進建議", en: "Report bugs or submit feature suggestions")
    }

    public static func submitFeedbackButton(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "提交反馈", zhHant: "提交回饋", en: "Feedback")
    }

    public static func webManagementGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "Web 管理页面", zhHant: "Web 管理頁面", en: "Web Management")
    }

    public static func webManagementSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在默认浏览器中打开当前配置的 Web 管理页面", zhHant: "在預設瀏覽器中開啟目前設定的 Web 管理頁面", en: "Open WebUI management interface in default browser")
    }

    public static func softwareInfoGroup(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "软件信息", zhHant: "軟體資訊", en: "Software Info")
    }

    public static func openSourceLicenseTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "开源许可协议", zhHant: "開源授權合約", en: "Open Source License")
    }

    public static func techStackTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "技术架构", zhHant: "技術架構", en: "Architecture & Stack")
    }

    public static func compatibilityTitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "系统兼容性", zhHant: "系統相容性", en: "Compatibility")
    }

    // Popover Quick Actions & Status
    public static func addTorrentFileTooltip(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "添加上传种子文件 (.torrent)", zhHant: "新增上傳種子檔案 (.torrent)", en: "Add .torrent File")
    }

    public static func addClipboardTooltip(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "从剪贴板粘贴添加磁力/下载链接", zhHant: "從剪貼簿貼上新增磁力/下載連結", en: "Add Magnet or URL from Clipboard")
    }

    public static func preferencesTooltip(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "偏好设置", zhHant: "偏好設定", en: "Preferences")
    }

    public static func refreshTooltip(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "刷新", zhHant: "重新整理", en: "Refresh")
    }

    public static func pauseAll(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "暂停全部", zhHant: "全部暫停", en: "Pause All")
    }

    public static func resumeAll(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "全部继续", zhHant: "全部繼續", en: "Resume All")
    }

    public static func altSpeeds(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "备用限速", zhHant: "替代限速", en: "Alt Speeds")
    }

    public static func altActive(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "备用限速中", zhHant: "替代限速中", en: "Alt Active")
    }

    public static func quit(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "退出", zhHant: "結束", en: "Quit")
    }

    // Torrent Row Actions
    public static func showInFinder(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在 Finder 中定位文件", zhHant: "在 Finder 中顯示檔案", en: "Show in Finder")
    }

    public static func pauseTask(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "暂停任务", zhHant: "暫停任務", en: "Pause Task")
    }

    public static func resumeTask(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "恢复任务", zhHant: "繼續任務", en: "Resume Task")
    }

    public static func forceRecheck(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "重新校验完整性", zhHant: "重新校驗完整性", en: "Force Recheck")
    }

    public static func deleteTaskKeepFiles(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "删除任务 (保留文件)", zhHant: "刪除任務 (保留檔案)", en: "Delete Task (Keep Files)")
    }

    public static func deleteTaskWithFiles(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "删除任务及本地文件", zhHant: "刪除任務及本機檔案", en: "Delete Task and Local Files")
    }

    public static func pinToMenuBar(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "在菜单栏显示此任务进度", zhHant: "在選單列顯示此任務進度", en: "Pin Task Progress to Menu Bar")
    }

    public static func unpinFromMenuBar(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "取消在菜单栏显示", zhHant: "取消在選單列顯示", en: "Unpin from Menu Bar")
    }

    public static func hideFiles(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "收起文件", zhHant: "收合檔案", en: "Hide")
    }

    public static func showFiles(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "查看文件", zhHant: "檢視檔案", en: "Files")
    }

    // Widgets Settings & Permissions
    public static func enableWidgetSync(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "启用桌面小组件同步", zhHant: "啟用桌面小工具同步", en: "Enable Desktop Widget Sync")
    }

    public static func enableWidgetSyncSubtitle(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "将 qBittorrent 实时速率和下载进度同步至 macOS 桌面与通知中心小组件", zhHant: "將 qBittorrent 即時速率和下載進度同步至 macOS 桌面與通知中心小工具", en: "Synchronize qBittorrent real-time speed and torrent progress to macOS desktop and Notification Center widgets")
    }

    public static func widgetPermissionSection(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "跨进程数据共享与权限说明", zhHant: "跨行程資料共享與權限說明", en: "Cross-Process Data Sharing & Permissions")
    }

    public static func widgetPermissionGranted(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "已获得数据共享权限 (正常同步中)", zhHant: "已獲得資料共享權限 (正常同步中)", en: "Data Sharing Permission Granted (Syncing)")
    }

    public static func widgetPermissionBlocked(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "未获得权限或已被系统阻止 (小组件不可用)", zhHant: "未獲得權限或已被系統阻止 (小工具無法使用)", en: "Permission Denied or Blocked by macOS (Widgets Unavailable)")
    }

    public static func widgetPermissionDisabled(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "小组件同步已关闭", zhHant: "小工具同步已關閉", en: "Widget Sync Disabled")
    }

    public static func widgetPermissionDesc(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "由于 macOS 15+ 的系统安全机制，菜单栏主程序与小组件扩展属于独立进程，需通过 App Group 共享容器交换任务快照。开源自签名版本首次访问时，系统会提示「尝试访问来自其他 App 的数据」并可能默认拦截。", zhHant: "由於 macOS 15+ 的系統安全機制，選單列主程式與小工具屬於獨立行程，需透過 App Group 共享容器交換任務快照。開源自簽名版本首次存取時，系統會提示「嘗試存取來自其他 App 的資料」並可能預設攔截。", en: "Due to macOS 15+ security policies, the Menu Bar app and WidgetKit extension run in separate processes and share snapshots via App Groups. For open-source ad-hoc builds, macOS displays 'tried to access your data from other apps' and blocks it by default.")
    }

    public static func widgetPrivacyPromise(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "🔒 隐私保证：QBMenubar 仅在共享容器中读写一份任务快照（仅含当前任务名、速率与进度百分比），绝不读取您的个人隐私或其他任何软件的数据。", zhHant: "🔒 隱私保證：QBMenubar 僅在共享容器中讀寫一份任務快照（僅含當前任務名、速率與進度百分比），絕不讀取您的個人隱私或其他任何軟體的資料。", en: "🔒 Privacy Guarantee: QBMenubar only reads/writes a lightweight status snapshot (torrent names, speeds, progress percentage). It never accesses personal files or data from any other applications.")
    }

    public static func widgetHowToFix(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "若之前拒绝了权限或在「文件与文件夹」设置中未找到 QBMenubar：", zhHant: "若先前拒絕了權限或在「檔案與資料夾」設定中未找到 QBMenubar：", en: "If permission was denied or QBMenubar is missing in Files & Folders settings:")
    }

    public static func retriggerPermissionBtn(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "重新申请权限", zhHant: "重新申請權限", en: "Re-trigger Permission")
    }

    public static func openFilesAndFoldersBtn(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "打开「文件与文件夹」", zhHant: "開啟「檔案與資料夾」", en: "Open Files & Folders")
    }

    public static func openFullDiskAccessBtn(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "完全磁盘访问设置", zhHant: "全能磁碟存取設定", en: "Full Disk Access Settings")
    }

    public static func terminalResetHint(_ lang: AppLanguage) -> String {
        tr(lang, zhHans: "提示：也可以在「终端」运行命令完全重置授权：tccutil reset All com.antigravity.QBMenubar", zhHant: "提示：亦可在「終端機」執行指令重設授權：tccutil reset All com.antigravity.QBMenubar", en: "Tip: You can also reset approval anytime in Terminal: tccutil reset All com.antigravity.QBMenubar")
    }
}
