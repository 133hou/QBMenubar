# QBMenubar - 原生 macOS qBittorrent 選單列控制中心

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - 原生 macOS qBittorrent 選單列監控與控制器（Liquid Glass 設計）" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="總下載量"></a>
  <img src="https://img.shields.io/badge/平台-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/架構-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/開源協議-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <a href="README_zh.md">简体中文</a> | 
  <b>繁體中文</b> | 
  <a href="README_ja.md">日本語</a> | 
  <a href="README_ko.md">한국어</a> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**QBMenubar** 是一款基於 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 純原生開發的 macOS 選單列控制應用。融合現代 **Liquid Glass（液態玻璃）** 半透明材質與 **Apple Motion Feel** 原生物理彈簧動效，為您提供近乎零資源開銷（CPU < 0.1%，記憶體 ~40MB）的 qBittorrent 即時速率監控、圖釘任務進度直顯與遠端 NAS WebUI 深度管理體驗。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar 選單列即時速率監控與圖釘進度膠囊預覽" width="650" />
</p>

---

## 🎯 核心使用場景

- 🚀 **本地客戶端與遠端 NAS 雙向監控**：無論 qBittorrent 運行在本地 Mac、群暉（Synology DSM）、威聯通（QNAP）、Unraid、TrueNAS、Docker 容器還是雲端 VPS / Seedbox，只需配置 WebUI 位址（支援內網 IP、網域名稱與 HTTPS 反向代理）即可無縫秒級同步。
- 📌 **關鍵任務選單列圖釘置頂**：點擊卡片右上角圖釘，將正在下載的關鍵種子進度百分比直接固定在螢幕頂部的系統選單列（例如：`↓ 12.0 MB/s 85%`），無需切換視窗。
- ⚡️ **無感低功耗背景常駐**：基於 Swift 6 編譯型原生代碼開發，相較於臃腫的 Electron 包裝器或常開瀏覽器分頁，日常靜默運行 CPU 佔用接近 0.0%，記憶體僅佔用 ~35-45 MB，完全不損耗電池續航。
- 🐢 **會議與遊戲一鍵限速**：頂部快捷面板一鍵暫停所有任務、一鍵繼續，或快速開啟備用限速（🐢 小烏龜模式），開會打遊戲不再被下載搶佔頻寬。
- 📋 **磁力與種子智慧捕獲**：自動識別系統剪貼簿中的 `magnet:` 磁力連結或 HTTP 種子連結，並支援上傳本地 `.torrent` 檔案在下載前預覽內部檔案目錄。

---

## 📸 介面預覽與實機效果

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass 主彈窗、動態頻寬波形圖與種子列表" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS 系統設定風格偏好設定視窗" width="480" />
</p>

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="QBMenubar macOS 桌面與通知中心小工具" width="650" />
</p>

---

## 📊 深度比較：為什麼選擇 QBMenubar？

| 功能維度 | QBMenubar (原生) | 瀏覽器 WebUI 網頁 | 官方 Qt 客戶端 | Python / SwiftBar 腳本外掛 |
|---|:---:|:---:|:---:|:---:|
| **選單列常駐與互動** | ✅ 原生 Liquid Glass 彈窗 | ❌ 僅限網頁視窗 | ❌ 僅限 Dock / 獨立主窗 | ⚠️ 純文字下拉選單（無互動卡片） |
| **選單列圖釘任務進度** | ✅ 選單列黑白單色徽章直顯 | ❌ | ❌ | ❌ |
| **即時動態頻寬波形圖** | ✅ Swift Charts 平滑物理波形 | ⚠️ 靜態更新折線 | ⚠️ 簡易折線 | ❌ |
| **記憶體佔用** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **背景閒置 CPU** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **遠端 NAS / Docker 連線** | ✅ 本地、內網 NAS 與網域反代 | ✅ | ❌ 僅支援本機行程 | ⚠️ 鑑權與反代支援有限 |
| **互動式檔案樹穿透展開** | ✅ 原生卡片層級展開與單檔案進度 | ⚠️ 複雜表格多次點擊 | ⚠️ 密集表格 | ❌ |
| **桌面與通知中心小工具 (WidgetKit)** | ✅ 支援小/中/大三種尺寸 | ❌ | ❌ | ❌ |
| **macOS 系統通知推播** | ✅ 任務下載完成原生通知 | ⚠️ 需瀏覽器權限常駐 | ⚠️ 舊式彈窗 | ❌ |

---

## ✨ 核心特性一覽

1. **選單列常駐與動態監控**：
   - 即時上傳 / 下載速率與動態方向圖示（`↓` / `↑`）。
   - 專屬任務完成度百分比直顯（黑白單色半透明膠囊，完美融入選單列）。
   - 文字寬度自動擴展，徹底杜絕 AppKit 選單列文字裁切與截斷。
2. **Liquid Glass 現代毛玻璃主彈窗**：
   - 遵循 macOS 液態材質設計，高光鏡面邊緣與微光倒影。
   - **即時動態頻寬波形圖**（Swift Charts），平滑呈現流量起伏。
   - 頂部快捷操作列：暫停全部、全部繼續、備用限速（🐢 小烏龜）、一鍵直達 WebUI。
   - 分類過濾標籤：全部、下載中、做種中、已暫停。
   - **➕ 本地種子上傳**：支援解析 `.torrent` 檔案，在添加前預覽內部檔案清單並自訂儲存目錄。
   - **📋 剪貼簿快速添加**：一鍵識別磁力連結（`magnet:`）或 HTTP/HTTPS 種子連結。
3. **互動式種子卡片 & 檔案穿透展開**：
   - 清晰呈現任務名、狀態徽章、漸變進度條、已完成體積、ETA 剩餘時間與速率。
   - **點擊卡片流暢展開內部檔案列表**：直觀展示每一個檔案的專屬類型圖示、檔案名、體積與獨立下載百分比。
   - **📌 圖釘一鍵置頂**：點擊卡片右上角圖釘，將指定任務的下載進度鎖定到 macOS 選單列展示。
   - 右鍵選單支援在 Finder 中定位、重新校驗完整性、刪除任務（支援選擇是否保留本地檔案）。
4. **macOS 系統設定風格偏好面板**：
   - 原生固定雙欄佈局，徹底杜絕側邊欄折疊按鈕。
   - 全面支援自訂 WebUI API（支援本地 `127.0.0.1:8080`、區域網路 NAS、遠端 VPS 或 HTTPS 反代網域）。
   - 內建**連通性測試器**：一鍵探測延遲（Ping）與 qBittorrent 伺服端版本。
   - 支援 macOS 原生系統通知（任務開始下載與下載完成提醒）。
   - 完整 9 種語言本地化支援（繁體中文、簡體中文、English、日本語、한국어、Deutsch、Français、Español、Русский）。
5. **macOS 桌面與通知中心小工具 (WidgetKit)**：
   - **小號組件 (.systemSmall)**：單任務焦點進度卡片，直觀顯示最活躍任務進度條、當前速度與剩餘時間 (ETA)。
   - **中號組件 (.systemMedium)**：雙欄佈局，左側顯示全域即時上傳下載頻寬與任務計數，右側列出前 2-3 個活躍下載任務進度。
   - **大號組件 (.systemLarge)**：全功能任務看板，包含多任務進度、狀態標籤、傳輸統計與一鍵跳轉。
   - **零開銷 App Group 共享儲存**：主應用與小組件處理程序間極速低耗同步。
   - 完美適配 macOS 全彩、深色以及著色/高亮模式 (`widgetAccentable`)。

---

## 📥 下載安裝與執行

### 方式 1：直接下載執行檔（推薦，開箱即用）
無需安裝 Xcode 或終端機環境，直接下載預編譯打包好的 macOS 原生應用：

👉 **[下載最新版 QBMenubar (Latest) (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. 下載後按兩下解壓縮出 `QBMenubar.app`；
2. 將其拖入訪達的 **「應用程式 (/Applications)」** 資料夾中；
3. **按兩下 `QBMenubar.app` 即可直接執行**！應用將靜默常駐在螢幕頂部的系統選單列。

> [!TIP]
> **首次執行安全提示（Gatekeeper）：**  
> 開源應用首次打開時，macOS 可能會彈出 *“無法打開，因為無法驗證開發者”* 提示。  
> 解決方法：在訪達的「應用程式」中，**按右鍵（或按住 Control 點擊）`QBMenubar.app`** -> 選擇 **「打開」** -> 在彈窗中點擊 **「打開」** 即可正常放行。  
> 或在終端機中執行一行指令清除隔離屬性：`xattr -cr /Applications/QBMenubar.app`

### 方式 2：從原始碼本地編譯 (Build from Source)
執行環境：macOS 14.0+，Xcode 15+ / Swift 6.0+。

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## ⚙️ 首次使用配置步驟（1 分鐘快速上手）

1. **啟用 qBittorrent WebUI**：
   - 打開您的 qBittorrent（本地、NAS 或伺服器均可）；
   - 進入 **偏好設定 (Preferences) -> Web UI**，勾選 **Web 使用者介面 (遠端控制)**；
   - 預設連接埠一般為 `8080`，預設本地位址通常為 `http://127.0.0.1:8080`。
2. **連線 QBMenubar**：
   - 點擊 macOS 螢幕右上角選單列的 QBMenubar 圖示；
   - 點擊面板右上角的齒輪圖示 (**⚙️**) 打開偏好設定；
   - 填入您的 WebUI 位址、使用者名稱和密碼，點擊 **測試連線**；
   - 選單列立即開始即時顯示下載與上傳速率！

---

## 🏷️ 搜尋關鍵字與索引標籤 (Keywords)
`qbittorrent` • `qbittorrent-controller` • `qbittorrent-webui` • `qbittorrent-client` • `macos-menubar` • `menubar-app` • `menubar-extra` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid` • `truenas` • `docker`

---

## 📄 開源許可協議
本專案採用 [MIT License](LICENSE) 授權開源。
