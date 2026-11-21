# QBMenubar - Native macOS Menu Bar Controller for qBittorrent

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Native macOS Menu Bar Controller for qBittorrent with Liquid Glass Design" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Downloads"></a>
  <img src="https://img.shields.io/badge/Platform-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/Architecture-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
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

**QBMenubar** is a lightweight, ultra-responsive native macOS Menu Bar controller for **qBittorrent**, engineered with **Swift 6 + SwiftUI + MenuBarExtra (.window)**. It brings the cutting-edge **Liquid Glass** translucent aesthetics and **Apple Motion Feel** spring physics directly to your Mac's status bar — giving you zero-overhead monitoring and remote management for local clients, home NAS, or cloud seedboxes.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar macOS Menu Bar Speed Monitor and Pinned Progress Badge" width="650" />
</p>

---

## 🎯 Use Cases & Key Scenarios

- 🚀 **Local & Remote NAS Monitoring**: Effortlessly monitor and control qBittorrent running on your local Mac, Synology DSM, QNAP, Unraid, TrueNAS, Docker containers, or remote Linux seedboxes via LAN IP, domain, or reverse proxy.
- 📌 **Menu Bar Progress Pinning**: Pin any mission-critical torrent's live download percentage directly next to your macOS clock (e.g. `↓ 12.0 MB/s 85%`).
- ⚡️ **Zero Resource Overhead**: Native compiled Swift 6 binary with ~0.0% idle CPU and under 40 MB RAM — virtually invisible to battery and system performance unlike heavy browser tabs or Electron wrappers.
- 🐢 **One-Click Quick Actions**: Instantly pause/resume all torrents, toggle Alternate Speed Limits (Turtle Mode 🐢) during Zoom meetings or gaming sessions, or open WebUI with one click.
- 📋 **Seamless Torrent Ingestion**: Automatically detects magnet links and `.torrent` URLs from your clipboard, plus full `.torrent` file parsing with pre-download file selection.

---

## 📸 Screenshots & UI Showcase

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass Popover Panel with Speed Chart and Torrent List" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS System Settings Style Preferences Window" width="480" />
</p>

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="QBMenubar macOS Desktop & Notification Center Widgets" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar Widget Settings and Data Access Permissions" width="580" />
</p>

---

## 📊 Feature Comparison: Why QBMenubar?

| Feature | QBMenubar (Native) | WebUI in Browser | Official Qt Desktop Client | Python / ScriptBar Plugins |
|---|:---:|:---:|:---:|:---:|
| **Menu Bar Resident** | ✅ Native Liquid Glass | ❌ (Window only) | ❌ (Dock/Window only) | ⚠️ Text only (No UI) |
| **Pinned Torrent Progress** | ✅ Direct status bar badge | ❌ | ❌ | ❌ |
| **Real-time Speed Waveform** | ✅ Swift Charts smooth wave | ⚠️ Static graph | ⚠️ Basic graph | ❌ |
| **Memory Consumption** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **CPU Idle Usage** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **Remote NAS & Docker Support**| ✅ Local, LAN, NAS & HTTPS | ✅ | ❌ Local instance only | ⚠️ Limited auth |
| **Expandable File Tree Preview**| ✅ Interactive list | ⚠️ Multi-click table | ⚠️ Cluttered table | ❌ |
| **Desktop & Notification Center Widgets**| ✅ Small, Medium & Large (WidgetKit) | ❌ | ❌ | ❌ |
| **macOS Native System Notifications**| ✅ Download complete | ⚠️ Browser permission | ⚠️ Legacy alert | ❌ |

---

## ✨ Features & Highlights

1. **Status Bar Speed & Progress Item**:
   - Real-time download and upload speeds with dynamic directional glyphs (`↓` / `↑`).
   - Pinned torrent progress percentage with unified monochrome badge styling.
   - Dynamic adaptive width calculation — zero truncated labels or flickering.
2. **Liquid Glass Popover Panel**:
   - Native macOS translucent Liquid Glass material with specular rim highlights.
   - **Interactive Bandwidth Waveform** powered by Swift Charts with smooth forward interpolation.
   - Quick actions bar: **Pause All**, **Resume All**, **Alternate Speed Limits (🐢)**, and **WebUI**.
   - Filter tabs with badge counters: *All*, *Downloading*, *Seeding*, and *Paused*.
   - **➕ Upload Torrent**: Parse `.torrent` metadata, inspect file tree, and choose destination path before downloading.
   - **📋 Clipboard Sniffer**: Instant prompt when copying `magnet:?xt=` or `.torrent` web links.
3. **Interactive Torrent Cards**:
   - Rich metrics: progress bars, ETA, size counters, seed/peer ratios, and upload/download speeds.
   - **File Tree Viewer**: Expand any card to inspect individual files with dedicated filetype icons and completion percentages.
   - **📌 Pin to Status Bar**: Lock your current download to the macOS menu bar with a single click.
   - Context Menu: Reveal in Finder, force recheck hash, pause, resume, or delete (with or without files).
4. **macOS System Settings Style Preferences**:
   - Native dual-pane layout without sidebar collapse toggles.
   - Comprehensive multi-language localization (English, 简体中文, 繁體中文, 日本語, 한국어, Deutsch, Français, Español, Русский).
   - In-app **Connectivity Diagnostic Tool** with real-time ping latency and qBittorrent version detection.
   - Full reverse proxy, subpath prefix (`/api/v2`), and localhost bypass support.
5. **macOS Desktop & Notification Center Widgets (WidgetKit)**:
   - **Small Widget (`.systemSmall`)**: Glanceable single-task progress card featuring hero active torrent progress, live download/upload speeds, and remaining ETA.
   - **Medium Widget (`.systemMedium`)**: Split-panel layout displaying global real-time bandwidth metrics alongside top downloading tasks with progress bars.
   - **Large Widget (`.systemLarge`)**: Full download dashboard with active torrent listings, state badges, transfer rates, and instant deep-linking into QBMenubar.
   - **Zero Overhead App Group Storage**: Seamless background sync between the menu bar daemon and macOS Notification Center.
   - Native support for macOS Full Color, Tinted, and Accented modes (`widgetAccentable`).

### 🧩 Desktop Widgets & Permission Guide

QBMenubar supports macOS Desktop & Notification Center Widgets across three sizes (`Small`, `Medium`, `Large`). To sync live download speeds and progress between the menu bar daemon and the desktop widgets:

1. **Enable in Settings**: Open QBMenubar Preferences (**⌘,**) -> **Widgets** tab -> turn on **Enable Desktop Widget Sync**.
2. **macOS "Data from other apps" Permission**:
   - **Why macOS prompts this**: Under macOS 15 (Sequoia) & macOS 26 (Tahoe), cross-process communication between an app and its sandboxed WidgetKit extension uses App Groups (`~/Library/Group Containers/`). Because open-source releases use ad-hoc code signing without a paid Apple commercial developer team profile, macOS flags this cross-process shared folder with a security notice: *"QBMenubar tried to access your data from other apps and was blocked."*
   - **🔒 Zero Privacy Risk**: QBMenubar **only** writes and reads its own `widget_snapshot.json` (containing torrent names, speeds, and progress percentages). It **never** accesses your personal files or any data from other applications.
   - **How to Grant Permission**:
     - **System Settings**: In **Preferences -> Widgets**, click **"Open Full Disk Access Settings"** (or open **System Settings > Privacy & Security > Full Disk Access**), click **`+`**, select **QBMenubar.app**, and turn on the permission toggle.
     - **Terminal Reset**: If you previously blocked access and want to reset permissions, run in Terminal:
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
   - **Note**: The widget requires Full Disk Access to display live tasks; without it, widgets display a *"Permission Required"* state. **The core Menu Bar app continues to operate with 100% full functionality even if widget permission is not granted.**
3. **Adding Widgets to Desktop**:
   - Right-click anywhere on your macOS desktop -> click **"Edit Widgets..."** (or open Notification Center and click **"Edit Widgets"** at the bottom).
   - In the left sidebar or search box, search for **`QBMenubar`** or **`qBittorrent`**.
   - Pick from **Small**, **Medium**, or **Large** widgets and drag it directly onto your desktop or Notification Center.

---

### 🚀 What's New in v1.3.2
- **Native WidgetKit Extension Entry Point**: Configured `_NSExtensionMain` entry point for the SwiftPM WidgetKit binary, ensuring robust ExtensionKit launch, descriptor discovery, and placeholder precaching by macOS `chronod`.
- **Streamlined Full Disk Access Authorization**: Clarified and unified the cross-process App Group permission flow directly to macOS Full Disk Access, preventing text clipping and layout overflows in Preferences.
- **Clean Single-Bundle Registration**: Eliminated redundant binary registrations and ensured clean system discovery.

---

## 📥 Installation & Download

### Option 1: Direct Download (Recommended)
Download the precompiled and signed macOS App directly from GitHub Releases:

👉 **[Download QBMenubar (Latest Release)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Download and unzip `QBMenubar-*-macOS.zip`.
2. Drag `QBMenubar.app` into your **Applications** folder (`/Applications`).
3. Double-click `QBMenubar.app` to launch! It lives quietly in your menu bar.

> [!TIP]
> **macOS Gatekeeper First-Launch Tip:**  
> If macOS alerts that the app *"cannot be opened because Apple cannot check it for malicious software"* (standard for unsigned open-source apps):  
> Simply **Right-click** (or Control-click) `QBMenubar.app` in Finder, select **Open**, and click **Open** in the dialog.  
> Alternatively, run in Terminal: `xattr -cr /Applications/QBMenubar.app`

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

## ⚙️ Configuration (1-Minute Quick Start)

1. **Enable qBittorrent WebUI**:
   - Open qBittorrent (on your Mac, NAS, Docker, or remote server).
   - Go to **Preferences -> Web UI** and check **Web User Interface (Remote control)**.
   - Default local URL is typically `http://127.0.0.1:8080`.
2. **Connect QBMenubar**:
   - Click the QBMenubar icon in your macOS status bar.
   - Click the gear icon (**⚙️**) in the top right to open Preferences.
   - Enter your WebUI Address, Username, and Password, then click **Test Connection**.
   - Your menu bar will immediately display live speeds and torrent metrics!

---

## 🏷️ Keywords & Search Topics
`qbittorrent` • `qbittorrent-controller` • `qbittorrent-webui` • `qbittorrent-client` • `macos-menubar` • `menubar-app` • `menubar-extra` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid` • `truenas` • `docker`

---

## 📄 License
Distributed under the MIT License. See [LICENSE](LICENSE) for more details.
