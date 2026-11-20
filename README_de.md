# QBMenubar - Nativer macOS Menüleisten-Controller für qBittorrent

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Nativer macOS Menüleisten-Controller für qBittorrent im Liquid Glass Design" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Downloads"></a>
  <img src="https://img.shields.io/badge/Plattform-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/Architektur-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/Lizenz-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <a href="README_zh.md">简体中文</a> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <a href="README_ja.md">日本語</a> | 
  <a href="README_ko.md">한국어</a> | 
  <b>Deutsch</b> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**QBMenubar** ist eine schlanke, hochperformante und native macOS-Menüleisten-App für **qBittorrent**, entwickelt mit **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Sie vereint modernes **Liquid Glass**-Material mit der Haptik von **Apple Motion Feel**-Federanimationen, um lokale oder entfernte qBittorrent-Downloads ressourcenschonend (CPU < 0,1%, RAM ~40MB) direkt aus der Menüleiste zu steuern.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar Menüleisten-Geschwindigkeitsanzeige und angehefteter Fortschritt" width="650" />
</p>

---

## 🎯 Wichtigste Anwendungsfälle (Use Cases)

- 🚀 **Lokale & NAS-Fernsteuerung**: Nahtlose Verbindung zu qBittorrent auf dem lokalen Mac, Synology DSM, QNAP, Unraid, TrueNAS, Docker-Containern oder Remote-Servern über LAN-IP, Domain oder HTTPS-Reverse-Proxy.
- 📌 **Fortschrittsanheftung in der Menüleiste**: Heften Sie den Live-Prozentsatz wichtiger Downloads mit einem Klick direkt neben die macOS-Uhr (z. B. `↓ 12.0 MB/s 85%`).
- ⚡️ **Minimaler Ressourcenverbrauch**: Im Gegensatz zu trägen Electron-Wrappern oder Browser-Tabs verbraucht die native Swift 6-App im Leerlauf 0,0% CPU und nur ca. 35–45 MB RAM.
- 🐢 **Schnelle Geschwindigkeitskontrolle**: Alle Torrents mit einem Klick pausieren, fortsetzen oder alternative Geschwindigkeitsgrenzen (🐢 Schildkrötenmodus) bei Meetings oder Online-Spielen aktivieren.
- 📋 **Smarte Zwischenablage & Dateivorschau**: Automatische Erkennung von Magnet-Links und Vorab-Inspektion von `.torrent`-Dateien mit Auswahl des Zielordners.

---

## 📸 Screenshots & Vorschau

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass Popover-Panel" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS Einstellungen-Fenster" width="480" />
</p>

---

## 📊 Funktionsvergleich: Warum QBMenubar?

| Funktion | QBMenubar (Nativ) | Browser WebUI | Offizieller Qt-Desktop-Client | Python / ScriptBar Plugins |
|---|:---:|:---:|:---:|:---:|
| **Menüleisten-Integration** | ✅ Nativ Liquid Glass | ❌ Nur Browserfenster | ❌ Nur Dock/Hauptfenster | ⚠️ Nur Textmenü |
| **Angehefteter Fortschritt** | ✅ Menüleisten-Badge | ❌ | ❌ | ❌ |
| **Live-Bandbreitenkurve** | ✅ Swift Charts Wellenform | ⚠️ Statische Linie | ⚠️ Einfaches Diagramm | ❌ |
| **RAM-Verbrauch** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **CPU im Leerlauf** | 🟢 **< 0,1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **NAS & Docker Remote** | ✅ LAN, NAS & HTTPS Proxy | ✅ | ❌ Nur lokaler Daemon | ⚠️ Begrenzt |
| **Dateibaum-Vorschau** | ✅ Aufklappbare Karten | ⚠️ Mehrfaches Klicken | ⚠️ Unübersichtliche Tabelle | ❌ |
| **macOS Native Benachrichtigungen** | ✅ Download abgeschlossen | ⚠️ Browser-Rechte nötig | ⚠️ Veralteter Dialog | ❌ |

---

## 📥 Installation

### Option 1: Vorkompilierte App herunterladen (Empfohlen)
Kein Xcode oder Terminal nötig:

👉 **[Neueste QBMenubar-Version herunterladen (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. `QBMenubar-*-macOS.zip` entpacken.
2. `QBMenubar.app` in den Ordner **„Programme (/Applications)“** ziehen.
3. **`QBMenubar.app` per Doppelklick starten** – das Symbol erscheint in der Menüleiste.

> [!TIP]
> **Hinweis zu Gatekeeper beim ersten Start:**  
> Sollte macOS warnen, dass der Entwickler nicht verifiziert werden kann: Klicken Sie im Finder mit der **rechten Maustaste** auf `QBMenubar.app`, wählen Sie **„Öffnen“** und bestätigen Sie den Dialog.

---

## 🏷️ Suchbegriffe (Keywords)
`qbittorrent` • `qbittorrent-controller` • `qbittorrent-webui` • `qbittorrent-client` • `macos-menubar` • `menubar-app` • `menubar-extra` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid`

---

## 📄 Lizenz
Veröffentlicht unter der [MIT-Lizenz](LICENSE).
