import Foundation

public struct L10n {
    public static func tr(
        _ lang: AppLanguage,
        zhHans: String,
        zhHant: String? = nil,
        en: String,
        ja: String? = nil,
        ko: String? = nil,
        de: String? = nil,
        fr: String? = nil,
        es: String? = nil,
        ru: String? = nil
    ) -> String {
        switch lang {
        case .zhHans:
            return zhHans
        case .zhHant:
            return zhHant ?? zhHans
        case .en:
            return en
        case .ja:
            return ja ?? en
        case .ko:
            return ko ?? en
        case .de:
            return de ?? en
        case .fr:
            return fr ?? en
        case .es:
            return es ?? en
        case .ru:
            return ru ?? en
        }
    }

    // Common UI Titles & Actions
    public static func searchSettings(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "搜索设置",
            zhHant: "搜尋設定",
            en: "Search settings",
            ja: "設定を検索",
            ko: "설정 검색",
            de: "Einstellungen suchen",
            fr: "Rechercher dans les réglages",
            es: "Buscar en ajustes",
            ru: "Поиск настроек"
        )
    }

    public static func general(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "通用",
            zhHant: "一般",
            en: "General",
            ja: "一般",
            ko: "일반",
            de: "Allgemein",
            fr: "Général",
            es: "Ajustes generales",
            ru: "Основные"
        )
    }

    public static func webUIConnection(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "WebUI 连接",
            zhHant: "WebUI 連線",
            en: "WebUI Connection",
            ja: "WebUI 接続",
            ko: "WebUI 연결",
            de: "WebUI-Verbindung",
            fr: "Connexion WebUI",
            es: "Conexión WebUI",
            ru: "Подключение к WebUI"
        )
    }

    public static func menuBar(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "菜单栏",
            zhHant: "選單列",
            en: "Menu Bar",
            ja: "メニューバー",
            ko: "메뉴 막대",
            de: "Menüleiste",
            fr: "Barre des menus",
            es: "Barra de menús",
            ru: "Строка меню"
        )
    }

    public static func widgets(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "小组件",
            zhHant: "小工具",
            en: "Widgets",
            ja: "ウィジェット",
            ko: "위젯",
            de: "Desktop-Widgets",
            fr: "Widgets de bureau",
            es: "Widgets de escritorio",
            ru: "Виджеты"
        )
    }

    public static func notifications(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "通知",
            zhHant: "通知",
            en: "Notifications",
            ja: "通知",
            ko: "알림",
            de: "Benachrichtigungen",
            fr: "Notifications système",
            es: "Notificaciones",
            ru: "Уведомления"
        )
    }

    public static func advanced(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "高级",
            zhHant: "進階",
            en: "Advanced",
            ja: "詳細設定",
            ko: "고급",
            de: "Erweitert",
            fr: "Avancé",
            es: "Avanzado",
            ru: "Расширенные"
        )
    }

    public static func about(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "关于",
            zhHant: "關於",
            en: "About",
            ja: "情報",
            ko: "정보",
            de: "Über",
            fr: "À propos",
            es: "Acerca de",
            ru: "О программе"
        )
    }

    // Connection Status
    public static func connected(_ lang: AppLanguage, ping: Int) -> String {
        tr(
            lang,
            zhHans: "已连接 (\(ping)ms)",
            zhHant: "已連線 (\(ping)ms)",
            en: "Connected (\(ping)ms)",
            ja: "接続済み (\(ping)ms)",
            ko: "연결됨 (\(ping)ms)",
            de: "Verbunden (\(ping)ms)",
            fr: "Connecté (\(ping)ms)",
            es: "Conectado (\(ping)ms)",
            ru: "Подключено (\(ping) мс)"
        )
    }

    public static func connecting(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "正在连接...",
            zhHant: "正在連線...",
            en: "Connecting...",
            ja: "接続中...",
            ko: "연결 중...",
            de: "Verbinden...",
            fr: "Connexion en cours...",
            es: "Conectando...",
            ru: "Подключение..."
        )
    }

    public static func disconnected(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "未连接",
            zhHant: "未連線",
            en: "Disconnected",
            ja: "未接続",
            ko: "연결 끊김",
            de: "Nicht verbunden",
            fr: "Déconnecté",
            es: "Desconectado",
            ru: "Не подключено"
        )
    }

    public static func connectionFailed(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "连接失败",
            zhHant: "連線失敗",
            en: "Connection Failed",
            ja: "接続失敗",
            ko: "연결 실패",
            de: "Verbindung fehlgeschlagen",
            fr: "Échec de connexion",
            es: "Error de conexión",
            ru: "Сбой подключения"
        )
    }

    // General Pane
    public static func systemGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "系统",
            zhHant: "系統",
            en: "System",
            ja: "システム",
            ko: "시스템",
            de: "System",
            fr: "Système",
            es: "Sistema",
            ru: "Система"
        )
    }

    public static func language(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "语言",
            zhHant: "語言",
            en: "Language",
            ja: "言語",
            ko: "언어",
            de: "Sprache",
            fr: "Langue",
            es: "Idioma",
            ru: "Язык"
        )
    }

    public static func languageSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "更改显示语言，即时生效",
            zhHant: "更改顯示語言，即時生效",
            en: "Change display language, takes effect immediately",
            ja: "表示言語を変更（即時反映）",
            ko: "표시 언어 변경 (즉시 적용)",
            de: "Anzeigesprache ändern, wird sofort wirksam",
            fr: "Changer la langue d'affichage, effet immédiat",
            es: "Cambiar idioma de visualización, surte efecto de inmediato",
            ru: "Изменить язык интерфейса, применяется сразу"
        )
    }

    public static func webConsole(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "qBittorrent 网页控制台",
            zhHant: "qBittorrent 網頁主控台",
            en: "qBittorrent Web Console",
            ja: "qBittorrent Web コンソール",
            ko: "qBittorrent 웹 콘솔",
            de: "qBittorrent Web-Konsole",
            fr: "Console Web qBittorrent",
            es: "Consola web de qBittorrent",
            ru: "Веб-консоль qBittorrent"
        )
    }

    public static func webConsoleSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "直接在系统默认浏览器中打开 WebUI",
            zhHant: "直接在系統預設瀏覽器中開啟 WebUI",
            en: "Open WebUI directly in your default browser",
            ja: "標準ブラウザで WebUI を直接開く",
            ko: "기본 브라우저에서 WebUI를 직접 열기",
            de: "WebUI direkt im Standardbrowser öffnen",
            fr: "Ouvrir WebUI directement dans le navigateur par défaut",
            es: "Abrir WebUI directamente en el navegador predeterminado",
            ru: "Открыть WebUI в браузере по умолчанию"
        )
    }

    public static func openWebUI(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "打开 WebUI",
            zhHant: "開啟 WebUI",
            en: "Open WebUI",
            ja: "WebUI を開く",
            ko: "WebUI 열기",
            de: "WebUI öffnen",
            fr: "Ouvrir WebUI",
            es: "Abrir WebUI",
            ru: "Открыть WebUI"
        )
    }

    // Connection Pane
    public static func networkConnectionGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "网络连接",
            zhHant: "網路連線",
            en: "Network Connection",
            ja: "ネットワーク接続",
            ko: "네트워크 연결",
            de: "Netzwerkverbindung",
            fr: "Connexion réseau",
            es: "Conexión de red",
            ru: "Сетевое подключение"
        )
    }

    public static func clientTypeTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "客户端类型",
            zhHant: "客戶端類型",
            en: "Torrent Client",
            ja: "クライアントの種類",
            ko: "클라이언트 유형",
            de: "Torrent-Client",
            fr: "Client Torrent",
            es: "Cliente Torrent",
            ru: "Клиент торрента"
        )
    }

    public static func clientTypeSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "选择后台下载服务类型 (支持 qBittorrent 与 Transmission)",
            zhHant: "選擇後台下載服務類型 (支援 qBittorrent 與 Transmission)",
            en: "Choose your background BitTorrent client (supports qBittorrent & Transmission)",
            ja: "バックグラウンドのクライアントを選択 (qBittorrent および Transmission に対応)",
            ko: "백그라운드 다운로드 클라이언트 선택 (qBittorrent 및 Transmission 지원)",
            de: "BitTorrent-Client im Hintergrund wählen (unterstützt qBittorrent & Transmission)",
            fr: "Choisir le client BitTorrent en arrière-plan (prend en charge qBittorrent & Transmission)",
            es: "Elige tu cliente BitTorrent en segundo plano (compatible con qBittorrent y Transmission)",
            ru: "Выберите фоновый BitTorrent-клиент (поддерживает qBittorrent и Transmission)"
        )
    }

    public static func serverAddress(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "服务器地址",
            zhHant: "伺服器位址",
            en: "Server Address",
            ja: "サーバーアドレス",
            ko: "서버 주소",
            de: "Serveradresse",
            fr: "Adresse du serveur",
            es: "Dirección del servidor",
            ru: "Адрес сервера"
        )
    }

    public static func serverAddressSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "WebUI 访问地址 (支持本地、NAS 或域名)",
            zhHant: "WebUI 訪問位址 (支援本機、NAS 或網域)",
            en: "WebUI URL (supports localhost, LAN IP, NAS, or domain)",
            ja: "WebUI の URL (localhost、NAS、ドメイン対応)",
            ko: "WebUI 접속 주소 (로컬, NAS 또는 도메인 지원)",
            de: "WebUI-URL (unterstützt localhost, LAN-IP, NAS oder Domain)",
            fr: "URL de WebUI (supporte localhost, IP LAN, NAS ou domaine)",
            es: "URL de WebUI (compatible con localhost, IP LAN, NAS o dominio)",
            ru: "Адрес WebUI (поддерживает localhost, локальный IP, NAS или домен)"
        )
    }

    public static func apiPathPrefix(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "API 路径前缀",
            zhHant: "API 路徑前綴",
            en: "API Path Prefix",
            ja: "API パスプレフィックス",
            ko: "API 경로 접두사",
            de: "API-Pfadpräfix",
            fr: "Préfixe de chemin d'API",
            es: "Prefijo de ruta API",
            ru: "Префикс пути API"
        )
    }

    public static func apiPathPrefixSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "默认 /api/v2，使用反代子目录时可在此修改",
            zhHant: "預設 /api/v2，使用反向代理子目錄時可在此修改",
            en: "Default /api/v2; modify if using reverse proxy subpath",
            ja: "デフォルトは /api/v2（リバースプロキシのサブパス利用時に変更）",
            ko: "기본값은 /api/v2이며 리버스 프록시 하위 경로 사용 시 수정",
            de: "Standard: /api/v2; bei Reverse-Proxy-Unterpfad anpassen",
            fr: "Par défaut /api/v2 ; à modifier en cas de sous-chemin de proxy inverse",
            es: "Predeterminado /api/v2; modificar si se usa una subruta de proxy inverso",
            ru: "По умолчанию /api/v2; измените при использовании подкаталога обратного прокси"
        )
    }

    public static func username(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "用户名",
            zhHant: "使用者名稱",
            en: "Username",
            ja: "ユーザー名",
            ko: "사용자 이름",
            de: "Benutzername",
            fr: "Nom d'utilisateur",
            es: "Nombre de usuario",
            ru: "Имя пользователя"
        )
    }

    public static func usernameSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "WebUI 登录账户",
            zhHant: "WebUI 登入帳號",
            en: "WebUI login account",
            ja: "WebUI ログインアカウント",
            ko: "WebUI 로그인 계정",
            de: "WebUI-Anmeldekonto",
            fr: "Compte de connexion WebUI",
            es: "Cuenta de inicio de sesión de WebUI",
            ru: "Учетная запись для входа в WebUI"
        )
    }

    public static func password(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "密码",
            zhHant: "密碼",
            en: "Password",
            ja: "パスワード",
            ko: "비밀번호",
            de: "Passwort",
            fr: "Mot de passe",
            es: "Contraseña",
            ru: "Пароль"
        )
    }

    public static func passwordSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "WebUI 访问密码",
            zhHant: "WebUI 訪問密碼",
            en: "WebUI login password",
            ja: "WebUI ログインパスワード",
            ko: "WebUI 접속 비밀번호",
            de: "WebUI-Anmeldepasswort",
            fr: "Mot de passe de connexion WebUI",
            es: "Contraseña de inicio de sesión de WebUI",
            ru: "Пароль для входа в WebUI"
        )
    }

    public static func passwordPlaceholder(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "WebUI 密码",
            zhHant: "WebUI 密碼",
            en: "WebUI Password",
            ja: "WebUI パスワード",
            ko: "WebUI 비밀번호",
            de: "WebUI-Passwort",
            fr: "Mot de passe WebUI",
            es: "Contraseña WebUI",
            ru: "Пароль WebUI"
        )
    }

    public static func bypassLocalhost(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "跳过本地主机验证",
            zhHant: "略過本機主機驗證",
            en: "Bypass Localhost Authentication",
            ja: "ローカルホスト認証をバイパス",
            ko: "로컬 호스트 인증 우회",
            de: "Localhost-Authentifizierung umgehen",
            fr: "Contourner l'authentification localhost",
            es: "Omitir autenticación de localhost",
            ru: "Обход аутентификации localhost"
        )
    }

    public static func bypassLocalhostSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在 qBittorrent 首选项开启了 Localhost Bypass 时可启用",
            zhHant: "在 qBittorrent 偏好設定啟用了 Localhost Bypass 時可啟用",
            en: "Enable if 'Bypass authentication for clients on localhost' is checked in qBittorrent",
            ja: "qBittorrent で「ローカルホストの認証をバイパス」が有効な場合に設定",
            ko: "qBittorrent 설정에서 '로컬 호스트 클라이언트 인증 우회'를 켠 경우 활성화",
            de: "Aktivieren, wenn „Authentifizierung für Clients auf localhost umgehen“ in qBittorrent aktiviert ist",
            fr: "Activer si « Contourner l'authentification pour localhost » est coché dans qBittorrent",
            es: "Activar si 'Omitir autenticación para clientes en localhost' está marcado en qBittorrent",
            ru: "Включите, если в qBittorrent разрешен обход аутентификации для localhost"
        )
    }

    public static func connectivityDiagnosticGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "连通性检测",
            zhHant: "連線能力診斷",
            en: "Connectivity Diagnostic",
            ja: "接続診断",
            ko: "연결 진단",
            de: "Verbindungsdiagnose",
            fr: "Diagnostic de connectivité",
            es: "Diagnóstico de conectividad",
            ru: "Диагностика подключения"
        )
    }

    public static func testConnectionTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "测试与 qBittorrent 连通性",
            zhHant: "測試與 qBittorrent 連線",
            en: "Test Connection to qBittorrent",
            ja: "qBittorrent との接続テスト",
            ko: "qBittorrent 연결 테스트",
            de: "Verbindung zu qBittorrent testen",
            fr: "Tester la connexion à qBittorrent",
            es: "Probar conexión con qBittorrent",
            ru: "Проверить подключение к qBittorrent"
        )
    }

    public static func testConnectionSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "即时探测目标地址与服务端版本号",
            zhHant: "即時探測目標位址與伺服器版本號",
            en: "Probe target endpoint and fetch server version & latency",
            ja: "対象エンドポイントを検証し、サーバーバージョンと遅延を取得",
            ko: "대상 주소를 확인하고 서버 버전 및 대기 시간 조회",
            de: "Zielendpunkt prüfen sowie Serverversion und Latenz abrufen",
            fr: "Sonder le point de terminaison et récupérer la version et la latence",
            es: "Sondear el punto de conexión y obtener versión y latencia del servidor",
            ru: "Проверить адрес и получить версию сервера и задержку"
        )
    }

    public static func testConnectionButton(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "测试连接",
            zhHant: "測試連線",
            en: "Test Connection",
            ja: "接続テスト",
            ko: "연결 테스트",
            de: "Verbindung testen",
            fr: "Tester la connexion",
            es: "Probar conexión",
            ru: "Проверить соединение"
        )
    }

    // Menu Bar Pane
    public static func appearancePreviewGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "实时效果预览",
            zhHant: "即時外觀預覽",
            en: "Live Appearance Preview",
            ja: "外観のリアルタイムプレビュー",
            ko: "실시간 디자인 미리보기",
            de: "Live-Vorschau des Erscheinungsbilds",
            fr: "Aperçu en direct de l'apparence",
            es: "Vista previa en directo del aspecto",
            ru: "Предпросмотр внешнего вида"
        )
    }

    public static func layoutStyleGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "显示布局",
            zhHant: "顯示版面配置",
            en: "Layout Style",
            ja: "表示レイアウト",
            ko: "표시 레이아웃",
            de: "Layout-Stil",
            fr: "Style de disposition",
            es: "Estilo de diseño",
            ru: "Стиль оформления"
        )
    }

    public static func menuBarDisplayMode(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "状态栏显示布局",
            zhHant: "狀態列顯示版面配置",
            en: "Menu Bar Display Mode",
            ja: "メニューバーの表示形式",
            ko: "메뉴 막대 표시 모드",
            de: "Menüleisten-Anzeigemodus",
            fr: "Mode d'affichage de la barre des menus",
            es: "Modo de visualización de la barre de menús",
            ru: "Режим отображения в строке меню"
        )
    }

    public static func menuBarDisplayModeSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "选择屏幕顶部的速度展示模式",
            zhHant: "選擇螢幕頂部的速度展示模式",
            en: "Select download/upload speed presentation mode",
            ja: "画面上部での速度表示形式を選択",
            ko: "화면 상단의 속도 표시 모드 선택",
            de: "Anzeigemodus für Download-/Upload-Geschwindigkeit wählen",
            fr: "Sélectionner le mode d'affichage des vitesses de débit",
            es: "Selecciona el modo de visualización de velocidad de descarga/subida",
            ru: "Выберите режим отображения скорости загрузки/отдачи"
        )
    }

    public static func taskProgressGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "任务完成度显示",
            zhHant: "任務完成度顯示",
            en: "Task Progress Display",
            ja: "タスク進捗表示",
            ko: "작업 진행률 표시",
            de: "Fortschrittsanzeige für Aufgaben",
            fr: "Affichage de la progression des tâches",
            es: "Visualización del progreso de tareas",
            ru: "Отображение прогресса задач"
        )
    }

    public static func showTaskProgress(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在菜单栏显示任务进度",
            zhHant: "在選單列顯示任務進度",
            en: "Show Task Progress in Menu Bar",
            ja: "メニューバーにタスク進捗を表示",
            ko: "메뉴 막대에 작업 진행률 표시",
            de: "Aufgabenfortschritt in Menüleiste anzeigen",
            fr: "Afficher la progression de la tâche dans la barre des menus",
            es: "Mostrar progreso de la tarea en la barra de menús",
            ru: "Показывать прогресс задачи в строке меню"
        )
    }

    public static func showTaskProgressSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在状态栏速度旁以百分比气泡显示正在下载任务的完成度",
            zhHant: "在狀態列速度旁以百分比氣泡顯示正在下載任務的完成度",
            en: "Display active downloading torrent percentage badge next to speed",
            ja: "ステータスバーの速度表示横にダウンロード進捗バッジを表示",
            ko: "상태 표시줄의 속도 옆에 다운로드 진행률 배지를 퍼센트로 표시",
            de: "Prozent-Badge des aktiven Downloads neben der Geschwindigkeit anzeigen",
            fr: "Afficher le badge de pourcentage du téléchargement actif à côté de la vitesse",
            es: "Mostrar insignia de porcentaje de la descarga activa junto a la velocidad",
            ru: "Отображать процент активной загрузки рядом со скоростью"
        )
    }

    public static func selectedTorrent(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "选择展示的任务",
            zhHant: "選擇展示的任務",
            en: "Selected Torrent",
            ja: "表示するタスクを選択",
            ko: "표시할 작업 선택",
            de: "Ausgewählter Torrent",
            fr: "Torrent sélectionné",
            es: "Torrent seleccionado",
            ru: "Выбранный торрент"
        )
    }

    public static func selectedTorrentSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "固定特定任务或由系统自动选择最活跃下载任务",
            zhHant: "固定特定任務或由系統自動選擇最活躍下載任務",
            en: "Pin specific torrent or auto-select most active download",
            ja: "特定のタスクを固定するか、最も活発なダウンロードを自動選択",
            ko: "특정 작업을 고정하거나 가장 활발한 다운로드를 자동 선택",
            de: "Bestimmten Torrent fixieren oder aktivsten Download automatisch wählen",
            fr: "Épingler un torrent précis ou sélectionner automatiquement le plus actif",
            es: "Fijar un torrent concreto o seleccionar automáticamente la descarga más activa",
            ru: "Закрепить конкретный торрент или выбирать самый активный автоматически"
        )
    }

    public static func doNotShow(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "不显示",
            zhHant: "不顯示",
            en: "Do Not Show",
            ja: "非表示",
            ko: "표시 안 함",
            de: "Nicht anzeigen",
            fr: "Ne pas afficher",
            es: "No mostrar",
            ru: "Не показывать"
        )
    }

    public static func autoSelectMostActive(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "自动选择 (最活跃下载任务)",
            zhHant: "自動選擇 (最活躍下載任務)",
            en: "Auto (Most Active Torrent)",
            ja: "自動選択 (最も活発なタスク)",
            ko: "자동 선택 (가장 활발한 다운로드)",
            de: "Automatisch (Aktivster Download)",
            fr: "Automatique (Torrent le plus actif)",
            es: "Automático (Torrent más activo)",
            ru: "Авто (самый активный торрент)"
        )
    }

    public static func iconColorsGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "图标与外观",
            zhHant: "圖示與外觀",
            en: "Icon & Colors",
            ja: "アイコンと配色",
            ko: "아이콘 및 색상",
            de: "Symbole & Farben",
            fr: "Icône et couleurs",
            es: "Icono y colores",
            ru: "Значок и цвета"
        )
    }

    public static func iconThemeTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "图标色彩主题",
            zhHant: "圖示色彩主題",
            en: "Logo Icon Theme",
            ja: "ロゴアイコンテーマ",
            ko: "로고 아이콘 테マ",
            de: "Logo-Symbol-Farbschema",
            fr: "Thème de couleur du logo",
            es: "Tema de color del icono",
            ru: "Тема значка приложения"
        )
    }

    public static func iconThemeSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "选择 qBittorrent 状态栏图标色彩",
            zhHant: "選擇 qBittorrent 狀態列圖示色彩",
            en: "Choose qBittorrent menu bar logo color scheme",
            ja: "メニューバーの qBittorrent ロゴの配色を選択",
            ko: "qBittorrent 메뉴 막대 로고 색상 선택",
            de: "Farbschema für das qBittorrent-Menüleistensymbol wählen",
            fr: "Choisir le jeu de couleurs de l'icône qBittorrent dans la barre des menus",
            es: "Elige el esquema de color del logotipo de qBittorrent en la barra",
            ru: "Выберите цвет значка qBittorrent в строке меню"
        )
    }

    public static func iconSizeTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "图标大小",
            zhHant: "圖示大小",
            en: "Icon Size",
            ja: "アイコンサイズ",
            ko: "아이콘 크기",
            de: "Symbolgröße",
            fr: "Taille de l'icône",
            es: "Tamaño del icono",
            ru: "Размер значка"
        )
    }

    public static func iconSizeSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "调整菜单栏图标渲染尺寸",
            zhHant: "調整選單列圖示渲染尺寸",
            en: "Adjust status bar icon rendering scale",
            ja: "メニューバーアイコンの表示サイズを調整",
            ko: "상태 표시줄 아이콘 렌더링 크기 조정",
            de: "Skalierung des Menüleistensymbols anpassen",
            fr: "Ajuster la taille de rendu de l'icône de la barre des menus",
            es: "Ajustar la escala de renderizado del icono de la barra",
            ru: "Настройка размера значка в строке меню"
        )
    }

    public static func arrowThemeTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "下载箭头颜色",
            zhHant: "下載箭頭顏色",
            en: "Arrow Color Scheme",
            ja: "矢印カラーテーマ",
            ko: "화살표 색상 테마",
            de: "Pfeil-Farbschema",
            fr: "Couleur des flèches",
            es: "Esquema de color de flechas",
            ru: "Цветовая схема стрелок"
        )
    }

    public static func arrowThemeSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "设置下载指示箭头的展示颜色 (支持黑/白)",
            zhHant: "設定下載指示箭頭的展示顏色 (支援黑/白)",
            en: "Choose upload/download arrow color mode",
            ja: "アップロード/ダウンロード矢印のカラーモードを選択",
            ko: "업로드/다운로드 화살표 색상 모드 선택",
            de: "Farbmodus für Upload-/Download-Pfeile wählen",
            fr: "Choisir le mode de couleur des flèches de débit",
            es: "Elegir el modo de color de las flechas de subida y descarga",
            ru: "Выберите цвет стрелок загрузки/отдачи"
        )
    }

    // Notifications Pane
    public static func notificationsGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "系统通知",
            zhHant: "系統通知",
            en: "System Notifications",
            ja: "システム通知",
            ko: "시스템 알림",
            de: "Systembenachrichtigungen",
            fr: "Notifications système",
            es: "Notificaciones del sistema",
            ru: "Системные уведомления"
        )
    }

    public static func enableNotifications(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "启用系统通知",
            zhHant: "啟用系統通知",
            en: "Enable macOS Notifications",
            ja: "macOS 通知を有効にする",
            ko: "macOS 알림 활성화",
            de: "macOS-Benachrichtigungen aktivieren",
            fr: "Activer les notifications macOS",
            es: "Activar notificaciones de macOS",
            ru: "Включить уведомления macOS"
        )
    }

    public static func enableNotificationsSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在 macOS 屏幕右上角接收任务状态横幅",
            zhHant: "在 macOS 螢幕右上角接收任務狀態橫幅",
            en: "Receive task status change alerts in Notification Center",
            ja: "通知センターでタスク状態変更の通知を受信",
            ko: "알림 센터에서 작업 상태 변경 알림 수신",
            de: "Hinweise auf Statusänderungen in der Mitteilungszentrale empfangen",
            fr: "Recevoir les alertes de changement d'état dans le Centre de notifications",
            es: "Recibir avisos de cambio de estado en el Centro de notificaciones",
            ru: "Получать оповещения об изменении состояния в Центре уведомлений"
        )
    }

    public static func notifyOnStartTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "📥 下载开始时通知",
            zhHant: "📥 下載開始時通知",
            en: "📥 Download Started",
            ja: "📥 ダウンロード開始時に通知",
            ko: "📥 다운로드 시작 시 알림",
            de: "📥 Download gestartet",
            fr: "📥 Téléchargement commencé",
            es: "📥 Descarga iniciada",
            ru: "📥 Загрузка началась"
        )
    }

    public static func notifyOnStartSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "检测到新任务开始下载时提醒",
            zhHant: "偵測到新任務開始下載時提醒",
            en: "Notify when a newly added task begins downloading",
            ja: "新しいタスクのダウンロードが始まったときに通知",
            ko: "새로 추가된 작업의 다운로드가 시작될 때 알림",
            de: "Benachrichtigen, wenn ein neuer Download beginnt",
            fr: "Notifier lorsqu'une nouvelle tâche commence à se télécharger",
            es: "Avisar cuando una nueva tarea comience a descargarse",
            ru: "Оповещать о начале скачивания нового торрента"
        )
    }

    public static func notifyOnCompleteTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "🎉 下载完成时通知",
            zhHant: "🎉 下載完成時通知",
            en: "🎉 Download Completed",
            ja: "🎉 ダウンロード完了時に通知",
            ko: "🎉 다운로드 완료 시 알림",
            de: "🎉 Download abgeschlossen",
            fr: "🎉 Téléchargement terminé",
            es: "🎉 Descarga completada",
            ru: "🎉 Загрузка завершена"
        )
    }

    public static func notifyOnCompleteSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "任务下载完成时提醒，点击通知可直接在 Finder 中定位",
            zhHant: "任務下載完成時提醒，點擊通知可直接在 Finder 中定位",
            en: "Notify when a task finishes downloading (click to reveal in Finder)",
            ja: "ダウンロード完了時に通知（クリックで Finder に表示）",
            ko: "다운로드 완료 시 알림 (클릭하여 Finder에서 열기)",
            de: "Benachrichtigen, wenn ein Download fertig ist (Klick öffnet Finder)",
            fr: "Notifier lorsqu'un téléchargement se termine (clic pour afficher dans le Finder)",
            es: "Avisar cuando termine una descarga (haz clic para mostrar en Finder)",
            ru: "Оповещать о завершении загрузки (клик откроет объект в Finder)"
        )
    }

    // Advanced Pane
    public static func refreshPerformanceGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "刷新与频率",
            zhHant: "重新整理與頻率",
            en: "Refresh & Performance",
            ja: "更新とパフォーマンス",
            ko: "새로고침 및 성능",
            de: "Aktualisierung & Leistung",
            fr: "Actualisation et performances",
            es: "Actualización y rendimiento",
            ru: "Обновление и производительность"
        )
    }

    public static func pollingIntervalTitle(_ lang: AppLanguage, seconds: Double) -> String {
        tr(
            lang,
            zhHans: "后台轮询刷新间隔: \(String(format: "%.1f", seconds)) 秒",
            zhHant: "背景輪詢間隔: \(String(format: "%.1f", seconds)) 秒",
            en: "Background Polling Interval: \(String(format: "%.1f", seconds))s",
            ja: "バックグラウンド更新間隔: \(String(format: "%.1f", seconds)) 秒",
            ko: "백그라운드 폴링 간격: \(String(format: "%.1f", seconds))초",
            de: "Hintergrund-Abfrageintervall: \(String(format: "%.1f", seconds)) s",
            fr: "Intervalle d'actualisation en arrière-plan : \(String(format: "%.1f", seconds)) s",
            es: "Intervalo de sondeo en segundo plano: \(String(format: "%.1f", seconds)) s",
            ru: "Интервал опроса в фоне: \(String(format: "%.1f", seconds)) с"
        )
    }

    public static func pollingIntervalSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "向 qBittorrent 请求最新下载速率与任务列表的频率",
            zhHant: "向 qBittorrent 請求最新下載速率與任務清單的頻率",
            en: "Frequency of polling speed and task list from qBittorrent",
            ja: "qBittorrent から最新の速度とタスク一覧を取得する頻度",
            ko: "qBittorrent에서 최신 속도 및 작업 목록을 가져오는 빈도",
            de: "Abfragehäufigkeit von Geschwindigkeiten und Aufgaben von qBittorrent",
            fr: "Fréquence de récupération des vitesses et de la liste des tâches",
            es: "Frecuencia con la que se solicitan las velocidades y la lista de tareas",
            ru: "Частота запросов скорости и списка торрентов у qBittorrent"
        )
    }

    public static func chartDurationTitle(_ lang: AppLanguage, seconds: Int) -> String {
        tr(
            lang,
            zhHans: "带宽图表历史时长: \(seconds) 秒",
            zhHant: "頻寬圖表歷史長度: \(seconds) 秒",
            en: "Speed Chart History Duration: \(seconds)s",
            ja: "速度グラフの履歴期間: \(seconds) 秒",
            ko: "속도 차트 기록 시간: \(seconds)초",
            de: "Geschwindigkeitsdiagramm-Verlauf: \(seconds) s",
            fr: "Durée de l'historique du graphique : \(seconds) s",
            es: "Duración del historial del gráfico: \(seconds) s",
            ru: "Длительность графика скорости: \(seconds) с"
        )
    }

    public static func chartDurationSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "顶部波形图记录的秒数跨度",
            zhHant: "頂部波形圖記錄的秒數跨度",
            en: "Time window span recorded in top bandwidth wave chart",
            ja: "上部の帯域波形グラフに記録される時間範囲",
            ko: "상단 대역폭 차트에 기록되는 시간 범위",
            de: "Zeitfenster im oberen Bandbreitendiagramm",
            fr: "Fenêtre temporelle enregistrée dans le graphique supérieur",
            es: "Intervalo de tiempo registrado en la gráfica de ancho de banda",
            ru: "Временной интервал отображения графика пропускной способности"
        )
    }

    public static func resetGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "重置",
            zhHant: "重設",
            en: "Reset",
            ja: "リセット",
            ko: "재설정",
            de: "Zurücksetzen",
            fr: "Réinitialiser",
            es: "Restablecer",
            ru: "Сброс"
        )
    }

    public static func restoreDefaultsTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "恢复出厂默认配置",
            zhHant: "恢復原廠預設設定",
            en: "Restore Factory Defaults",
            ja: "初期設定に復元",
            ko: "기본 설정으로 복원",
            de: "Werkseinstellungen wiederherstellen",
            fr: "Rétablir les paramètres par défaut",
            es: "Restaurar valores predeterminados",
            ru: "Сбросить до настроек по умолчанию"
        )
    }

    public static func restoreDefaultsSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "将所有 API 地址、外观与通知重置为初始状态",
            zhHant: "將所有 API 位址、外觀與通知重設為初始狀態",
            en: "Reset all API endpoints, appearances, and notification preferences",
            ja: "すべての API 設定、外観、通知を初期状態に戻します",
            ko: "모든 API 주소, 디자인 및 알림 설정을 초기 상태로 재설정",
            de: "Alle API-Endpunkte, Erscheinungsbild- und Benachrichtigungseinstellungen zurücksetzen",
            fr: "Réinitialiser les points de terminaison d'API, l'apparence et les notifications",
            es: "Restablecer todos los puntos de conexión, aspecto y notificaciones",
            ru: "Сбросить все адреса API, настройки внешнего вида и уведомлений"
        )
    }

    public static func resetToDefaultsButton(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "恢复默认",
            zhHant: "恢復預設",
            en: "Reset to Defaults",
            ja: "デフォルトに戻す",
            ko: "기본값 복원",
            de: "Auf Standard zurücksetzen",
            fr: "Rétablir les réglages",
            es: "Restablecer valores",
            ru: "Сбросить настройки"
        )
    }

    // About Pane
    public static func appSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "轻量优雅的 qBittorrent macOS 原生菜单栏控制中心",
            zhHant: "輕量優雅的 qBittorrent macOS 原生選單列控制中心",
            en: "Lightweight & elegant native qBittorrent macOS menu bar controller",
            ja: "軽量でエレガントな macOS 向けネイティブ qBittorrent メニューバーコントローラー",
            ko: "가볍고 우아한 macOS 네이티브 qBittorrent 메뉴 막대 컨트롤 센터",
            de: "Leichter und eleganter nativer macOS-Menüleisten-Controller für qBittorrent",
            fr: "Contrôleur de barre des menus macOS élégant et léger pour qBittorrent",
            es: "Controlador nativo, ligero y elegante para la barra de menús de macOS para qBittorrent",
            ru: "Легкий и элегантный контроллер qBittorrent для строки меню macOS"
        )
    }

    public static func openSourceCommunityGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "开源与社区",
            zhHant: "開源與社群",
            en: "Open Source & Community",
            ja: "オープンソースとコミュニティ",
            ko: "오픈 소스 및 커뮤니티",
            de: "Open Source & Community",
            fr: "Open source et communauté",
            es: "Código abierto y comunidad",
            ru: "Open Source и сообщество"
        )
    }

    public static func githubRepoTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "GitHub 开源仓库",
            zhHant: "GitHub 開源儲存庫",
            en: "GitHub Repository",
            ja: "GitHub リポジトリ",
            ko: "GitHub 저장소",
            de: "GitHub-Repository",
            fr: "Dépôt GitHub",
            es: "Repositorio de GitHub",
            ru: "Репозиторий GitHub"
        )
    }

    public static func visitRepoButton(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "访问仓库",
            zhHant: "造訪儲存庫",
            en: "Repository",
            ja: "リポジトリ",
            ko: "저장소 방문",
            de: "Repository öffnen",
            fr: "Dépôt",
            es: "Repositorio",
            ru: "Репозиторий"
        )
    }

    public static func releasesTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "版本发布与更新日志",
            zhHant: "版本發布與更新日誌",
            en: "Releases & Updates",
            ja: "リリースと更新履歴",
            ko: "릴리스 및 업데이트 기록",
            de: "Releases & Updates",
            fr: "Versions et mises à jour",
            es: "Versiones y actualizaciones",
            ru: "Релизы и обновления"
        )
    }

    public static func releasesSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "查看历史构建与最新更新说明",
            zhHant: "查看歷史建置與最新更新說明",
            en: "Get the latest releases and changelogs",
            ja: "過去のビルドと最新の変更ログを確認",
            ko: "이전 빌드 및 최신 릴리스 정보 확인",
            de: "Neueste Versionen und Änderungsprotokolle ansehen",
            fr: "Consulter les versions récentes et le journal des modifications",
            es: "Ver versiones recientes y notas de cambios",
            ru: "Просмотр выпусков и журнала изменений"
        )
    }

    public static func viewReleasesButton(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "查看发布",
            zhHant: "查看發布",
            en: "Releases",
            ja: "リリース情報",
            ko: "릴리스 보기",
            de: "Releases ansehen",
            fr: "Voir les versions",
            es: "Ver versiones",
            ru: "Релизы"
        )
    }

    public static func issuesFeedbackTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "问题反馈与功能建议",
            zhHant: "問題回報與功能建議",
            en: "Issues & Feedback",
            ja: "問題の報告と提案",
            ko: "이슈 및 피드백",
            de: "Probleme & Feedback",
            fr: "Problèmes et suggestions",
            es: "Incidencias y comentarios",
            ru: "Отзывы и предложения"
        )
    }

    public static func issuesFeedbackSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在 GitHub 提交 Issue 或改进建议",
            zhHant: "在 GitHub 提交 Issue 或改進建議",
            en: "Report bugs or submit feature suggestions",
            ja: "GitHub でバグ報告や機能提案を投稿",
            ko: "GitHub에 버그 보고 또는 기능 제안 등록",
            de: "Fehler melden oder neue Funktionen auf GitHub vorschlagen",
            fr: "Signaler un bug ou proposer des améliorations sur GitHub",
            es: "Informar de errores o proponer mejoras en GitHub",
            ru: "Сообщить об ошибке или предложить функцию на GitHub"
        )
    }

    public static func submitFeedbackButton(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "提交反馈",
            zhHant: "提交回饋",
            en: "Feedback",
            ja: "フィードバック",
            ko: "피드백 보내기",
            de: "Feedback senden",
            fr: "Commentaires",
            es: "Enviar comentarios",
            ru: "Оставить отзыв"
        )
    }

    public static func webManagementGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "Web 管理页面",
            zhHant: "Web 管理頁面",
            en: "Web Management",
            ja: "Web 管理画面",
            ko: "Web 관리 인터페이스",
            de: "Web-Verwaltung",
            fr: "Gestion Web",
            es: "Gestión web",
            ru: "Веб-интерфейс"
        )
    }

    public static func webManagementSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在默认浏览器中打开当前配置的 Web 管理页面",
            zhHant: "在預設瀏覽器中開啟目前設定的 Web 管理頁面",
            en: "Open WebUI management interface in default browser",
            ja: "設定中の WebUI 管理画面を標準ブラウザで開く",
            ko: "기본 브라우저에서 현재 설정된 Web 관리 페이지 열기",
            de: "Aktuell konfigurierte WebUI-Oberfläche im Standardbrowser öffnen",
            fr: "Ouvrir l'interface de gestion Web configurée dans le navigateur par défaut",
            es: "Abrir la interfaz web de gestión en el navegador predeterminado",
            ru: "Открыть настроенный веб-интерфейс в браузере по умолчанию"
        )
    }

    public static func softwareInfoGroup(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "软件信息",
            zhHant: "軟體資訊",
            en: "Software Info",
            ja: "ソフトウェア情報",
            ko: "소프트웨어 정보",
            de: "Software-Informationen",
            fr: "Informations sur le logiciel",
            es: "Información del software",
            ru: "О программе"
        )
    }

    public static func openSourceLicenseTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "开源许可协议",
            zhHant: "開源授權合約",
            en: "Open Source License",
            ja: "オープンソースライセンス",
            ko: "오픈 소스 라이선스",
            de: "Open-Source-Lizenz",
            fr: "Licence Open Source",
            es: "Licencia de código abierto",
            ru: "Лицензия с открытым исходным кодом"
        )
    }

    public static func techStackTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "技术架构",
            zhHant: "技術架構",
            en: "Architecture & Stack",
            ja: "アーキテクチャ & 技術スタック",
            ko: "아키텍처 및 기술 스택",
            de: "Architektur & Stack",
            fr: "Architecture et technologies",
            es: "Arquitectura y tecnologías",
            ru: "Архитектура и стек"
        )
    }

    public static func compatibilityTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "系统兼容性",
            zhHant: "系統相容性",
            en: "Compatibility",
            ja: "互換性",
            ko: "시스템 호환성",
            de: "Kompatibilität",
            fr: "Compatibilité",
            es: "Compatibilidad",
            ru: "Совместимость"
        )
    }

    // Popover Quick Actions & Status
    public static func addTorrentFileTooltip(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "添加上传种子文件 (.torrent)",
            zhHant: "新增上傳種子檔案 (.torrent)",
            en: "Add .torrent File",
            ja: "Torrent ファイル (.torrent) を追加",
            ko: ".torrent 파일 추가",
            de: ".torrent-Datei hinzufügen",
            fr: "Ajouter un fichier .torrent",
            es: "Añadir archivo .torrent",
            ru: "Добавить файл .torrent"
        )
    }

    public static func addClipboardTooltip(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "从剪贴板粘贴添加磁力/下载链接",
            zhHant: "從剪貼簿貼上新增磁力/下載連結",
            en: "Add Magnet or URL from Clipboard",
            ja: "クリップボードからマグネット/URLを追加",
            ko: "클립보드에서 마그넷/URL 추가",
            de: "Magnet-Link oder URL aus Zwischenablage hinzufügen",
            fr: "Ajouter un lien Magnet ou URL depuis le presse-papiers",
            es: "Añadir enlace Magnet o URL desde el portapapeles",
            ru: "Добавить magnet-ссылку или URL из буфера обмена"
        )
    }

    public static func preferencesTooltip(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "偏好设置",
            zhHant: "偏好設定",
            en: "Preferences",
            ja: "設定",
            ko: "환경설정",
            de: "Einstellungen",
            fr: "Préférences",
            es: "Preferencias",
            ru: "Настройки"
        )
    }

    public static func refreshTooltip(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "刷新",
            zhHant: "重新整理",
            en: "Refresh",
            ja: "更新",
            ko: "새로고침",
            de: "Aktualisieren",
            fr: "Actualiser",
            es: "Actualizar",
            ru: "Обновить"
        )
    }

    public static func pauseAll(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "暂停全部",
            zhHant: "全部暫停",
            en: "Pause All",
            ja: "すべて一時停止",
            ko: "모두 일시 정지",
            de: "Alle anhalten",
            fr: "Tout suspendre",
            es: "Pausar todo",
            ru: "Приостановить все"
        )
    }

    public static func resumeAll(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "全部继续",
            zhHant: "全部繼續",
            en: "Resume All",
            ja: "すべて再開",
            ko: "모두 계속",
            de: "Alle fortsetzen",
            fr: "Tout reprendre",
            es: "Reanudar todo",
            ru: "Возобновить все"
        )
    }

    public static func altSpeeds(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "备用限速",
            zhHant: "替代限速",
            en: "Alt Speeds",
            ja: "代替速度",
            ko: "대체 속도",
            de: "Alt-Geschwindigkeiten",
            fr: "Vitesses alternatives",
            es: "Velocidades alt.",
            ru: "Ограничение скорости"
        )
    }

    public static func altActive(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "备用限速中",
            zhHant: "替代限速中",
            en: "Alt Active",
            ja: "代替速度制限中",
            ko: "대체 속도 작동 중",
            de: "Alt-Geschwindigkeit aktiv",
            fr: "Vitesses alt. actives",
            es: "Velocidad alt. activa",
            ru: "Ограничение активно"
        )
    }

    public static func quit(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "退出",
            zhHant: "結束",
            en: "Quit",
            ja: "終了",
            ko: "종료",
            de: "Beenden",
            fr: "Quitter",
            es: "Salir",
            ru: "Выход"
        )
    }

    // Torrent Row Actions
    public static func showInFinder(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在 Finder 中定位文件",
            zhHant: "在 Finder 中顯示檔案",
            en: "Show in Finder",
            ja: "Finder で表示",
            ko: "Finder에서 표시",
            de: "Im Finder anzeigen",
            fr: "Afficher dans le Finder",
            es: "Mostrar en el Finder",
            ru: "Показать в Finder"
        )
    }

    public static func pauseTask(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "暂停任务",
            zhHant: "暫停任務",
            en: "Pause Task",
            ja: "タスクを一時停止",
            ko: "작업 일시 정지",
            de: "Aufgabe anhalten",
            fr: "Suspendre la tâche",
            es: "Pausar tarea",
            ru: "Приостановить"
        )
    }

    public static func resumeTask(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "恢复任务",
            zhHant: "繼續任務",
            en: "Resume Task",
            ja: "タスクを再開",
            ko: "작업 계속",
            de: "Aufgabe fortsetzen",
            fr: "Reprendre la tâche",
            es: "Reanudar tarea",
            ru: "Возобновить"
        )
    }

    public static func forceRecheck(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "重新校验完整性",
            zhHant: "重新校驗完整性",
            en: "Force Recheck",
            ja: "強制再チェック",
            ko: "강제 재검사",
            de: "Prüfung erzwingen",
            fr: "Forcer la revérification",
            es: "Forzar comprobación",
            ru: "Принудительно перепроверить"
        )
    }

    public static func deleteTaskKeepFiles(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "删除任务 (保留文件)",
            zhHant: "刪除任務 (保留檔案)",
            en: "Delete Task (Keep Files)",
            ja: "タスクを削除 (ファイルは保持)",
            ko: "작업 삭제 (파일 유지)",
            de: "Aufgabe löschen (Dateien behalten)",
            fr: "Supprimer la tâche (conserver les fichiers)",
            es: "Eliminar tarea (conservar archivos)",
            ru: "Удалить торрент (сохранить файлы)"
        )
    }

    public static func deleteTaskWithFiles(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "删除任务及本地文件",
            zhHant: "刪除任務及本機檔案",
            en: "Delete Task and Local Files",
            ja: "タスクとローカルファイルを削除",
            ko: "작업 및 로컬 파일 삭제",
            de: "Aufgabe und lokale Dateien löschen",
            fr: "Supprimer la tâche et les fichiers",
            es: "Eliminar tarea y archivos locales",
            ru: "Удалить торрент и файлы"
        )
    }

    public static func pinToMenuBar(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在菜单栏显示此任务进度",
            zhHant: "在選單列顯示此任務進度",
            en: "Pin Task Progress to Menu Bar",
            ja: "メニューバーにこのタスクを固定",
            ko: "메뉴 막대에 이 작업 진행률 고정",
            de: "Diesen Fortschritt in Menüleiste fixieren",
            fr: "Épingler cette tâche à la barre des menus",
            es: "Fijar progreso de esta tarea en la barra",
            ru: "Закрепить этот торрент в строке меню"
        )
    }

    public static func unpinFromMenuBar(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "取消在菜单栏显示",
            zhHant: "取消在選單列顯示",
            en: "Unpin from Menu Bar",
            ja: "メニューバーの固定を解除",
            ko: "메뉴 막대 고정 해제",
            de: "Fixierung in Menüleiste aufheben",
            fr: "Désépingler de la barre des menus",
            es: "Desfijar de la barra de menús",
            ru: "Открепить от строки меню"
        )
    }

    public static func hideFiles(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "收起文件",
            zhHant: "收合檔案",
            en: "Hide",
            ja: "折りたたむ",
            ko: "파일 숨기기",
            de: "Dateien ausblenden",
            fr: "Masquer",
            es: "Ocultar",
            ru: "Скрыть"
        )
    }

    public static func showFiles(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "查看文件",
            zhHant: "檢視檔案",
            en: "Files",
            ja: "ファイル",
            ko: "파일 보기",
            de: "Dateien",
            fr: "Fichiers",
            es: "Archivos",
            ru: "Файлы"
        )
    }

    // Widgets Settings & Permissions
    public static func enableWidgetSync(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "启用桌面小组件同步",
            zhHant: "啟用桌面小工具同步",
            en: "Enable Desktop Widget Sync",
            ja: "ウィジェット同期を有効にする",
            ko: "데스크탑 위젯 동기화 활성화",
            de: "Widget-Synchronisierung aktivieren",
            fr: "Activer la synchronisation des widgets",
            es: "Activar sincronización de widgets",
            ru: "Включить синхронизацию виджетов"
        )
    }

    public static func enableWidgetSyncSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "将 qBittorrent 实时速率和下载进度同步至 macOS 桌面与通知中心小组件",
            zhHant: "將 qBittorrent 即時速率和下載進度同步至 macOS 桌面與通知中心小工具",
            en: "Synchronize qBittorrent real-time speed and torrent progress to macOS desktop and Notification Center widgets",
            ja: "qBittorrent のリアルタイム速度と進捗を macOS デスクトップおよび通知センターのウィジェットに同期",
            ko: "qBittorrent 실시간 속도와 다운로드 진행률을 macOS 데스크탑 및 알림 센터 위젯에 동기화",
            de: "qBittorrent-Echtzeitgeschwindigkeit und Fortschritt mit macOS-Desktop- und Mitteilungszentralen-Widgets synchronisieren",
            fr: "Synchroniser la vitesse et la progression qBittorrent avec les widgets du bureau et du Centre de notifications",
            es: "Sincroniza la velocidad y el progreso en tiempo real de qBittorrent con los widgets de macOS",
            ru: "Синхронизировать скорость и прогресс qBittorrent с виджетами рабочего стола и Центра уведомлений"
        )
    }

    public static func widgetPermissionSection(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "桌面小组件同步与权限",
            zhHant: "桌面小工具同步與權限",
            en: "Desktop Widget Synchronization & Permissions",
            ja: "ウィジェット同期と権限",
            ko: "데스크탑 위젯 동기화 및 권한",
            de: "Widget-Synchronisierung & Berechtigungen",
            fr: "Synchronisation des widgets et autorisations",
            es: "Sincronización de widgets y permisos",
            ru: "Синхронизация виджетов и разрешения"
        )
    }

    public static func widgetPermissionGranted(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已授权 (正常同步中)",
            zhHant: "已授權 (正常同步中)",
            en: "Access Granted (Syncing)",
            ja: "許可済み (同期中)",
            ko: "권한 허용됨 (동기화 중)",
            de: "Berechtigung erteilt (Synchronisation aktiv)",
            fr: "Autorisé (synchronisation active)",
            es: "Permiso concedido (sincronizando)",
            ru: "Разрешено (синхронизация активна)"
        )
    }

    public static func widgetPermissionBlocked(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "需完全磁盘访问权限 (点击下方打开设置)",
            zhHant: "需全能磁碟存取權限 (點擊下方開啟設定)",
            en: "Full Disk Access Required (Click Below)",
            ja: "フルディスクアクセスが必要です (下記をクリック)",
            ko: "전체 디스크 접근 권한 필요 (아래 클릭)",
            de: "Festplattenvollzugriff erforderlich (unten klicken)",
            fr: "Accès complet au disque requis (cliquez ci-dessous)",
            es: "Acceso total al disco requerido (clic abajo)",
            ru: "Требуется полный доступ к диску (нажмите ниже)"
        )
    }

    public static func widgetPermissionDisabled(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "小组件同步已关闭",
            zhHant: "小工具同步已關閉",
            en: "Widget Sync Disabled",
            ja: "ウィジェット同期は無効です",
            ko: "위젯 동기화 비활성화됨",
            de: "Widget-Synchronisierung deaktiviert",
            fr: "Synchronisation des widgets désactivée",
            es: "Sincronización de widgets desactivada",
            ru: "Синхронизация виджетов отключена"
        )
    }

    public static func widgetPermissionDesc(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "由于 macOS 系统安全机制，开源自签名版本需在「完全磁盘访问权限」中添加 QBMenubar 方可实现小组件跨进程数据同步。请点击下方按钮打开设置，点击「+」添加 QBMenubar.app 并开启开关。",
            zhHant: "由於 macOS 系統安全機制，開源自簽名版本需在「全能磁碟存取權限」中新增 QBMenubar 方可實現小工具跨行程資料同步。請點擊下方按鈕開啟設定，點擊「+」新增 QBMenubar.app 並開啟開關。",
            en: "Due to macOS security policies, open-source builds require Full Disk Access to share data with widgets. Click the button below, tap '+', add QBMenubar.app, and enable the toggle.",
            ja: "macOS のセキュリティ仕様により、ウィジェットとのデータ共有には「フルディスクアクセス」が必要です。下のボタンから設定を開き、「+」で QBMenubar.app を追加して有効にしてください。",
            ko: "macOS 보안 정책상 위젯과 데이터를 공유하려면 '전체 디스크 접근 권한'이 필요합니다. 아래 버튼을 눌러 설정을 열고 '+'를 눌러 QBMenubar.app을 추가한 후 토글을 켜주세요.",
            de: "Aufgrund von macOS-Sicherheitsrichtlinien benötigt die App Festplattenvollzugriff zum Teilen von Widget-Daten. Klicken Sie unten, um die Einstellungen zu öffnen, fügen Sie QBMenubar.app hinzu und aktivieren Sie sie.",
            fr: "En raison des exigences de sécurité de macOS, un accès complet au disque est nécessaire pour partager les données avec les widgets. Cliquez ci-dessous, ajoutez QBMenubar.app et activez l'option.",
            es: "Debido a las políticas de seguridad de macOS, se requiere acceso total al disco para compartir datos con los widgets. Haz clic abajo, añade QBMenubar.app y activa el permiso.",
            ru: "Из-за ограничений безопасности macOS для обмена данными с виджетами требуется полный доступ к диску. Нажмите кнопку ниже, добавьте QBMenubar.app и включите переключатель."
        )
    }

    public static func widgetPrivacyPromise(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "🔒 隐私保证：QBMenubar 仅读写一份任务快照（仅含当前任务名、速率与进度），绝不读取您的个人隐私文件或其他应用数据。",
            zhHant: "🔒 隱私保證：QBMenubar 僅讀寫一份任務快照（僅含當前任務名、速率與進度），絕不讀取您的個人隱私檔案或其他應用資料。",
            en: "🔒 Privacy Guarantee: QBMenubar only reads/writes a lightweight status snapshot. It never accesses personal files or data from any other apps.",
            ja: "🔒 プライバシー保護: QBMenubar は軽量なタスクスナップショット（名前、速度、進捗のみ）のみを読み書きし、個人ファイルや他のアプリのデータにはアクセスしません。",
            ko: "🔒 개인정보 보호: QBMenubar는 가벼운 작업 스냅샷(이름, 속도 및 진행률만 포함)만 읽고 쓰며 개인 파일이나 다른 앱 데이터에는 절대 접근하지 않습니다.",
            de: "🔒 Datenschutzgarantie: QBMenubar liest/schreibt nur einen Schnappschuss (Aufgabenname, Rate, Fortschritt) und greift niemals auf persönliche Dateien zu.",
            fr: "🔒 Confidentialité garantie : QBMenubar lit/écrit uniquement un instantané léger d'état et n'accède jamais à vos fichiers personnels.",
            es: "🔒 Garantía de privacidad: QBMenubar solo lee/escribe una instantánea ligera de estado y nunca accede a tus archivos personales.",
            ru: "🔒 Гарантия конфиденциальности: QBMenubar считывает и записывает только снимок статуса и никогда не обращается к личным файлам."
        )
    }

    public static func openFullDiskAccessBtn(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "打开「完全磁盘访问权限」设置",
            zhHant: "開啟「全能磁碟存取」設定",
            en: "Open Full Disk Access Settings",
            ja: "「フルディスクアクセス」設定を開く",
            ko: "'전체 디스크 접근 권한' 설정 열기",
            de: "Einstellungen für Festplattenvollzugriff öffnen",
            fr: "Ouvrir les réglages d'accès complet au disque",
            es: "Abrir ajustes de Acceso total al disco",
            ru: "Открыть настройки полного доступа к диску"
        )
    }

    public static func terminalResetHint(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "提示：也可以在终端运行重置命令：tccutil reset All com.antigravity.QBMenubar",
            zhHant: "提示：亦可在終端機執行重設指令：tccutil reset All com.antigravity.QBMenubar",
            en: "Tip: You can also reset permissions in Terminal: tccutil reset All com.antigravity.QBMenubar",
            ja: "ヒント: ターミナルで権限をリセットすることも可能です: tccutil reset All com.antigravity.QBMenubar",
            ko: "팁: 터미널에서 다음 명령어로 권한을 초기화할 수도 있습니다: tccutil reset All com.antigravity.QBMenubar",
            de: "Tipp: Berechtigungen können auch im Terminal zurückgesetzt werden: tccutil reset All com.antigravity.QBMenubar",
            fr: "Astuce : Vous pouvez aussi réinitialiser les permissions dans le Terminal : tccutil reset All com.antigravity.QBMenubar",
            es: "Consejo: También puedes restablecer los permisos en Terminal: tccutil reset All com.antigravity.QBMenubar",
            ru: "Совет: Вы также можете сбросить права в Терминале: tccutil reset All com.antigravity.QBMenubar"
        )
    }

    // Appearance & Style
    public static func sidebarSelectionStyleTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "侧边栏高亮风格",
            zhHant: "側邊欄高亮風格",
            en: "Sidebar Selection Style",
            ja: "サイドバーの選択スタイル",
            ko: "사이드바 선택 스타일",
            de: "Seitenleisten-Auswahlstil",
            fr: "Style de sélection de la barre latérale",
            es: "Estilo de selección de la barra lateral",
            ru: "Стиль выделения боковой панели"
        )
    }

    public static func sidebarSelectionStyleSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "可选择液态玻璃透镜 (高光流光) 或经典系统纯色高亮",
            zhHant: "可選擇液態玻璃透鏡 (高光流光) 或經典系統純色高亮",
            en: "Choose between Liquid Glass lens with specular reflection or classic solid accent fill",
            ja: "リキッドガラスレンズ（反射光）またはクラシックな単色ハイライトを選択",
            ko: "리퀴드 글래스 렌즈(광택 반사) 또는 클래식 단색 강조 선택",
            de: "Zwischen Liquid-Glass-Linse mit Glanzreflexion oder klassischer Akzentfarbe wählen",
            fr: "Choisir entre lentille Liquid Glass à reflets ou surbrillance classique",
            es: "Elige entre lente Liquid Glass con reflejos o relleno sólido clásico",
            ru: "Выберите линзу Liquid Glass с бликами или классическое сплошное выделение"
        )
    }

    public static func sidebarStyleLiquidGlass(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "液态玻璃透镜 (高光流光)",
            zhHant: "液態玻璃透鏡 (高光流光)",
            en: "Liquid Glass Lens (Specular Reflection)",
            ja: "リキッドガラスレンズ (反射光)",
            ko: "리퀴드 글래스 렌즈 (광택 반사)",
            de: "Liquid-Glass-Linse (Glanzreflexion)",
            fr: "Lentille Liquid Glass (Reflet spéculaire)",
            es: "Lente Liquid Glass (Reflejos)",
            ru: "Линза Liquid Glass (Блики)"
        )
    }

    public static func sidebarStyleClassic(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "经典系统高亮 (纯色)",
            zhHant: "經典系統高亮 (純色)",
            en: "Classic Accent Fill (Flat Solid)",
            ja: "クラシックハイライト (単色)",
            ko: "클래식 강조 (단색)",
            de: "Klassische Akzentfarbe (Einfarbig)",
            fr: "Accentuation classique (Couleur unie)",
            es: "Relleno clásico (Color sólido)",
            ru: "Классическое выделение (Сплошной цвет)"
        )
    }

    // Widget Progress Style
    public static func widgetProgressStyleSection(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "小组件进度条样式",
            zhHant: "小工具進度條樣式",
            en: "Widget Progress Style",
            ja: "ウィジェットの進捗バー形式",
            ko: "위젯 진행률 바 스타일",
            de: "Widget-Fortschrittsstil",
            fr: "Style de progression des widgets",
            es: "Estilo de progreso del widget",
            ru: "Стиль прогресса виджетов"
        )
    }

    public static func widgetProgressIndicatorTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "进度指示器样式",
            zhHant: "進度指示器樣式",
            en: "Progress Indicator Style",
            ja: "進捗インジケーターのスタイル",
            ko: "진행률 표시기 스타일",
            de: "Fortschrittsanzeige-Stil",
            fr: "Style de l'indicateur de progression",
            es: "Estilo del indicador de progreso",
            ru: "Стиль индикатора прогресса"
        )
    }

    public static func widgetProgressIndicatorSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "可选择液态玻璃环形圈或经典横向胶囊进度条",
            zhHant: "可選擇液態玻璃環形圈或經典橫向膠囊進度條",
            en: "Choose between Liquid Glass circular ring or classic linear capsule bar",
            ja: "リキッドガラス円形リングまたはクラシックなカプセル型バーを選択",
            ko: "리퀴드 글래스 원형 링 또는 클래식 가로 캡슐 바 선택",
            de: "Zwischen rundem Liquid-Glass-Ring oder klassischer Kapselleiste wählen",
            fr: "Choisir entre anneau circulaire Liquid Glass ou barre linéaire classique",
            es: "Elige entre anillo circular Liquid Glass o barra lineal clásica",
            ru: "Выберите кольцо Liquid Glass или классическую капсульную полосу"
        )
    }

    public static func widgetStyleCircularGlass(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "液态玻璃环形圈 (流光箭头)",
            zhHant: "液態玻璃環形圈 (流光箭頭)",
            en: "Liquid Glass Ring (Directional Arrow)",
            ja: "リキッドガラス円形リング (光る矢印)",
            ko: "리퀴드 글래스 원형 링 (광택 화살표)",
            de: "Liquid-Glass-Ring (Pfeil mit Glanz)",
            fr: "Anneau Liquid Glass (Flèche lumineuse)",
            es: "Anillo Liquid Glass (Flecha luminosa)",
            ru: "Кольцо Liquid Glass (Стрелка с подсветкой)"
        )
    }

    public static func widgetStyleLinear(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "经典横向胶囊条 (线性)",
            zhHant: "經典橫向膠囊條 (線性)",
            en: "Linear Capsule Bar (Classic)",
            ja: "クラシックカプセルバー (リニア)",
            ko: "클래식 가로 캡슐 바 (선형)",
            de: "Klassische Kapselleiste (Linear)",
            fr: "Barre capsule classique (Linéaire)",
            es: "Barra de cápsula clásica (Lineal)",
            ru: "Классическая капсульная полоса (Линейная)"
        )
    }

    public static func widgetTypesSection(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "小组件规格与添加方式",
            zhHant: "小工具規格與加入方式",
            en: "Widget Types & Instructions",
            ja: "ウィジェットの種類と追加方法",
            ko: "위젯 종류 및 추가 방법",
            de: "Widget-Typen & Anleitung",
            fr: "Types de widgets et instructions",
            es: "Tipos de widgets e instrucciones",
            ru: "Типы виджетов и инструкции"
        )
    }

    public static func widgetInstructionsFooter(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "在桌面空白处右键点击「编辑小组件」（或在通知中心底部点击），搜索「QBMenubar」即可添加。",
            zhHant: "在桌面空白處按右鍵「編輯小工具」（或在通知中心底部點擊），搜尋「QBMenubar」即可加入。",
            en: "Right-click your macOS desktop or open Notification Center, click 'Edit Widgets', and select QBMenubar.",
            ja: "デスクトップを右クリックして「ウィジェットを編集」を選択するか、通知センター下部をクリックして「QBMenubar」を検索して追加してください。",
            ko: "데스크탑 빈 곳을 우클릭하여 '위젯 편집'을 누르거나 알림 센터 하단을 클릭한 뒤 'QBMenubar'를 검색하여 추가하세요。",
            de: "Klicken Sie mit der rechten Maustaste auf den Schreibtisch oder in die Mitteilungszentrale, wählen Sie „Widgets bearbeiten“ und fügen Sie QBMenubar hinzu.",
            fr: "Faites un clic droit sur votre bureau ou ouvrez le Centre de notifications, cliquez sur « Modifier les widgets » et sélectionnez QBMenubar.",
            es: "Haz clic derecho en el escritorio o en el Centro de notificaciones, pulsa 'Editar widgets' y selecciona QBMenubar.",
            ru: "Нажмите правой кнопкой на рабочем столе или в Центре уведомлений, выберите «Изменить виджеты» и добавьте QBMenubar."
        )
    }

    public static func widgetBadgeSmallDesc(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "焦点任务与速率",
            zhHant: "焦點任務與速率",
            en: "Single Task & Speeds",
            ja: "フォーカスタスクと速度",
            ko: "초점 작업 및 속도",
            de: "Einzelaufgabe & Geschwindigkeiten",
            fr: "Tâche principale et vitesses",
            es: "Tarea destacada y velocidades",
            ru: "Активная задача и скорость"
        )
    }

    public static func widgetBadgeMediumDesc(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "多任务列表与带宽",
            zhHant: "多任務列表與頻寬",
            en: "3 Tasks & Speeds",
            ja: "3件のタスクと帯域幅",
            ko: "3개 작업 및 대역폭",
            de: "3 Aufgaben & Bandbreite",
            fr: "3 tâches et bande passante",
            es: "3 tareas y ancho de banda",
            ru: "3 задачи и скорость"
        )
    }

    public static func widgetBadgeLargeDesc(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "全功能看板",
            zhHant: "全功能儀表板",
            en: "Dashboard",
            ja: "ダッシュボード",
            ko: "대시보드",
            de: "Dashboard",
            fr: "Tableau de bord",
            es: "Panel de control",
            ru: "Информационная панель"
        )
    }

    public static func fullDiskAccessTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "完全磁盘访问权限",
            zhHant: "全能磁碟存取權限",
            en: "Full Disk Access",
            ja: "フルディスクアクセス",
            ko: "전체 디스크 접근 권한",
            de: "Festplattenvollzugriff",
            fr: "Accès complet au disque",
            es: "Acceso total al disco",
            ru: "Полный доступ к диску"
        )
    }

    public static func fullDiskAccessSubtitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "macOS 跨进程共享小组件数据所必需",
            zhHant: "macOS 跨行程共享小工具資料所必需",
            en: "Required by macOS for cross-process widget data sharing",
            ja: "ウィジェットとプロセス間データ共有を行うために macOS で必要",
            ko: "macOS에서 프로세스 간 위젯 데이터 공유에 필요",
            de: "Von macOS für die prozessübergreifende Widget-Datenfreigabe erforderlich",
            fr: "Requis par macOS pour le partage de données inter-processus des widgets",
            es: "Requerido por macOS para compartir datos de widgets entre procesos",
            ru: "Требуется macOS для межпроцессного обмена данными с виджетами"
        )
    }

    public static func liveAppearancePreview(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "实时效果预览",
            zhHant: "即時效果預覽",
            en: "Live Appearance Preview",
            ja: "リアルタイムプレビュー",
            ko: "실시간 미리보기",
            de: "Live-Vorschau",
            fr: "Aperçu en direct",
            es: "Vista previa en directo",
            ru: "Предпросмотр в реальном времени"
        )
    }

    // Window Titles
    public static func settingsWindowTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "设置",
            zhHant: "設定",
            en: "Settings",
            ja: "設定",
            ko: "설정",
            de: "Einstellungen",
            fr: "Réglages",
            es: "Ajustes",
            ru: "Настройки"
        )
    }

    public static func addTorrentWindowTitle(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "添加下载任务",
            zhHant: "新增下載任務",
            en: "Add Torrent Task",
            ja: "ダウンロードタスクを追加",
            ko: "다운로드 작업 추가",
            de: "Torrent-Aufgabe hinzufügen",
            fr: "Ajouter une tâche torrent",
            es: "Añadir tarea torrent",
            ru: "Добавить торрент"
        )
    }

    // In-App Action Banners
    public static func bannerAltSpeed(_ lang: AppLanguage, enabled: Bool) -> String {
        if enabled {
            return tr(
                lang,
                zhHans: "已开启备用限速 🐢",
                zhHant: "已啟用替代限速 🐢",
                en: "Alternative speed limits enabled 🐢",
                ja: "代替速度制限を有効にしました 🐢",
                ko: "대체 속도 제한 활성화됨 🐢",
                de: "Alternative Geschwindigkeitsbegrenzung aktiviert 🐢",
                fr: "Limites de vitesse alternatives activées 🐢",
                es: "Límites de velocidad alternativos activados 🐢",
                ru: "Альтернативные ограничения скорости включены 🐢"
            )
        } else {
            return tr(
                lang,
                zhHans: "已关闭备用限速 🐢",
                zhHant: "已關閉替代限速 🐢",
                en: "Alternative speed limits disabled 🐢",
                ja: "代替速度制限を無効にしました 🐢",
                ko: "대체 속도 제한 비활성화됨 🐢",
                de: "Alternative Geschwindigkeitsbegrenzung deaktiviert 🐢",
                fr: "Limites de vitesse alternatives désactivées 🐢",
                es: "Límites de velocidad alternativos desactivados 🐢",
                ru: "Альтернативные ограничения скорости выключены 🐢"
            )
        }
    }

    public static func bannerPausedAll(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已暂停所有任务",
            zhHant: "已暫停所有任務",
            en: "All torrents paused",
            ja: "すべてのタスクを一時停止しました",
            ko: "모든 작업이 일시 중지됨",
            de: "Alle Aufgaben angehalten",
            fr: "Toutes les tâches suspendues",
            es: "Todas las tareas pausadas",
            ru: "Все торренты приостановлены"
        )
    }

    public static func bannerResumedAll(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已恢复所有任务",
            zhHant: "已繼續所有任務",
            en: "All torrents resumed",
            ja: "すべてのタスクを再開しました",
            ko: "모든 작업이 재개됨",
            de: "Alle Aufgaben fortgesetzt",
            fr: "Toutes les tâches reprises",
            es: "Todas las tareas reanudadas",
            ru: "Все торренты возобновлены"
        )
    }

    public static func bannerDeletedTorrent(_ lang: AppLanguage, deleteFiles: Bool) -> String {
        if deleteFiles {
            return tr(
                lang,
                zhHans: "已彻底删除任务与文件",
                zhHant: "已徹底刪除任務與檔案",
                en: "Torrent and files permanently deleted",
                ja: "タスクとファイルを完全に削除しました",
                ko: "작업 및 파일이 완전히 삭제됨",
                de: "Aufgabe und Dateien dauerhaft gelöscht",
                fr: "Tâche et fichiers définitivement supprimés",
                es: "Tarea y archivos eliminados permanentemente",
                ru: "Торрент и файлы безвозвратно удалены"
            )
        } else {
            return tr(
                lang,
                zhHans: "已删除任务",
                zhHant: "已刪除任務",
                en: "Torrent deleted",
                ja: "タスクを削除しました",
                ko: "작업 삭제됨",
                de: "Aufgabe gelöscht",
                fr: "Tâche supprimée",
                es: "Tarea eliminada",
                ru: "Торрент удален"
            )
        }
    }

    public static func bannerRechecking(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已触发校验",
            zhHant: "已觸發校驗",
            en: "Recheck triggered",
            ja: "再チェックを開始しました",
            ko: "재검사가 시작됨",
            de: "Neugenerierung der Prüfsumme ausgelöst",
            fr: "Vérification forcée déclenchée",
            es: "Comprobación forzada iniciada",
            ru: "Проверка запущена"
        )
    }

    public static func bannerPausedOne(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已暂停任务",
            zhHant: "已暫停任務",
            en: "Torrent paused",
            ja: "タスクを一時停止しました",
            ko: "작업 일시 중지됨",
            de: "Aufgabe angehalten",
            fr: "Tâche suspendue",
            es: "Tarea pausada",
            ru: "Торрент приостановлен"
        )
    }

    public static func bannerResumedOne(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已恢复任务",
            zhHant: "已繼續任務",
            en: "Torrent resumed",
            ja: "タスクを再開しました",
            ko: "작업 재개됨",
            de: "Aufgabe fortgesetzt",
            fr: "Tâche reprise",
            es: "Tarea reanudada",
            ru: "Торрент возобновлен"
        )
    }

    public static func bannerClipboardEmpty(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "剪贴板中没有文本",
            zhHant: "剪貼簿中沒有文字",
            en: "Clipboard is empty",
            ja: "クリップボードにテキストがありません",
            ko: "클립보드에 텍스트가 없습니다",
            de: "Zwischenablage ist leer",
            fr: "Le presse-papiers est vide",
            es: "El portapapeles está vacío",
            ru: "Буфер обмена пуст"
        )
    }

    public static func bannerNoValidLinks(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "剪贴板内容不是有效下载链接",
            zhHant: "剪貼簿內容不是有效下載連結",
            en: "Clipboard does not contain a valid download link",
            ja: "クリップボードに有効なダウンロードリンクがありません",
            ko: "클립보드 내용이 유효한 다운로드 링크가 아닙니다",
            de: "Zwischenablage enthält keinen gültigen Download-Link",
            fr: "Le presse-papiers ne contient aucun lien de téléchargement valide",
            es: "El portapapeles no contiene un enlace de descarga válido",
            ru: "Буфер обмена не содержит действительной ссылки для скачивания"
        )
    }

    public static func bannerAddedTorrent(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已成功添加下载任务 📥",
            zhHant: "已成功新增下載任務 📥",
            en: "Torrent added successfully 📥",
            ja: "ダウンロードタスクを正常に追加しました 📥",
            ko: "다운로드 작업이 성공적으로 추가되었습니다 📥",
            de: "Torrent-Aufgabe erfolgreich hinzugefügt 📥",
            fr: "Tâche torrent ajoutée avec succès 📥",
            es: "Tarea torrent añadida correctamente 📥",
            ru: "Торрент успешно добавлен 📥"
        )
    }

    public static func bannerAddFailed(_ lang: AppLanguage, error: String) -> String {
        tr(
            lang,
            zhHans: "添加失败: \(error)",
            zhHant: "新增失敗: \(error)",
            en: "Add failed: \(error)",
            ja: "追加に失敗しました: \(error)",
            ko: "추가 실패: \(error)",
            de: "Hinzufügen fehlgeschlagen: \(error)",
            fr: "Échec de l'ajout : \(error)",
            es: "Error al añadir: \(error)",
            ru: "Ошибка добавления: \(error)"
        )
    }

    public static func bannerLocalPathNotFound(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "本地路径不存在或为远程服务器路径",
            zhHant: "本機路徑不存在或為遠端伺服器路徑",
            en: "Local path not found or points to a remote server",
            ja: "ローカルパスが存在しないか、リモートサーバーのパスです",
            ko: "로컬 경로가 존재하지 않거나 원격 서버 경로입니다",
            de: "Lokaler Pfad nicht gefunden oder Remoteserver-Pfad",
            fr: "Chemin local introuvable ou chemin d'accès serveur distant",
            es: "Ruta local no encontrada o es una ruta remota",
            ru: "Локальный путь не найден или указывает на удаленный сервер"
        )
    }

    public static func bannerPinnedTorrent(_ lang: AppLanguage, name: String) -> String {
        tr(
            lang,
            zhHans: "📌 已在菜单栏固定显示「\(name)」进度",
            zhHant: "📌 已在選單列固定顯示「\(name)」進度",
            en: "📌 Pinned '\(name)' progress to menu bar",
            ja: "📌 メニューバーに「\(name)」の進行状況を固定しました",
            ko: "📌 메뉴 막대에 '\(name)' 진행률이 고정됨",
            de: "📌 Fortschritt für „\(name)“ in der Menüleiste fixiert",
            fr: "📌 Progression de « \(name) » épinglée à la barre des menus",
            es: "📌 Progreso de '\(name)' fijado en la barra de menús",
            ru: "📌 Прогресс «\(name)» закреплен в строке меню"
        )
    }

    public static func bannerUnpinnedTorrent(_ lang: AppLanguage) -> String {
        tr(
            lang,
            zhHans: "已恢复菜单栏自动选择任务",
            zhHant: "已恢復選單列自動選擇任務",
            en: "Menu bar auto-selection restored",
            ja: "メニューバーの自動タスク選択を復元しました",
            ko: "메뉴 막대 자동 작업 선택이 복원됨",
            de: "Automatische Aufgabenauswahl in der Menüleiste wiederhergestellt",
            fr: "Sélection automatique dans la barre des menus rétablie",
            es: "Selección automática de la barra de menús restaurada",
            ru: "Автовыбор задач в строке меню восстановлен"
        )
    }

    public static func bannerActionFailed(_ lang: AppLanguage, error: String) -> String {
        tr(
            lang,
            zhHans: "操作失败: \(error)",
            zhHant: "操作失敗: \(error)",
            en: "Action failed: \(error)",
            ja: "操作に失敗しました: \(error)",
            ko: "작업 실패: \(error)",
            de: "Aktion fehlgeschlagen: \(error)",
            fr: "Échec de l'action : \(error)",
            es: "Operación fallida: \(error)",
            ru: "Действие не удалось: \(error)"
        )
    }
}
