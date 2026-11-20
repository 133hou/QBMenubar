# QBMenubar - Contrôleur qBittorrent natif pour la barre des menus macOS

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
  <a href="README_de.md">Deutsch</a> | 
  <b>Français</b> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

Une application native macOS légère et ultra-rapide conçue avec **Swift 6 + SwiftUI + MenuBarExtra (.window)**. Dotée de l'esthétique **Liquid Glass** et d'animations physiques **Apple Motion Feel** pour surveiller et contrôler vos téléchargements qBittorrent directement depuis la barre des menus de votre Mac.

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="Aperçu de la barre des menus" width="650" />
</p>

---

## Aperçu et captures d'écran

<p align="center">
  <img src="docs/images/preview_popover.png" alt="Aperçu du panneau popover" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="Aperçu de la fenêtre des préférences" width="480" />
</p>

---

## Points forts

1. **Élément de la barre des menus**:
   - Vitesse de téléchargement et d'envoi en direct.
   - Progression du téléchargement épinglé affichée directement dans la barre d'état (ex: `↓ 12.0 MB/s 85%`).
   - Largeur adaptative dynamique empêchant tout tronquage du texte.
2. **Panneau popover en Liquid Glass**:
   - Graphique ondulatoire de bande passante en temps réel (Swift Charts).
   - Barre de contrôle rapide : Tout suspendre, Tout reprendre, Vitesse alternative (🐢), Ouvrir WebUI.
   - Onglets de filtrage (Tous, En cours, Partage, Suspendus).
   - Bouton **➕** pour importer des fichiers `.torrent` avec prévisualisation des fichiers et choix du dossier.
   - Détection automatique des liens magnétiques dans le presse-papiers.
3. **Cartes de torrents interactives**:
   - Badges d'état, barre de progression, tailles, temps restant (ETA) et vitesses.
   - Arborescence interne de fichiers dépliable avec icônes par type et progression individuelle.
   - Bouton épingle (**📌**) pour fixer un téléchargement sur la barre d'état macOS.
4. **Préférences au style Réglages Système macOS**:
   - Disposition épurée à deux colonnes sans bouton de masquage de barre latérale.
   - Configuration complète de l'API WebUI (local, NAS, VPS ou proxy inverse).
   - Testeur de connexion intégré (mesure du Ping et version du serveur).
   - Notifications natives macOS à la fin des téléchargements.

---

## Installation et lancement

### Option 1 : Télécharger l'application précompilée (Recommandé)
Téléchargez directement l'application prête à l'emploi depuis GitHub Releases :

👉 **[Télécharger QBMenubar v1.0.0 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

1. Téléchargez et décompressez `QBMenubar-v1.0.0-macOS.zip`.
2. Déplacez `QBMenubar.app` dans votre dossier `/Applications`.
3. Double-cliquez sur `QBMenubar.app` pour le lancer !

> [!TIP]
> **Conseil de sécurité macOS Gatekeeper au premier lancement :**  
> Si macOS indique que l'application ne peut pas être ouverte car le développeur ne peut être vérifié :  
> Faites un **clic droit (ou Contrôle + clic) sur `QBMenubar.app`** dans le Finder -> choisissez **Ouvrir** -> confirmez en cliquant sur **Ouvrir**.  
> Ou dans le Terminal : `xattr -cr /Applications/QBMenubar.app`

### Option 2 : Compilation depuis les sources
Prérequis : macOS 14.0+, Xcode 15+ / Swift 6.0+.

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

## Licence
Distribué sous la licence [MIT License](LICENSE).
