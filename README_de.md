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

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar Widget-Einstellungen und Datenschutz-Berechtigung" width="580" />
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
| **Schreibtisch- & Mitteilungszentrale-Widgets (WidgetKit)** | ✅ Klein, Mittel & Groß | ❌ | ❌ | ❌ |
| **macOS Native Benachrichtigungen** | ✅ Download abgeschlossen | ⚠️ Browser-Rechte nötig | ⚠️ Veralteter Dialog | ❌ |

---

## ✨ Funktionen im Überblick

1. **Menüleisten-Echtzeitüberwachung**:
   - Live-Upload- und Download-Raten mit dynamischen Richtungspfeilen (`↓` / `↑`).
   - Angehefteter Fortschrittsprozentsatz (dezentes monochromes Kapsel-Badge).
   - Dynamische Breitenanpassung verhindert abgeschnittenen Text in der Statusleiste.
2. **Liquid Glass Popover-Panel**:
   - Echtes halbtransparentes Liquid Glass-Material von macOS mit feinen Lichtkanten.
   - Weiche Bandbreiten-Wellenform in Echtzeit (unterstützt von Swift Charts).
   - Schnellaktionen: Alle anhalten, Alle fortsetzen, Alternative Geschwindigkeitsgrenzen (🐢 Schildkrötenmodus), WebUI im Browser öffnen.
   - Filter-Tabs: Alle, Lädt herunter, Seeding, Angehalten.
   - **➕ Lokalen Torrent hinzufügen**: Dateiinhalt vorab einsehen und Zielordner frei wählen.
   - **📋 Smarte Zwischenablage**: Automatische Erkennung beim Kopieren von `magnet:`- oder Torrent-Links.
3. **Interaktive Torrent-Karten**:
   - Wichtige Kennzahlen: Fortschrittsbalken, Restzeit (ETA), Dateigröße, Geschwindigkeiten.
   - Datei-Explorer: Aufklappbare Ordnerstruktur mit individuellen Dateisymbolen und Prozentanzeigen.
   - Kontextmenü: Im Finder anzeigen, Datenintegrität neu prüfen, Löschen (optional mit Dateien).
4. **macOS Systemeinstellungen-Stil**:
   - Feste zweispaltige Ansicht ohne störende einklappbare Seitenleiste.
   - Vollständige Lokalisierung in 9 Sprachen (Deutsch, Englisch, Chinesisch, Japanisch, Koreanisch, Französisch, Spanisch, Russisch).
   - Integrierter Verbindungstest zur Überprüfung von Latenz (Ping) und qBittorrent-Serverversion.
5. **macOS Schreibtisch- & Mitteilungszentrale-Widgets (WidgetKit)**:
   - **Kleines Widget (`.systemSmall`)**: Schnelle Übersicht über den aktivsten Download mit Fortschrittsbalken, Live-Geschwindigkeit und Restzeit (ETA).
   - **Mittleres Widget (`.systemMedium`)**: Zweispaltiges Layout mit Gesamtdatenrate links und Aufgabenliste rechts.
   - **Großes Widget (`.systemLarge`)**: Vollständiges Dashboard mit Bandbreiten-Karten, Aufgabenliste, Status-Badges und Direkt-Link zu QBMenubar.
   - **Zero-Overhead App Group-Speicher**: Nahtlose, ressourcenschonende Synchronisierung zwischen Hintergrunddienst und macOS-Widgets.
   - Volle Unterstützung für macOS Vollfarbe, Dark Mode sowie Akzent- & Tönungsmodi (`widgetAccentable`).

### 🧩 Schreibtisch-Widgets & Berechtigungsleitfaden

QBMenubar unterstützt macOS Schreibtisch- und Mitteilungszentrale-Widgets in drei Größen (Klein, Mittel, Groß). Zur Synchronisierung zwischen Menüleisten-App und Widgets:

1. **In Einstellungen aktivieren**: Menüleistensymbol anklicken -> Einstellungen (**⌘,**) -> Reiter „**Widgets**“ -> „**Schreibtisch-Widget-Synchronisierung aktivieren**“ einschalten.
2. **macOS-Berechtigung „Daten von anderen Apps“**:
   - **Warum macOS diese Meldung anzeigt**: Unter macOS 15 (Sequoia) und macOS 26 (Tahoe) laufen die Menüleisten-App und das sandboxed WidgetKit-Plug-in als getrennte Prozesse und tauschen Daten über App Groups (`~/Library/Group Containers/`) aus. Da Open-Source-Builds mit lokaler Ad-hoc-Signatur (ohne kostenpflichtiges Apple-Entwicklerprofil) bereitgestellt werden, stuft macOS diesen geteilten Ordner als „Daten von anderen Apps“ ein und zeigt die Warnung: *„QBMenubar hat versucht, auf Daten anderer Apps zuzugreifen und wurde blockiert.“*
   - **🔒 Garantierter Datenschutz**: QBMenubar liest und schreibt in diesem Ordner **ausschließlich** die Datei `widget_snapshot.json` (enthält nur Torrent-Namen, Raten und Prozentangaben). Es greift **niemals** auf persönliche Dateien oder Daten anderer Apps zu.
   - **Berechtigung erteilen bzw. wiederherstellen**:
     - **Option 1 (Direkt in der App)**: In „Einstellungen -> Widgets“ auf „**System-Berechtigungsdialog erneut anfordern**“ klicken. macOS blendet die Meldung sofort wieder ein; dort auf „Verwalten“ klicken und erlauben.
     - **Option 2 (Systemeinstellungen)**: „**Systemeinstellungen > Datenschutz & Sicherheit > Dateien & Ordner**“ (oder „**Festplattenvollzugriff**“) öffnen und **QBMenubar** aktivieren.
     - **Option 3 (Terminal-Reset)**: Falls der Zugriff zuvor abgelehnt wurde und die App nicht in der Liste erscheint, im Terminal ausführen:
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
       Danach QBMenubar erneut öffnen und den Widget-Schalter umlegen, um die Systemabfrage erneut zu erhalten.
   - **Hinweis**: Widgets benötigen diese Berechtigung zur Live-Aktualisierung (sonst wird „Berechtigung erforderlich“ angezeigt). **Ohne diese Berechtigung bleiben alle Kernfunktionen in der Menüleiste zu 100 % uneingeschränkt nutzbar.**

---

### 🚀 Was ist neu in v1.3.2
- **Native Transmission-Client-Unterstützung**: Vollständig entkoppelte Dienstarchitektur mit nativer Unterstützung des Transmission JSON-RPC-Protokolls (einschließlich automatischem 409-CSRF-Session-Id-Handshake und Basic Auth). Nahtloser Wechsel zwischen qBittorrent und Transmission mit vollständiger Funktionsparität für Desktop-Widgets, Geschwindigkeitsdiagramme und Aufgabenverwaltung.
- **Optische Liquid-Glass-Auswahllinse in den Einstellungen**: Glasklare optische Linse im Stil von macOS Tahoe mit realistischen Meniskus-Brechungsschatten, prismatischer chromatischen Dispersion und geschmeidigen Apple-Spring-Animationen (klassischer Volltonstil bleibt in den Einstellungen wählbar).
- **Liquid-Glass-Kreisring-Fortschrittsanzeige für Widgets**: Neue kreisförmige Fortschrittsanzeige mit Richtungspfeil und zentralem Glassymbol (klassischer linearer Kapselbalken bleibt vollständig erhalten und umschaltbar).
- **Optimierter WidgetKit-Einstiegspunkt**: `_NSExtensionMain` für SwiftPM-Builds sauber verknüpft, wodurch die Erkennung durch `chronod` und das Notification Center zuverlässig funktioniert.
- **Vereinfachte Festplattenvollzugriff-Autorisierung**: Layoutüberläufe und Textbeschneidungen in den Einstellungen behoben.
- **Single-Bundle-Registrierung**: Konflikte bei der Bundle-Registrierung beseitigt.

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
