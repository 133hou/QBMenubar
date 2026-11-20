# QBMenubar - Native macOS qBittorrent Menu Bar Controller

<p align="center">
  <b>English</b> | <a href="README_zh.md">简体中文</a>
</p>

A lightweight, high-performance native macOS Menu Bar application built with **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Features **Liquid Glass** aesthetic styling and **Apple Motion Feel** spring physics animations to monitor and manage your qBittorrent downloads from anywhere on your Mac.

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
   - Dedicated `+` button to upload `.torrent` files with pre-download file list inspection & directory chooser.
   - Quick clipboard detection for magnet and HTTP torrent links.
3. **Interactive Torrent Cards**:
   - Detailed status badges, progress bars, size counters, ETA, and speed metrics.
   - Expandable internal file tree viewer with filetype icons and individual download progress.
   - Pin button (📌) to lock any torrent's progress directly onto the macOS menu bar.
4. **macOS System Settings Style Preferences**:
   - Dual-pane layout without sidebar collapse buttons.
   - Fully customizable WebUI API endpoints (support for local, LAN NAS, remote VPS, or reverse proxies).
   - In-app connection tester with live ping and server version detection.
   - Native macOS UserNotifications for download start and completion.

---

## Getting Started

### 1. Download Precompiled App (Recommended)
You can download the ready-to-run macOS app directly from GitHub Releases without installing Xcode or command line tools:

👉 **[Download QBMenubar v1.0.0 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

1. Download and unzip `QBMenubar-v1.0.0-macOS.zip`.
2. Move `QBMenubar.app` to your `/Applications` (Applications) folder.
3. Double-click to launch! It will reside quietly in your macOS Menu Bar.

### 2. Build from Source
If you prefer to compile from source code:
```bash
cd QBMenubar
swift build -c release
./build_app.sh
```

---

## License
MIT License
