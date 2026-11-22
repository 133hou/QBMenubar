# ⚡️ QBMenubar — Client natif qBittorrent & Transmission pour la barre des menus et widgets de bureau macOS

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Contrôleur qBittorrent et Transmission natif pour la barre des menus macOS avec design Liquid Glass" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Téléchargements"></a>
  <img src="https://img.shields.io/badge/Clients-qBittorrent%20%2B%20Transmission-blue" alt="Clients supportés">
  <img src="https://img.shields.io/badge/Widgets-WidgetKit%20(S%2FM%2FL)-emerald" alt="macOS Widgets">
  <img src="https://img.shields.io/badge/Plateforme-macOS%2014.0%2B%20(Sonoma%2FSequoia%2FTahoe)-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/Architecture-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/Licence-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <a href="README_zh.md">简体中文</a> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <a href="README_ja.md">日本語</a> | 
  <a href="README_ko.md">한국어</a> | 
  <a href="README_de.md">Deutsch</a> | 
  <b>Français</b> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**QBMenubar** est l'application native ultime pour la **barre des menus macOS pour qBittorrent & Transmission** et la meilleure **alternative moderne à Transmission Remote GUI (Transgui) pour Mac**, développée en **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Alliant l'élégance translucide du matériau **Liquid Glass** et le retour tactile des animations physiques **Apple Motion Feel**, elle permet de surveiller en temps réel et de piloter à distance vos téléchargements locaux, NAS domestiques (**Synology DSM, QNAP, Unraid, TrueNAS, Docker**) ou **seedboxes** avec un impact système quasi nul (CPU < 0,1 %, RAM ~40 Mo) sur puces Apple Silicon et Intel.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Indicateur de vitesse et badge de progression épinglé dans la barre des menus" width="650" />
</p>

## 🧭 Navigation rapide
- [🎯 Cas d'usage principaux (Use Cases)](#use-cases)
- [📸 Captures d'écran & Aperçu](#screenshots)
- [📊 Tableau comparatif : Pourquoi choisir QBMenubar ?](#comparison)
- [✨ Fonctionnalités clés](#features)
  - [🧩 Widgets Bureau (WidgetKit) — Aucune autorisation requise](#desktop-widgets)
- [🔒 Sécurité, Confidentialité & Fiabilité](#security)
- [🚀 Nouveautés de la v1.3.2](#whats-new)
- [📥 Téléchargement & Installation](#installation)
- [⚙️ Guide de configuration des clients (qBittorrent & Transmission)](#configuration)
- [❓ Foire aux questions (FAQ)](#faq)
- [🏷️ Mots-clés de recherche (Keywords)](#keywords)
- [📄 Licence](#license)

---

<a id="use-cases"></a>
## 🎯 Cas d'usage principaux (Use Cases)

- 🚀 **Gestion locale et NAS à distance** : Contrôlez qBittorrent et Transmission qu'ils tournent sur votre Mac, un NAS **Synology DSM, QNAP, Unraid, TrueNAS**, un conteneur **Docker** ou une seedbox distante via IP locale, domaine DDNS ou proxy inverse HTTPS.
- 📌 **Épinglage de la progression en barre des menus** : Épinglez d'un clic le pourcentage de progression d'un torrent clé directement à côté de l'horloge macOS (ex. : `↓ 12.0 MB/s 85%`) — parfait pour le suivi de **seedbox et trackers privés (PT)**.
- ⚡️ **Empreinte système imperceptible** : Binaire universel compilé en Swift 6 natif (Apple Silicon M1/M2/M3/M4 & Intel) ne consommant que ~0,0 % de CPU au repos et moins de 40 Mo de RAM — totalement invisible pour la batterie comparé aux wrappers Electron lourds ou aux onglets de navigateur.
- 🐢 **Actions rapides en un clic** : Mettez en pause ou reprenez tous les torrents instantanément, ou activez la vitesse alternative (🐢 mode tortue) lors de vos réunions vidéo ou sessions de jeu.
- 📋 **Détection intelligente & inspection de fichiers** : Reconnaissance automatique des liens magnets (`magnet:?xt=`) et URLs de torrents dans le presse-papiers, avec inspection complète des fichiers `.torrent` et choix du dossier de destination avant l'ajout.
- 🖥️ **Widgets de bureau macOS natifs** : Widgets élégants pour le bureau et le Centre de notifications (Petit, Moyen, Grand) propulsés par WidgetKit, consultables sans ouvrir l'application ni le navigateur.

---

<a id="screenshots"></a>
## 📸 Captures d'écran & Aperçu

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Panneau popover Liquid Glass de QBMenubar" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Fenêtre de réglages style Réglages Système macOS" width="480" />
</p>

<p align="center">
  <em>Style Anneau Circulaire Liquid Glass (Nouveau) :</em><br />
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <em>Style Barre Capsule Linéaire Classique (Conservé) :</em><br />
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar Réglages des widgets et configuration du bureau" width="580" />
</p>

---

<a id="comparison"></a>
## 📊 Tableau comparatif : Pourquoi choisir QBMenubar ?

| Fonctionnalité | QBMenubar (Natif macOS) | WebUI Navigateur | Client Qt Officiel | Transgui / Scripts Python |
|---|:---:|:---:|:---:|:---:|
| **Moteur double client** | ✅ **qBittorrent & Transmission** | ❌ (Un seul client) | ❌ qBittorrent uniquement | ⚠️ Client unique / Ancien |
| **Intégration Barre des Menus** | ✅ Natif Liquid Glass | ❌ Fenêtre web uniquement | ❌ Dock / Plein écran | ⚠️ Menu texte basique |
| **Épinglage de progression** | ✅ Badge direct barre des menus | ❌ | ❌ | ❌ |
| **Graphique d'onde de débit** | ✅ Ondes fluides Swift Charts | ⚠️ Graphique statique | ⚠️ Graphique simple | ❌ |
| **Hauteur de fenêtre ajustable** | ✅ Poignée interactive (380-920pt) | ⚠️ Fenêtre manuelle | ⚠️ Fenêtre complexe | ❌ Texte figé |
| **Consommation Mémoire** | 🟢 **~35 - 45 Mo** | 🔴 300 Mo - 1 Go+ | 🟡 150 Mo - 300 Mo | 🟢 ~30 Mo |
| **CPU au repos** | 🟢 **< 0,1 %** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **Accès NAS & Docker distant** | ✅ LAN, NAS & HTTPS | ✅ | ❌ Local uniquement | ⚠️ Prise en charge limitée |
| **Arborescence de fichiers extensible** | ✅ Cartes interactives | ⚠️ Tableau lourd | ⚠️ Tableau compact | ❌ |
| **Widgets Bureau & Notifications (WidgetKit)** | ✅ Petit, Moyen & Grand | ❌ | ❌ | ❌ |
| **Notifications natives macOS** | ✅ Fin de téléchargement | ⚠️ Permission navigateur | ⚠️ Ancienne alerte | ❌ |
| **Optimisé Apple Silicon (M1 à M4)** | ✅ Binaire universel Swift 6 natif | ⚠️ Onglet web lourd | 🟡 Rosetta / Qt lourd | ⚠️ Dépend des scripts |

---

<a id="features"></a>
## ✨ Fonctionnalités clés

1. **Surveillance en temps réel en barre des menus** :
   - Vitesses de téléchargement et de téléversement en direct avec flèches directionnelles (`↓` / `↑`).
   - Pourcentage de progression épinglé (badge capsule monochrome élégant).
   - Ajustement dynamique de la largeur du texte pour éliminer les troncatures dans la barre d'état.
2. **Panneau popover Liquid Glass** :
   - Véritable matériau Liquid Glass translucide de macOS avec bordures biseautées specular.
   - Onde de trafic fluide en temps réel propulsée par Swift Charts.
   - Barre d'actions rapides : Tout suspendre, Tout reprendre, Vitesse alternative (🐢 mode tortue), Ouvrir la WebUI.
   - Onglets de filtrage avec compteurs : Tous, Téléchargement, Partage, Suspendus.
   - **➕ Ajouter un torrent local** : Analyse des métadonnées `.torrent`, inspection des fichiers et choix du dossier de destination.
   - **📋 Détection de liens** : Reconnaissance instantanée des liens `magnet:?xt=` et URLs copiés.
3. **Cartes de torrents interactives** :
   - Métriques complètes : barres de progression, temps restant (ETA), tailles, débits en direct.
   - Explorateur de fichiers : Dépliez l'arborescence avec icônes de formats et progression individuelle.
   - **📌 Épingler à la barre des menus** : Verrouillez d'un clic votre téléchargement en cours dans la barre des menus.
   - Menu contextuel : Révéler dans le Finder, forcer la revérification, supprimer (avec ou sans fichiers).
4. **Réglages style Réglages Système macOS** :
   - Disposition fixe à deux volets sans panneau latéral repliable.
   - Localisation intégrale en 9 langues (Français, Anglais, Chinois, Japonais, Coréen, Allemand, Espagnol, Russe).
   - Outil de diagnostic de connectivité intégré pour tester le ping et la version du serveur.
   - Prise en charge complète des proxys inverses, des préfixes de sous-chemins (`/api/v2`, `/transmission/rpc`) et du contournement localhost.
5. **Widgets Bureau & Centre de notifications macOS (WidgetKit)** :
   - **Petit widget (`.systemSmall`)** : Aperçu du téléchargement le plus actif avec barre de progression, vitesse en direct et temps restant (ETA).
   - **Moyen widget (`.systemMedium`)** : Disposition à deux volets affichant la bande passante globale à gauche et la liste des tâches actives à droite.
   - **Grand widget (`.systemLarge`)** : Tableau de bord complet avec résumé des vitesses, liste des torrents, badges d'état et ouverture directe dans QBMenubar.
   - **Synchronisation par instantané local sans impact** : Synchronisation fluide et légère entre l'application et les widgets macOS.
   - Prise en charge native des modes Pleine couleur, Sombre et Teinté/Accentuation (`widgetAccentable`).

<a id="desktop-widgets"></a>
### 🧩 Widgets Bureau (WidgetKit) — Aucune autorisation requise

QBMenubar prend en charge les widgets de bureau et du Centre de notifications macOS en trois formats (`Petit`, `Moyen`, `Grand`), afin de garder un œil sur vos téléchargements et débits à tout instant.

1. **Activer dans les Réglages** : Cliquez sur l'icône de la barre des menus -> Réglages (**⌘,**) -> onglet « **Widgets** » -> activez « **Activer la synchronisation des widgets** ».
2. **Aucune autorisation requise (Pas d'Accès complet au disque)** :
   - **🔒 Sandbox native & Confidentialité** : Les widgets de bureau se synchronisent via un système d'instantanés locaux optimisé. Contrairement aux anciennes versions, QBMenubar ne nécessite **aucun Accès complet au disque (Full Disk Access)** et n'accède à aucun fichier personnel ni aux données d'autres applications.
   - **🔋 Limitation intelligente des rechargements (Reload Throttling)** : Les actualisations sont synchronisées avec le budget énergétique de WidgetKit pour préserver l'autonomie de la batterie de votre MacBook, sans aucun compromis sur la réactivité de l'affichage.
   - **🛡️ États déconnectés propres et auto-réparateurs** : Lorsque qBittorrent ou Transmission est hors ligne ou indisponible, les widgets affichent un état propre et sécurisé plutôt que des erreurs ou des données figées.
3. **Ajout des widgets au bureau** :
   - Faites un clic droit sur un espace vide du bureau macOS -> cliquez sur **« Modifier les widgets... »** (ou ouvrez le Centre de notifications et cliquez sur **« Modifier les widgets »** en bas).
   - Recherchez **`QBMenubar`** ou **`qBittorrent`** dans la barre latérale gauche ou la zone de recherche.
   - Glissez simplement le format souhaité (**Petit**, **Moyen** ou **Grand**) sur votre bureau ou dans le Centre de notifications.

---

<a id="security"></a>
## 🔒 Sécurité, Confidentialité & Fiabilité

QBMenubar intègre des mécanismes de sécurité et de robustesse de niveau professionnel :

- 🔐 **Chiffrement dans le Trousseau d'accès macOS (Keychain)** : Les mots de passe WebUI sont chiffrés et enregistrés directement dans le **Trousseau d'accès natif de macOS** via le framework Apple Security (`kSecClassGenericPassword`). Ils ne sont jamais stockés en texte clair dans `UserDefaults` ou des fichiers de préférences.
- 🔋 **Drosselage WidgetKit économe en batterie** : Régulation adaptative des rechargements pour préserver l'autonomie des ordinateurs portables Mac tout en maintenant les widgets à jour.
- 🌐 **Réseau renforcé (Standard RFC 3986)** : Encodage strict d'URL pour garantir la transmission sans altération des mots de passe complexes contenant des caractères spéciaux (`@`, `#`, `$`, `%`, `&`, `+`) et des liens magnets complexes.
- 🛡️ **Sécurité de concurrence CSRF Transmission** : Sérialisation thread-safe des jetons 409 Session-ID de Transmission évitant tout risque de condition de course lors des requêtes parallèles.
- 📦 **Analyseur Bencode protégé** : Limite stricte de profondeur de récursion à 256 niveaux et protections contre les dépassements d'entiers face aux fichiers `.torrent` corrompus ou malveillants.

---

<a id="whats-new"></a>
### 🚀 Nouveautés de la v1.3.2
- **Support natif du client Transmission** : Architecture de service découplée prenant en charge nativement le protocole JSON-RPC de Transmission (avec négociation automatique du Session-Id CSRF 409 et authentification Basic Auth). Bascule transparente entre qBittorrent et Transmission avec parité fonctionnelle complète pour les widgets de bureau, graphiques de débit et gestion des tâches.
- **Chiffrement Keychain macOS & Sécurité renforcée** : Les mots de passe WebUI sont stockés dans le Trousseau d'accès. La couche réseau applique l'encodage RFC 3986, la gestion thread-safe du CSRF Transmission et la protection récursive du parseur Bencode.
- **Synchronisation intelligente WidgetKit (Zéro autorisation)** : Suppression du besoin d'Accès complet au disque. Les widgets se mettent à jour par instantanés locaux avec limitation économe en énergie.
- **Lentille optique Liquid Glass pour la barre latérale des réglages** : Lentille en verre pur haute transparence style macOS Tahoe avec ombres de réfraction physique méniscale, dispersion chromatique prismatique et animations de ressort fluides (le style classique en couleur pleine reste disponible et sélectionnable).
- **Anneau de progression circulaire Liquid Glass pour les widgets** : Nouvel affichage circulaire avec flèche directionnelle et icône en verre flottante (la barre capsule classique linéaire est 100 % conservée et commutable dans les préférences).
- **Point d'entrée WidgetKit natif optimisé** : Symbole `_NSExtensionMain` intégré pour garantir le chargement fiable des widgets par `chronod` et le Centre de notifications.
- **Enregistrement de bundle unique** : Suppression des conflits d'enregistrement de bundles redondants et découverte système instantanée.

---

<a id="installation"></a>
## 📥 Téléchargement & Installation

### Option 1 : Téléchargement direct (Recommandé)
Prêt à l'emploi, aucun outil de développement requis :

👉 **[Télécharger la dernière version de QBMenubar (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Décompressez l'archive `QBMenubar-*-macOS.zip`.
2. Glissez `QBMenubar.app` dans votre dossier **« Applications (/Applications) »**.
3. **Double-cliquez sur `QBMenubar.app` pour le lancer !** Il s'installe discrètement dans la barre des menus.

> [!TIP]
> **Conseil Gatekeeper au premier lancement :**  
> Si macOS affiche un avertissement de sécurité « développeur non vérifié » (standard pour les applications open-source sans certificat d'équipe commercial) :  
> Faites un **clic droit (ou Contrôle + clic)** sur `QBMenubar.app` dans le Finder, choisissez **« Ouvrir »** puis validez dans la boîte de dialogue.  
> Vous pouvez aussi exécuter dans le Terminal : `xattr -cr /Applications/QBMenubar.app`

### Option 2 : Compiler depuis le code source (Build from Source)
Prérequis : macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

<a id="configuration"></a>
## ⚙️ Guide de configuration des clients (qBittorrent & Transmission)

| Client | Réglage recommandé | Port / Chemin | Authentification |
|---|---|---|---|
| **qBittorrent** | Activer l'interface WebUI (API v2) | Port par défaut `8080` (ex: `http://192.168.1.100:8080`) | Identifiant & Mot de passe |
| **Transmission** | Activer l'accès RPC à distance | Port par défaut `9091` (Chemin RPC: `/transmission/rpc`) | Auth RPC & Gestion automatique CSRF 409 |

> [!TIP]
> **Basculez de client en un clic :**  
> Dans les Préférences (**⌘,**), sous l'onglet « **Connexion WebUI** », choisissez qBittorrent ou Transmission. Tout le système (barre des menus, widgets et gestion des torrents) s'adapte instantanément.

---

<a id="faq"></a>
## ❓ Foire aux questions (FAQ)

<details>
<summary><b>1. QBMenubar est-il une bonne alternative à Transmission Remote GUI (Transgui) sur macOS ?</b></summary>
Oui, absolument. Alors que <i>Transmission Remote GUI (Transgui)</i> était très populaire par le passé, il repose sur un environnement technique vieillissant (Pascal/Lazarus), n'offre aucune intégration moderne à macOS et ne supporte pas nativement Apple Silicon. QBMenubar a été conçu de zéro en pur Swift 6 pour Apple Silicon et Intel. Il prend en charge à la fois <b>Transmission et qBittorrent</b>, propose l'esthétique Liquid Glass de macOS, réside discrètement dans la barre des menus, fournit des widgets de bureau natifs et ne consomme que moins de 0,1 % de CPU et ~40 Mo de mémoire vive.
</details>

<details>
<summary><b>2. Comment mes identifiants de connexion WebUI sont-ils sécurisés ?</b></summary>
Vos informations de connexion sont chiffrées et stockées dans le <b>Trousseau d'accès macOS (Keychain)</b> via le framework natif Apple Security (<code>kSecClassGenericPassword</code>). Les mots de passe ne sont jamais sauvegardés en clair dans <code>UserDefaults</code>, les fichiers de préférences ou des exports. Aucun Accès complet au disque (Full Disk Access) n'est nécessaire.
</details>

<details>
<summary><b>3. Puis-je utiliser QBMenubar à la fois avec qBittorrent et Transmission ?</b></summary>
Oui ! QBMenubar dispose d'une couche d'abstraction unifiée. Sélectionnez simplement <b>qBittorrent</b> ou <b>Transmission</b> dans <b>Réglages -> Connexion WebUI</b>. Les débits en barre d'état, les cartes popover, les graphiques d'ondes et les widgets de bureau prennent en charge les deux clients de façon transparente.
</details>

<details>
<summary><b>4. Comment me connecter à un NAS distant, Unraid ou Docker ?</b></summary>
Renseignez simplement l'adresse IP de votre appareil (ex: <code>http://192.168.1.100:8080</code> ou <code>http://nas.local:9091</code>), son nom de domaine ou l'URL de votre reverse proxy HTTPS dans le champ Adresse du serveur. QBMenubar fonctionne parfaitement sur réseau local (LAN), via VPN (Tailscale, WireGuard) et au travers des proxys inverses avec sous-chemins sur Synology DSM, QNAP, Unraid, TrueNAS ou serveurs dédiés.
</details>

<details>
<summary><b>5. Comment ajouter des widgets de bureau sous macOS Sonoma, Sequoia et Tahoe ?</b></summary>
Faites un clic droit sur votre bureau macOS (ou cliquez sur <b>Modifier les widgets</b> en bas du Centre de notifications), recherchez <b>QBMenubar</b> et glissez la taille souhaitée (<b>Petit</b>, <b>Moyen</b> ou <b>Grand</b>). Vous pouvez choisir entre l'<b>anneau circulaire Liquid Glass</b> et la <b>barre capsule linéaire</b> dans les Préférences. Aucune autorisation particulière ni accès complet au disque n'est requis.
</details>

<details>
<summary><b>6. Quel est l'impact sur les performances par rapport à la WebUI du navigateur ?</b></summary>
Contrairement aux onglets de navigateur ouverts en continu (300 Mo à 1 Go de RAM, 1 à 5 % de CPU) ou aux applications Electron, QBMenubar est une application Swift 6 native. Elle communique via des requêtes JSON/REST/RPC optimisées et ne consomme qu'environ 35 à 45 Mo de RAM et moins de 0,1 % de CPU en veille.
</details>

<details>
<summary><b>7. La hauteur de la fenêtre popover peut-elle être agrandie ?</b></summary>
Oui ! Vous pouvez faire glisser la poignée capsule discrète située tout en bas au centre de la fenêtre popover pour régler la hauteur librement entre <b>380pt et 920pt</b>. Votre hauteur personnalisée est mémorisée automatiquement, et un double-clic sur la poignée la ramène instantanément à la hauteur par défaut de 550pt.
</details>

---

<a id="keywords"></a>
## 🏷️ Mots-clés de recherche (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-macos` • `qbittorrent-menu-bar` • `transmission-remote-gui` • `transgui-alternative` • `transmission-mac` • `qbittorrent-remote` • `transmission-rpc` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `menubar-extra` • `widgetkit` • `widgets-bureau` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `client-torrent` • `seedbox-monitor` • `synology-nas` • `qnap` • `unraid` • `truenas` • `docker-torrent` • `apple-silicon` • `macos-tahoe` • `macos-sequoia` • `macos-sonoma`

---

<a id="license"></a>
## 📄 Licence
Distribué sous [licence MIT](LICENSE).
