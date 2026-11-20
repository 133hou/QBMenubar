# QBMenubar - Nativer macOS qBittorrent Menüleisten-Controller

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <img src="https://img.shields.io/badge/Platform-macOS%2014.0%2B-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License">
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

Eine leichte, hochperformante native macOS Menüleisten-App, entwickelt mit **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Ausgestattet mit modernem **Liquid Glass**-Design und **Apple Motion Feel**-Physikanimationen zur Überwachung und Steuerung Ihrer qBittorrent-Downloads direkt aus der macOS-Menüleiste.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Menüleisten-Vorschau" width="650" />
</p>

---

## Vorschau & Screenshots

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Popover-Vorschau" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Einstellungen-Vorschau" width="480" />
</p>

---

## Funktionen

1. **Menüleisten-Statusobjekt**:
   - Echtzeit-Download- und Upload-Geschwindigkeitsanzeige.
   - Angehefteter Aufgabenfortschritt direkt in der Statusleiste (z. B. `↓ 12.0 MB/s 85%`).
   - Dynamische Breitenanpassung ohne Textbeschneidung.
2. **Liquid Glass Popover-Bedienfeld**:
   - Echtzeit-Bandbreitenwellendiagramm (Swift Charts).
   - Schnellzugriffsleiste: Alle anhalten, Alle fortsetzen, Alternative Geschwindigkeiten (🐢), WebUI öffnen.
   - Filter-Tabs (Alle, Herunterladen, Seeden, Angehalten).
   - **➕**-Taste zum Auswählen von `.torrent`-Dateien mit Inhaltsprüfung vor dem Hinzufügen.
   - Automatische Erkennung von Magnet- und Torrent-Links in der Zwischenablage.
3. **Interaktive Torrent-Karten**:
   - Status-Badges, Fortschrittsbalken, Dateigrößen, ETA-Restzeit und Übertragungsraten.
   - Klickbare Dateiliste mit Dateityp-Symbolen und individuellem Download-Fortschritt.
   - Pin-Button (**📌**) zum Anheften einer bestimmten Aufgabe an die Menüleiste.
4. **macOS Systemeinstellungen-Stil**:
   - Zweispaltiges Layout ohne störende Seitenleisten-Schaltflächen.
   - Frei konfigurierbare WebUI-API (lokal, NAS, VPS oder Reverse-Proxy).
   - Integrierter Verbindungstester mit Ping- und Versionserkennung.
   - Native macOS-Mitteilungen bei Download-Abschluss.

---

## Installation & Start

### Option 1: Vorkompilierte App herunterladen (Empfohlen)
Laden Sie die fertige App direkt von GitHub Releases herunter:

👉 **[QBMenubar (Latest) herunterladen (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Laden Sie `QBMenubar-*-macOS.zip` herunter und entpacken Sie es.
2. Ziehen Sie `QBMenubar.app` in den Ordner `/Programme` (`/Applications`).
3. Starten Sie `QBMenubar.app` per Doppelklick.

> [!TIP]
> **Hinweis zu macOS Gatekeeper beim ersten Start:**  
> Wenn macOS meldet, dass die App nicht geöffnet werden kann:  
> Klicken Sie im Finder mit der **rechten Maustaste (oder Strg + Klick) auf `QBMenubar.app`** -> wählen Sie **Öffnen** -> bestätigen Sie mit **Öffnen**.  
> Alternativ im Terminal: `xattr -cr /Applications/QBMenubar.app`

### Option 2: Aus Quellcode kompilieren
Voraussetzungen: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## Lizenz
Veröffentlicht unter der [MIT License](LICENSE).
