# ⚡️ QBMenubar — Nativer macOS qBittorrent & Transmission Menüleisten- & Desktop-Widget-Client

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Nativer macOS Menüleisten-Controller für qBittorrent und Transmission im Liquid Glass Design" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Downloads"></a>
  <img src="https://img.shields.io/badge/Clients-qBittorrent%20%2B%20Transmission-blue" alt="Unterstützte Clients">
  <img src="https://img.shields.io/badge/Widgets-WidgetKit%20(S%2FM%2FL)-emerald" alt="macOS Widgets">
  <img src="https://img.shields.io/badge/Plattform-macOS%2014.0%2B%20(Sonoma%2FSequoia%2FTahoe)-lightgrey" alt="Platform">
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

**QBMenubar** ist die ultimative native **macOS-Menüleisten-App für qBittorrent & Transmission** sowie moderne **Transmission Remote GUI (Transgui) Alternative für Mac**, entwickelt mit **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Sie vereint das zukunftsweisende **Liquid Glass**-Design (Halbtransparenz mit Lichtkanten) und **Apple Motion Feel**-Physik direkt in Ihrer Statusleiste – für ressourcenschonende Echtzeit-Überwachung (CPU < 0,1%, RAM ~40MB) und Fernsteuerung von lokalen Downloads, Heim-NAS-Systemen (**Synology DSM, QNAP, Unraid, TrueNAS, Docker**) oder High-Speed-**Seedboxen** auf Apple Silicon & Intel Macs.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar Menüleisten-Geschwindigkeitsanzeige und angehefteter Fortschritt" width="650" />
</p>

## 🧭 Schnellnavigation
- [🎯 Wichtigste Anwendungsfälle (Use Cases)](#use-cases)
- [📸 Screenshots & Vorschau](#screenshots)
- [📊 Funktionsvergleich: Warum QBMenubar?](#comparison)
- [✨ Funktionen im Überblick](#features)
  - [🧩 Schreibtisch-Widgets (WidgetKit) — Ohne Sonderberechtigungen](#desktop-widgets)
- [🔒 Sicherheit, Datenschutz & Zuverlässigkeit](#security)
- [🚀 Was ist neu in v1.3.2](#whats-new)
- [📥 Installation & Download](#installation)
- [⚙️ Client-Konfigurationsleitfaden (qBittorrent & Transmission)](#configuration)
- [❓ Häufig gestellte Fragen (FAQ)](#faq)
- [🏷️ Suchbegriffe (Keywords)](#keywords)
- [📄 Lizenz](#license)

---

<a id="use-cases"></a>
## 🎯 Wichtigste Anwendungsfälle (Use Cases)

- 🚀 **Lokale & Remote-NAS-Überwachung**: Nahtlose Verbindung zu qBittorrent und Transmission auf dem Mac, **Synology DSM, QNAP, Unraid, TrueNAS, Docker**-Containern oder Linux-Seedboxen über LAN-IP, DynDNS/Domain oder HTTPS-Reverse-Proxy.
- 📌 **Fortschrittsanheftung in der Menüleiste**: Heften Sie den Live-Prozentsatz wichtiger Downloads direkt neben die macOS-Uhr (z. B. `↓ 12.0 MB/s 85%`) – ideal zur **Seedbox- und Torrent-Überwachung**.
- ⚡️ **Minimaler Ressourcenverbrauch**: Nativ kompiliertes Swift 6 Universal-Binary (Apple Silicon M1/M2/M3/M4 & Intel) mit ~0,0% Leerlauf-CPU und unter 40 MB RAM – nahezu unsichtbar für Akku und System im Vergleich zu trägen Electron-Apps oder Browser-Tabs.
- 🐢 **Schnelle Geschwindigkeitskontrolle**: Alle Torrents mit einem Klick pausieren, fortsetzen oder alternative Geschwindigkeitsgrenzen (🐢 Schildkrötenmodus) bei Meetings oder Online-Spielen aktivieren.
- 📋 **Smarte Zwischenablage & Dateivorschau**: Automatische Erkennung von `magnet:?xt=`-Links und Torrent-URLs sowie vollständige `.torrent`-Inspektion vor dem Download mit Zielordnerauswahl.
- 🖥️ **macOS Schreibtisch-Widgets**: Elegante Widgets (Klein, Mittel, Groß) über WidgetKit für Desktop und Mitteilungszentrale, die stets aktuelle Daten anzeigen, ohne die App oder den Browser zu öffnen.

---

<a id="screenshots"></a>
## 📸 Screenshots & Vorschau

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass Popover-Panel" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS Einstellungen-Fenster" width="480" />
</p>

<p align="center">
  <em>Liquid Glass Kreisring-Stil (Neu):</em><br />
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <em>Klassischer linearer Kapselbalken-Stil (Erhalten):</em><br />
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar Widget-Einstellungen und Schreibtisch-Widget-Konfiguration" width="580" />
</p>

---

<a id="comparison"></a>
## 📊 Funktionsvergleich: Warum QBMenubar?

| Funktion | QBMenubar (Nativ macOS) | Browser WebUI | Offizieller Qt-Desktop-Client | Transgui / Script-Plugins |
|---|:---:|:---:|:---:|:---:|
| **Dual-Client-Unterstützung** | ✅ **qBittorrent & Transmission** | ❌ Nur ein Client | ❌ Nur qBittorrent | ⚠️ Veraltet / Ein Client |
| **Menüleisten-Integration** | ✅ Nativ Liquid Glass | ❌ Nur Browserfenster | ❌ Nur Dock/Hauptfenster | ⚠️ Nur Textmenü |
| **Angehefteter Fortschritt** | ✅ Menüleisten-Badge | ❌ | ❌ | ❌ |
| **Live-Bandbreitenkurve** | ✅ Swift Charts Wellenform | ⚠️ Statische Linie | ⚠️ Einfaches Diagramm | ❌ |
| **Anpassbare Fensterhöhe** | ✅ Interaktiver Ziehgriff (380-920pt) | ⚠️ Manuelles Webfenster | ⚠️ Komplexes Fenster | ❌ Fester Text |
| **RAM-Verbrauch** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **CPU im Leerlauf** | 🟢 **< 0,1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **NAS & Docker Remote** | ✅ LAN, NAS & HTTPS Proxy | ✅ | ❌ Nur lokaler Daemon | ⚠️ Begrenzt |
| **Dateibaum-Vorschau** | ✅ Aufklappbare Karten | ⚠️ Mehrfaches Klicken | ⚠️ Unübersichtliche Tabelle | ❌ |
| **Schreibtisch-Widgets (WidgetKit)** | ✅ Klein, Mittel & Groß | ❌ | ❌ | ❌ |
| **macOS Native Benachrichtigungen** | ✅ Download abgeschlossen | ⚠️ Browser-Rechte nötig | ⚠️ Veralteter Dialog | ❌ |
| **Native Apple Silicon-Unterstützung** | ✅ Reines Swift 6 Universal (M1-M4) | ⚠️ Browser-Prozess | 🟡 Rosetta / Schweres Qt | ⚠️ Skriptabhängig |

---

<a id="features"></a>
## ✨ Funktionen im Überblick

1. **Menüleisten-Echtzeitüberwachung**:
   - Live-Upload- und Download-Raten mit dynamischen Richtungspfeilen (`↓` / `↑`).
   - Angehefteter Fortschrittsprozentsatz (dezentes monochromes Kapsel-Badge).
   - Dynamische Breitenanpassung verhindert abgeschnittenen Text in der Statusleiste.
2. **Liquid Glass Popover-Panel**:
   - Echtes halbtransparentes Liquid Glass-Material von macOS mit feinen Lichtkanten.
   - Weiche Bandbreiten-Wellenform in Echtzeit (unterstützt von Swift Charts).
   - Schnellaktionen: Alle anhalten, Alle fortsetzen, Alternative Geschwindigkeitsgrenzen (🐢 Schildkrötenmodus), WebUI im Browser öffnen.
   - Filter-Tabs mit Zähler: Alle, Lädt herunter, Seeding, Angehalten.
   - **➕ Lokalen Torrent hinzufügen**: Dateiinhalt vorab einsehen und Zielordner frei wählen.
   - **📋 Smarte Zwischenablage**: Automatische Erkennung beim Kopieren von `magnet:?xt=`- oder Torrent-Links.
3. **Interaktive Torrent-Karten**:
   - Wichtige Kennzahlen: Fortschrittsbalken, Restzeit (ETA), Dateigröße, Geschwindigkeiten.
   - Datei-Explorer: Aufklappbare Ordnerstruktur mit individuellen Dateisymbolen und Prozentanzeigen.
   - **📌 An Statusleiste anheften**: Fixieren Sie den aktuellen Download mit einem Klick in der Menüleiste.
   - Kontextmenü: Im Finder anzeigen, Datenintegrität neu prüfen, Löschen (optional mit Dateien).
4. **macOS Systemeinstellungen-Stil**:
   - Feste zweispaltige Ansicht ohne störende einklappbare Seitenleiste.
   - Vollständige Lokalisierung in 9 Sprachen (Deutsch, Englisch, Chinesisch, Japanisch, Koreanisch, Französisch, Spanisch, Russisch).
   - Integrierter Verbindungstest zur Überprüfung von Latenz (Ping) und Serverversion.
   - Unterstützung für Reverse Proxys, Unterpfade (`/api/v2`, `/transmission/rpc`) und Localhost-Bypass.
5. **macOS Schreibtisch- & Mitteilungszentrale-Widgets (WidgetKit)**:
   - **Kleines Widget (`.systemSmall`)**: Schnelle Übersicht über den aktivsten Download mit Fortschrittsbalken, Live-Geschwindigkeit und Restzeit (ETA).
   - **Mittleres Widget (`.systemMedium`)**: Zweispaltiges Layout mit Gesamtdatenrate links und Aufgabenliste rechts.
   - **Großes Widget (`.systemLarge`)**: Vollständiges Dashboard mit Bandbreiten-Karten, Aufgabenliste, Status-Badges und Direkt-Link zu QBMenubar.
   - **Zero-Overhead lokale Snapshot-Synchronisierung**: Nahtlose, ressourcenschonende Synchronisierung zwischen Hintergrunddienst und macOS-Widgets.
   - Volle Unterstützung für macOS Vollfarbe, Dark Mode sowie Akzent- & Tönungsmodi (`widgetAccentable`).

<a id="desktop-widgets"></a>
### 🧩 Schreibtisch-Widgets (WidgetKit) — Ohne Sonderberechtigungen

QBMenubar unterstützt native macOS Schreibtisch- und Mitteilungszentrale-Widgets in drei Größen (`Klein`, `Mittel`, `Groß`), um aktive Downloads und Bandbreiten jederzeit im Blick zu behalten.

1. **In Einstellungen aktivieren**: Menüleistensymbol anklicken -> Einstellungen (**⌘,**) -> Reiter „**Widgets**“ -> „**Schreibtisch-Widget-Synchronisierung aktivieren**“ einschalten.
2. **Kein Festplattenvollzugriff erforderlich (Zero Permission Required)**:
   - **🔒 Native Sandbox & Datenschutz**: Die Schreibtisch-Widgets synchronisieren sich über ein optimiertes lokales Snapshot-System. Im Gegensatz zu älteren Versionen benötigt QBMenubar **keinen Festplattenvollzugriff (Full Disk Access)** und greift auf keinerlei persönliche Dateien oder Daten anderer Apps zu.
   - **🔋 Intelligente, akkuschonende WidgetKit-Drosselung (Reload Throttling)**: Aktualisierungen werden an die systemweiten WidgetKit-Budgets angepasst, um den MacBook-Akku maximal zu schonen, ohne Verzögerungen bei der Anzeige zu verursachen.
   - **🛡️ Sauberer Offline- & Platzhalterzustand**: Ist qBittorrent oder Transmission getrennt oder offline, zeigen die Widgets automatisch eine aufgeräumte, selbstreparierende Statusanzeige, anstatt einzufrieren oder veraltete Daten anzuzeigen.
3. **Widgets zum Schreibtisch hinzufügen**:
   - Klicken Sie mit der rechten Maustaste auf eine freie Stelle Ihres macOS-Schreibtischs -> wählen Sie **„Widgets bearbeiten...“** (oder öffnen Sie die Mitteilungszentrale und klicken Sie unten auf **„Widgets bearbeiten“**).
   - Suchen Sie in der linken Leiste oder im Suchfeld nach **`QBMenubar`** oder **`qBittorrent`**.
   - Ziehen Sie das gewünschte Widget (**Klein**, **Mittel** oder **Groß**) per Drag & Drop direkt auf Ihren Schreibtisch oder in die Mitteilungszentrale.

---

<a id="security"></a>
## 🔒 Sicherheit, Datenschutz & Zuverlässigkeit

QBMenubar setzt auf höchste Sicherheits- und Stabilitätsstandards für anspruchsvolle Nutzer:

- 🔐 **macOS Schlüsselbund (Keychain) Verschlüsselung**: Passwörter für die WebUI-Authentifizierung werden über das Apple Security Framework (`kSecClassGenericPassword`) sicher verschlüsselt im macOS Schlüsselbund gespeichert – niemals im Klartext in `UserDefaults` oder Konfigurationsdateien.
- 🔋 **Akkuschonende WidgetKit-Drosselung**: Adaptives Aktualisierungs-Throttling schützt die MacBook-Batterie und hält Widgets gleichzeitig responsiv.
- 🌐 **Gehärtetes Networking (RFC 3986 Standard)**: Strikte URL-Formularkodierung stellt sicher, dass Passwörter mit Sonderzeichen (`@`, `#`, `$`, `%`, `&`, `+`) und komplexe Magnet-Links fehlerfrei übertragen werden.
- 🛡️ **Transmission CSRF-Parallelitätssicherheit**: Thread-sichere Serialisierung für 409 Session-ID-Token verhindert Race Conditions bei gleichzeitigen Netzwerkanfragen zuverlässig.
- 📦 **Geschützter Bencode-Parser**: Eingebauter Schutz vor Rekursionstiefen (max. 256 Ebenen) und Integer-Überläufen schützt vor manipulierten `.torrent`-Dateien.

---

<a id="whats-new"></a>
### 🚀 Was ist neu in v1.3.2
- **Native Transmission-Client-Unterstützung**: Vollständig entkoppelte Dienstarchitektur mit nativer Unterstützung des Transmission JSON-RPC-Protokolls (einschließlich automatischem 409-CSRF-Session-Id-Handshake und Basic Auth). Nahtloser Wechsel zwischen qBittorrent und Transmission mit vollständiger Funktionsparität für Desktop-Widgets, Geschwindigkeitsdiagramme und Aufgabenverwaltung.
- **macOS Schlüsselbund-Verschlüsselung & gehärtete Sicherheit**: WebUI-Passwörter liegen verschlüsselt im macOS Keychain. Netzwerkroutinen sind nach RFC 3986 form-encoded, Transmission-CSRF-Tokens thread-sicher serialisiert und der Bencode-Parser gegen Rekursionsüberläufe geschützt.
- **Intelligente WidgetKit-Drosselung (Kein Festplattenvollzugriff)**: Festplattenvollzugriff komplett entfallen. Desktop-Widgets synchronisieren sich effizient über lokale Snapshots mit akkuschonender Budget-Drosselung.
- **Optische Liquid-Glass-Auswahllinse in den Einstellungen**: Glasklare optische Linse im Stil von macOS Tahoe mit realistischen Meniskus-Brechungsschatten, prismatischer chromatischen Dispersion und geschmeidigen Apple-Spring-Animationen (klassischer Volltonstil bleibt in den Einstellungen wählbar).
- **Liquid-Glass-Kreisring-Fortschrittsanzeige für Widgets**: Neue kreisförmige Fortschrittsanzeige mit Richtungspfeil und zentralem Glassymbol (klassischer linearer Kapselbalken bleibt vollständig erhalten und umschaltbar).
- **Optimierter WidgetKit-Einstiegspunkt**: `_NSExtensionMain` für SwiftPM-Builds sauber verknüpft, wodurch die Erkennung durch `chronod` und das Notification Center zuverlässig funktioniert.
- **Single-Bundle-Registrierung**: Konflikte bei der Bundle-Registrierung beseitigt und saubere Systemerkennung sichergestellt.

---

<a id="installation"></a>
## 📥 Installation & Download

### Option 1: Vorkompilierte App herunterladen (Empfohlen)
Kein Xcode oder Terminal nötig:

👉 **[Neueste QBMenubar-Version herunterladen (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. `QBMenubar-*-macOS.zip` entpacken.
2. `QBMenubar.app` in den Ordner **„Programme (/Applications)“** ziehen.
3. **`QBMenubar.app` per Doppelklick starten** – das Symbol erscheint in der Menüleiste.

> [!TIP]
> **Hinweis zu Gatekeeper beim ersten Start:**  
> Sollte macOS warnen, dass der Entwickler nicht verifiziert werden kann (üblich bei quelloffenen Apps ohne kommerzielles Apple-Zertifikat):  
> Klicken Sie im Finder mit der **rechten Maustaste** (oder Control-Klick) auf `QBMenubar.app`, wählen Sie **„Öffnen“** und bestätigen Sie den Dialog.  
> Alternativ im Terminal ausführen: `xattr -cr /Applications/QBMenubar.app`

### Option 2: Aus Quellcode kompilieren (Build from Source)
Voraussetzungen: macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

<a id="configuration"></a>
## ⚙️ Client-Konfigurationsleitfaden (qBittorrent & Transmission)

| Client | Empfohlene Einstellung | Port / Pfad | Authentifizierung |
|---|---|---|---|
| **qBittorrent** | WebUI aktivieren (API v2) | Standard `8080` (z. B. `http://192.168.1.100:8080`) | Benutzername & Passwort |
| **Transmission** | RPC-Fernzugriff aktivieren | Standard `9091` (RPC-Pfad: `/transmission/rpc`) | RPC-Auth & 409 CSRF-Auto-Handling |

> [!TIP]
> **Nahtloser 1-Klick-Clientwechsel:**  
> Wählen Sie in den Einstellungen (**⌘,**) unter „**WebUI-Verbindung**“ einfach zwischen qBittorrent und Transmission. Alle Menüleistenanzeigen, Widgets und Torrent-Aktionen passen sich sofort automatisch an.

---

<a id="faq"></a>
## ❓ Häufig gestellte Fragen (FAQ)

<details>
<summary><b>1. Ist QBMenubar eine moderne Alternative zu Transmission Remote GUI (Transgui) für macOS?</b></summary>
Ja, absolut. Während <i>Transmission Remote GUI (Transgui)</i> historisch weit verbreitet war, basiert es auf veralteten Pascal/Lazarus-Frameworks, bietet keine moderne macOS-UI-Integration und unterstützt Apple Silicon nicht nativ. QBMenubar wurde von Grund auf in modernem Swift 6 für Apple Silicon und Intel-Macs entwickelt. Es unterstützt sowohl <b>Transmission als auch qBittorrent</b>, bietet echte Liquid Glass Ästhetik, lebt unauffällig in der Menüleiste, bringt native Desktop-Widgets mit und verbraucht im Leerlauf unter 0,1% CPU und nur ca. 40 MB RAM.
</details>

<details>
<summary><b>2. Wie speichert QBMenubar meine WebUI-Zugangsdaten sicher?</b></summary>
Ihre Anmeldedaten werden sicher verschlüsselt im nativen <b>macOS Schlüsselbund (Keychain)</b> über das Apple Security Framework (<code>kSecClassGenericPassword</code>) abgelegt. Passwörter werden niemals im Klartext in <code>UserDefaults</code>, Einstellungs-Plists oder Konfigurationsdateien gespeichert. Es ist kein Festplattenvollzugriff (Full Disk Access) oder eine andere riskante Sonderberechtigung erforderlich.
</details>

<details>
<summary><b>3. Kann ich QBMenubar sowohl mit qBittorrent als auch mit Transmission verwenden?</b></summary>
Ja! QBMenubar verfügt über eine einheitliche Client-Abstraktionsarchitektur. Wählen Sie in <b>Einstellungen -> WebUI-Verbindung</b> einfach <b>qBittorrent</b> oder <b>Transmission</b> aus. Alle Statusleisten-Geschwindigkeiten, Popover-Karten, Bandbreiten-Wellenformen und Desktop-Widgets unterstützen beide Backends nahtlos.
</details>

<details>
<summary><b>4. Kann ich mich mit Remote-NAS-, Docker- oder Unraid-Instanzen verbinden?</b></summary>
Ja. Geben Sie einfach die IP-Adresse Ihres Geräts (z. B. <code>http://192.168.1.100:8080</code> oder <code>http://nas.local:9091</code>), den Domainnamen oder eine HTTPS-Reverse-Proxy-URL in das Serveradressfeld ein. QBMenubar funktioniert reibungslos über lokales LAN, VPN (Tailscale, WireGuard) und Reverse Proxys mit Unterpfaden auf Synology DSM, QNAP, Unraid, TrueNAS oder Linux-Servern.
</details>

<details>
<summary><b>5. Wie füge ich Schreibtisch-Widgets in macOS Sonoma, Sequoia und Tahoe hinzu?</b></summary>
Klicken Sie mit der rechten Maustaste auf eine freie Stelle Ihres Schreibtischs (oder öffnen Sie die Mitteilungszentrale und klicken Sie unten auf <b>Widgets bearbeiten</b>), suchen Sie nach <b>QBMenubar</b> und ziehen Sie die gewünschte Größe (<b>Klein</b>, <b>Mittel</b> oder <b>Groß</b>) auf Ihren Bildschirm. In den Einstellungen können Sie zwischen dem <b>Liquid Glass Kreisring</b> und dem <b>klassischen Kapselbalken</b> wählen. Es sind keine Sonderberechtigungen oder Festplattenvollzugriff erforderlich.
</details>

<details>
<summary><b>6. Wie ressourcenschonend ist QBMenubar im Vergleich zur Browser-WebUI?</b></summary>
Im Gegensatz zu permanent geöffneten Browser-Tabs (300 MB–1 GB RAM, 1–5% CPU) oder Electron-Apps ist QBMenubar eine native Swift 6-App. Sie kommuniziert über schlanke JSON/REST/RPC-Anfragen und verbraucht im Leerlauf nur ca. 35–45 MB RAM und unter 0,1% CPU.
</details>

<details>
<summary><b>7. Kann die Höhe des Menüleisten-Fensters angepasst werden?</b></summary>
Ja! Ziehen Sie den dezenten Kapselgriff ganz unten in der Mitte des Popover-Fensters nach oben oder unten, um die Höhe zwischen <b>380pt und 920pt</b> beliebig anzupassen. Die Höhe wird automatisch gespeichert; ein Doppelklick auf den Griff setzt sie auf die Standardhöhe von 550pt zurück.
</details>

---

<a id="keywords"></a>
## 🏷️ Suchbegriffe (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-macos` • `qbittorrent-menüleiste` • `transmission-remote-gui` • `transgui-alternative` • `transmission-mac` • `qbittorrent-remote` • `transmission-rpc` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `menubar-extra` • `widgetkit` • `schreibtisch-widgets` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `seedbox-monitoring` • `synology-nas` • `qnap` • `unraid` • `truenas` • `docker-torrent` • `apple-silicon` • `macos-tahoe` • `macos-sequoia` • `macos-sonoma`

---

<a id="license"></a>
## 📄 Lizenz
Veröffentlicht unter der [MIT-Lizenz](LICENSE).
