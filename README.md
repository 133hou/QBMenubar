# QBMenubar - Native macOS qBittorrent Menu Bar Controller

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <img src="https://img.shields.io/badge/Platform-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
</p>

<p align="center">
  <b>English</b> | 
  <a href="README_zh.md">简体中文</a> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <a href="README_ja.md">日本語</a> | 
  <a href="README_ko.md">한국어</a> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

A lightweight, high-performance native macOS Menu Bar application built with **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Features **Liquid Glass** aesthetic styling and **Apple Motion Feel** spring physics animations to monitor and manage your qBittorrent downloads directly from your Mac's status bar.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Menu Bar Header Preview" width="650" />
</p>

---

## Preview & Screenshots

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Popover Interface Preview" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Settings Window Preview" width="480" />
</p>

---

## Highlights

1. **Menu Bar Status Item**:
   - Real-time download/upload speed indicator.
   - Pinned download progress percentage directly in the status bar (e.g. `↓ 12.0 MB/s 85%`).
   - Dynamic adaptive width and high-contrast styling.
2. **Liquid Glass Popover Panel**:
   - Live gradient bandwidth waveform chart with smooth real-time updates.
   - Quick control bar: Pause All, Resume All, Alternate Speed Limits (🐢), WebUI launcher.
   - Categorized filter tabs (All, Downloading, Seeding, Paused).
   - Dedicated **➕** button to upload `.torrent` files with pre-download file list inspection & directory chooser.
   - Quick clipboard detection for magnet and HTTP torrent links.
3. **Interactive Torrent Cards**:
   - Detailed status badges, progress bars, size counters, ETA, and speed metrics.
   - Expandable internal file tree viewer with filetype icons and individual download progress.
   - Pin button (**📌**) to lock any torrent's progress directly onto the macOS menu bar.
4. **macOS System Settings Style Preferences**:
   - Dual-pane layout without sidebar collapse buttons.
   - Fully customizable WebUI API endpoints (support for local, LAN NAS, remote VPS, or reverse proxies).
   - In-app connection tester with live ping and server version detection.
   - Native macOS UserNotifications for download start and completion.

---

## Installation & Running

### Option 1: Direct Download (Recommended)
Download the ready-to-run precompiled macOS App from GitHub Releases:

👉 **[Download QBMenubar v1.0.0 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

1. Download and unzip `QBMenubar-v1.0.0-macOS.zip`.
2. Move `QBMenubar.app` into your `/Applications` folder.
3. Double-click `QBMenubar.app` to launch! It will reside quietly in your macOS Menu Bar.

> [!NOTE]
> **macOS Gatekeeper First-Launch Tip:**  
> If macOS alerts that the app *"cannot be opened because Apple cannot check it for malicious software"* (standard for unsigned open-source apps):  
> Simply **Right-click** (or Control-click) `QBMenubar.app` in Finder, select **Open**, and click **Open** in the dialog.  
> Alternatively, run: `xattr -cr /Applications/QBMenubar.app`

### Option 2: Build from Source
Requirements: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## Configuration & First Launch

1. **Enable qBittorrent WebUI**:
   - Open qBittorrent on your Mac, NAS, or server.
   - Navigate to **Preferences -> Web UI** and check **Web User Interface (Remote control)**.
   - Default address is typically `http://127.0.0.1:8080`.
2. **Connect QBMenubar**:
   - Click the QBMenubar icon in the macOS menu bar.
   - Click the gear icon (**⚙️**) in the top right to open Preferences.
   - Enter your server address, username, and password, then click **Test Connection**.
   - Click **Save** to begin monitoring!

---

## License
Distributed under the MIT License. See [LICENSE](LICENSE) for more information.
