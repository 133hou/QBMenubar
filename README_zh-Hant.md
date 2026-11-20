# QBMenubar - 原生 macOS qBittorrent 選单列控制中心

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <img src="https://img.shields.io/badge/平台-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
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

一款基於 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 構建的輕量級、高性能 macOS 原生狀態列應用。融合 **Liquid Glass 液態玻璃材質** 視覺設計與 **Apple Motion Feel 原生物理彈簧手感**，讓您在 macOS 選單列中隨時隨地監控與管理 qBittorrent 下載任務。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="選單列狀態項效果預覽" width="650" />
</p>

---

## 介面預覽與實機效果

<p align="center">
  <img src="docs/images/preview_popover.png" alt="主彈窗介面預覽" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="偏好設定視窗預覽" width="480" />
</p>

---

## 核心特性

1. **狀態列常駐與動態監控**：
   - 即時上傳 / 下載速率與動態方向圖示。
   - 專屬任務完成度百分比直顯（如 `↓ 12.0 MB/s 85%`）。
   - 文字寬度自動擴展，徹底消除 AppKit 選單列文字裁切。
2. **Liquid Glass 現代毛玻璃主彈窗**：
   - 遵循 macOS 液態材質設計，適配深色與淺色外觀。
   - **即時動態頻寬波形圖**（Swift Charts），平滑呈現流量起伏。
   - 頂部快捷操作列：暫停全部、全部繼續、備用限速（🐢 小烏龜）、一鍵直達 WebUI。
   - 純淨分類過濾標籤（全部、下載中、做種中、已暫停）。
   - **➕ 本地種子發布**：支援解析 `.torrent` 檔案，在新增前預覽內部檔案清單、體積並自訂儲存路徑。
   - **📋 剪貼簿快速新增**：一鍵識別磁力連結（`magnet:`）或 HTTP/HTTPS 種子連結。
3. **互動式種子卡片 & 檔案穿透展開**：
   - 清晰呈現任務名、狀態徽章、漸變進度條、已完成體積、ETA 剩餘時間與速率。
   - **點擊卡片流暢展開內部檔案列表**：直觀展示每一個檔案的專屬類型圖示、檔名、體積與獨立下載百分比。
   - **📌 圖釘一鍵置頂**：點擊卡片右上角圖釘，將指定任務的下載進度鎖定到 macOS 選單列展示。
   - 右鍵選單支援定位 Finder 目錄、重新校驗完整性、刪除任務（支援選擇是否保留本地檔案）。
4. **macOS 系統設定風格偏好面板**：
   - 原生固定雙欄佈局，徹底杜絕側邊欄折疊按鈕。
   - 全面支援自訂 WebUI API（支援本地 `127.0.0.1:8080`、區域網路 NAS、遠端 VPS 或 HTTPS 反代網域）。
   - 內建**連通性測試器**：一鍵探測延遲（Ping）與 qBittorrent 伺服端版本。
   - 支援 macOS 原生系統通知（任務開始下載與下載完成提醒）。

---

## 下載安裝與執行

### 方式 1：直接下載執行檔（推薦，開箱即用）
無需安裝 Xcode 或終端機環境，直接下載預編譯打包好的 macOS 原生應用：

👉 **[下載最新版 QBMenubar v1.0.0 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

1. 下載後按兩下解壓縮出 `QBMenubar.app`；
2. 將其拖入 Finder 的 **「應用程式 (/Applications)」** 資料夾中；
3. **按兩下 `QBMenubar.app` 即可直接執行**！應用將靜默常駐在螢幕頂部的系統選單列。

> [!TIP]
> **首次執行安全提示（Gatekeeper）：**  
> 開源應用首次打開時，macOS 可能會彈出 *「無法打開，因為無法驗證開發者」* 提示。  
> 解決方法：在 Finder 的「應用程式」中，**右鍵（或按住 Control 點擊）`QBMenubar.app`** -> 選擇 **「打開」** -> 在彈窗中點擊 **「打開」** 即可正常放行。  
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

## 授權協議
本專案採用 [MIT License](LICENSE) 授權開源。
