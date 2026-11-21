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

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="Réglages des widgets et autorisation de partage de données" width="580" />
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
| **Widgets Bureau & Centre de notifications (WidgetKit)** | ✅ Petit, Moyen & Grand | ❌ | ❌ | ❌ |
| **Notifications natives macOS** | ✅ Fin de téléchargement | ⚠️ Permission navigateur | ⚠️ Ancienne alerte | ❌ |

---

## ✨ Fonctionnalités clés

1. **Surveillance en temps réel en barre des menus** :
   - Vitesses de téléchargement et de téléversement en direct avec glyphes dynamiques (`↓` / `↑`).
   - Pourcentage de progression épinglé (badge capsule monochrome élégant).
   - Ajustement dynamique de la largeur du texte pour éviter toute troncature.
2. **Panneau popover Liquid Glass** :
   - Véritable matériau Liquid Glass translucide de macOS avec bordures biseautées.
   - Onde de trafic fluide en temps réel propulsée par Swift Charts.
   - Barre d'actions rapides : Tout suspendre, Tout reprendre, Vitesse alternative (🐢 mode tortue), Ouvrir la WebUI.
   - Onglets de filtrage : Tous, Téléchargement, Partage, Suspendus.
   - **➕ Ajouter un torrent local** : Aperçu préalable des fichiers et sélection du dossier de destination.
   - **📋 Détection de liens** : Reconnaissance instantanée des liens `magnet:` et URLs copiés.
3. **Cartes de torrents interactives** :
   - Métriques détaillées : barres de progression, temps restant (ETA), tailles, débits en direct.
   - Explorateur de fichiers : Dépliez l'arborescence avec icônes de formats et progression individuelle.
   - Menu contextuel : Révéler dans le Finder, forcer la revérification, supprimer (avec ou sans fichiers).
4. **Réglages style macOS** :
   - Vue fixe à deux volets sans panneau rétractable.
   - Localisation intégrale en 9 langues (Français, Anglais, Chinois, Japonais, Coréen, Allemand, Espagnol, Russe).
   - Testeur de connectivité intégré pour vérifier le ping et la version du serveur qBittorrent.
5. **Widgets Bureau & Centre de notifications macOS (WidgetKit)** :
   - **Petit widget (`.systemSmall`)** : Aperçu du téléchargement le plus actif avec barre de progression, vitesse en direct et temps restant (ETA).
   - **Moyen widget (`.systemMedium`)** : Disposition à deux volets affichant la bande passante globale à gauche et la liste des tâches actives à droite.
   - **Grand widget (`.systemLarge`)** : Tableau de bord complet avec résumé des vitesses, liste des torrents, badges d'état et ouverture directe dans QBMenubar.
   - **Stockage partagé App Group sans impact** : Synchronisation fluide et légère entre le démon de la barre des menus et les widgets macOS.
   - Prise en charge native des modes Couleur, Sombre et Teinté/Accentuation (`widgetAccentable`).

### 🧩 Widgets Bureau & Guide des autorisations

QBMenubar prend en charge les widgets Bureau et Centre de notifications macOS en trois formats (Petit, Moyen, Grand). Pour synchroniser les débits et la progression entre la barre des menus et les widgets :

1. **Activer dans les Réglages** : Cliquez sur l'icône de la barre des menus -> Réglages (**⌘,**) -> onglet « **Widgets** » -> cochez « **Activer la synchronisation des widgets** ».
2. **Autorisation système macOS « Données d'autres apps »** :
   - **Pourquoi macOS affiche ce message** : Sous macOS 15 (Sequoia) et macOS 26 (Tahoe), l'application barre des menus et l'extension WidgetKit s'exécutent dans des processus distincts et partagent leurs données via un conteneur App Group (`~/Library/Group Containers/`). Les versions open-source étant distribuées sous signature ad-hoc (sans certificat commercial payant Apple), macOS identifie ce dossier partagé comme « Données d'autres apps » et affiche : *« QBMenubar a essayé d'accéder à vos données à partir d'autres apps et a été bloqué. »*
   - **🔒 Confidentialité absolue garantie** : QBMenubar écrit et lit **uniquement** son fichier `widget_snapshot.json` (contenant uniquement le nom des torrents, les vitesses et le pourcentage d'avancement). Il n'accède **jamais** à vos fichiers personnels ni aux données d'autres applications.
   - **Accorder ou rétablir l'autorisation** :
     - **Option 1 (Directement dans l'app)** : Dans « Réglages -> Widgets », cliquez sur « **Redemander l'autorisation système** ». macOS réaffiche immédiatement la notification : cliquez sur « Gérer » et activez l'accès.
     - **Option 2 (Réglages Système)** : Ouvrez « **Réglages Système > Confidentialité et sécurité > Fichiers et dossiers** » (ou « **Accès complet au disque** »), trouvez **QBMenubar** et cochez l'accès.
     - **Option 3 (Réinitialisation via Terminal)** : Si l'accès a été refusé et que l'app n'apparaît pas dans la liste des réglages, lancez dans le Terminal :
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
       Rouvrez ensuite QBMenubar et activez le bouton des widgets pour faire réapparaître la demande système.
   - **Remarque** : Les widgets nécessitent cette autorisation pour afficher la progression en direct (sinon ils indiquent « Autorisation requise »). **Sans cette autorisation, toutes les fonctionnalités principales de la barre des menus restent 100 % opérationnelles et sans aucune restriction.**

---

### 🚀 Nouveautés de la v1.3.2
- **Support natif du client Transmission** : Architecture de service découplée prenant en charge nativement le protocole JSON-RPC de Transmission (avec négociation automatique du Session-Id CSRF 409 et authentification Basic Auth). Bascule transparente entre qBittorrent et Transmission avec parité fonctionnelle complète pour les widgets de bureau, graphiques de débit et gestion des tâches.
- **Lentille optique Liquid Glass pour la barre latérale des réglages** : Lentille en verre pur haute transparence style macOS Tahoe avec ombres de réfraction physique méniscale, dispersion chromatique prismatique et animations de ressort fluides (le style classique en couleur pleine reste disponible et sélectionnable).
- **Anneau de progression circulaire Liquid Glass pour les widgets** : Nouvel affichage circulaire avec flèche directionnelle et icône en verre flottante (la barre capsule classique linéaire est 100 % conservée et commutable dans les préférences).
- **Point d'entrée WidgetKit natif optimisé** : Symbole `_NSExtensionMain` intégré pour garantir le chargement fiable des widgets par `chronod` et le Centre de notifications.
- **Autorisation simplifiée pour l'Accès complet au disque** : Résolution des dépassements de mise en page et coupures de texte dans les réglages.
- **Enregistrement de bundle unique** : Suppression des conflits d'enregistrement de bundles redondants.

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
