# QBMenubar - Contrôleur qBittorrent natif pour la barre des menus macOS

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Contrôleur qBittorrent natif pour la barre des menus macOS avec design Liquid Glass" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="Téléchargements"></a>
  <img src="https://img.shields.io/badge/Plateforme-macOS%2014.0%2B-lightgrey" alt="Platform">
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

**QBMenubar** est une application macOS native, légère et ultra-performante pour **qBittorrent**, développée avec **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Alliant l'élégance translucide du matériau **Liquid Glass** et le retour tactile des animations **Apple Motion Feel**, elle permet de surveiller et piloter vos téléchargements qBittorrent directement depuis la barre des menus avec un impact système quasi nul (CPU < 0,1 %, RAM ~40 Mo).

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Indicateur de vitesse et badge de progression épinglé dans la barre des menus" width="650" />
</p>

---

## 🎯 Cas d'usage principaux (Use Cases)

- 🚀 **Gestion locale et NAS à distance** : Contrôlez qBittorrent qu'il tourne sur votre Mac, un NAS Synology, QNAP, Unraid, TrueNAS, un conteneur Docker ou un serveur distant via IP locale, nom de domaine ou proxy inverse HTTPS.
- 📌 **Épinglage de la progression en barre des menus** : Épinglez d'un clic le pourcentage de progression d'un torrent clé directement à côté de l'horloge macOS (ex. : `↓ 12.0 MB/s 85%`).
- ⚡️ **Empreinte système imperceptible** : Contrairement aux applications Electron ou aux onglets de navigateur toujours ouverts, cette application native Swift 6 ne consomme que 0,0 % de CPU au repos et ~35 à 45 Mo de mémoire vive.
- 🐢 **Actions rapides en un clic** : Mettez en pause ou reprenez tous les torrents, ou activez la vitesse alternative (🐢 mode tortue) en réunion ou en jeu vidéo.
- 📋 **Détection intelligente et inspection avant téléchargement** : Détection automatique des liens magnets dans le presse-papiers et prévisualisation de l'arborescence des fichiers des torrents locaux avant ajout.

---

## 📸 Captures d'écran & Aperçu

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Panneau popover Liquid Glass de QBMenubar" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Fenêtre de réglages style Réglages Système macOS" width="480" />
</p>

---

## 📊 Tableau comparatif : Pourquoi choisir QBMenubar ?

| Fonctionnalité | QBMenubar (Natif) | WebUI Navigateur | Client Qt Officiel | Scripts Python / SwiftBar |
|---|:---:|:---:|:---:|:---:|
| **Intégration Barre des Menus** | ✅ Natif Liquid Glass | ❌ Fenêtre web uniquement | ❌ Dock / Plein écran | ⚠️ Menu texte basique |
| **Épinglage de progression** | ✅ Badge direct barre des menus | ❌ | ❌ | ❌ |
| **Graphique d'onde de débit** | ✅ Ondes fluides Swift Charts | ⚠️ Graphique statique | ⚠️ Graphique simple | ❌ |
| **Consommation Mémoire** | 🟢 **~35 - 45 Mo** | 🔴 300 Mo - 1 Go+ | 🟡 150 Mo - 300 Mo | 🟢 ~30 Mo |
| **CPU au repos** | 🟢 **< 0,1 %** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **Accès NAS & Docker distant** | ✅ LAN, NAS & HTTPS | ✅ | ❌ Local uniquement | ⚠️ Prise en charge limitée |
| **Arborescence de fichiers extensible** | ✅ Cartes interactives | ⚠️ Tableau lourd | ⚠️ Tableau compact | ❌ |
| **Notifications natives macOS** | ✅ Fin de téléchargement | ⚠️ Permission navigateur | ⚠️ Ancienne alerte | ❌ |

---

## 📥 Téléchargement & Installation

### Option 1 : Téléchargement direct (Recommandé)
Prêt à l'emploi, aucun outil de développement requis :

👉 **[Télécharger la dernière version de QBMenubar (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. Décompressez l'archive `QBMenubar-*-macOS.zip`.
2. Glissez `QBMenubar.app` dans votre dossier **« Applications (/Applications) »**.
3. **Double-cliquez sur `QBMenubar.app` pour le lancer !** Il s'installe discrètement dans la barre des menus.

> [!TIP]
> **Conseil Gatekeeper au premier lancement :**  
> Si macOS affiche un avertissement de sécurité « développeur non vérifié », faites un **clic droit (ou Contrôle + clic)** sur `QBMenubar.app` dans le Finder, choisissez **« Ouvrir »** puis validez dans la boîte de dialogue.

---

## 🏷️ Mots-clés de recherche (Keywords)
`qbittorrent` • `qbittorrent-controller` • `qbittorrent-webui` • `qbittorrent-client` • `macos-menubar` • `menubar-app` • `menubar-extra` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid`

---

## 📄 Licence
Distribué sous [licence MIT](LICENSE).
