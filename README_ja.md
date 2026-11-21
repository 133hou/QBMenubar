# ⚡️ QBMenubar — macOS ネイティブ qBittorrent & Transmission メニューバー＆デスクトップウィジェットクライアント

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - Liquid Glass デザインを採用した macOS ネイティブ qBittorrent & Transmission メニューバーコントローラー" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="総ダウンロード数"></a>
  <img src="https://img.shields.io/badge/クライアント-qBittorrent%20%2B%20Transmission-blue" alt="Supported Clients">
  <img src="https://img.shields.io/badge/ウィジェット-WidgetKit%20(S%2FM%2FL)-emerald" alt="macOS Widgets">
  <img src="https://img.shields.io/badge/プラットフォーム-macOS%2014.0%2B%20(Sonoma%2FSequoia%2FTahoe)-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/アーキテクチャ-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/ライセンス-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <a href="README_zh.md">简体中文</a> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <b>日本語</b> | 
  <a href="README_ko.md">한국어</a> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**QBMenubar** は、**Swift 6 + SwiftUI + MenuBarExtra (.window)** を用いて完全ネイティブで構築された軽量・高機能な macOS メニューバーアプリケーションです。先進的な **Liquid Glass（リキッドグラス）** 半透明マテリアルと **Apple Motion Feel** のネイティブ物理スプリングアニメーションを融合し、CPU負荷 0.1% 未満、メモリ約40MBの超低リソースで qBittorrent のリアルタイム速度監視、タスク進捗ピン留め、リモート NAS WebUI 管理を実現します。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar メニューバー速度モニターとピン留め進捗バッジ" width="650" />
</p>

---

## 🎯 主な利用シーン (Use Cases)

- 🚀 **ローカル & リモート NAS 統合監視**：Mac ローカル、Synology DSM、QNAP、Unraid、TrueNAS、Docker コンテナ、リモート VPS 上で動作する qBittorrent を、LAN IP、ドメイン、HTTPS リバースプロキシ経由でシームレスに遠隔制御。
- 📌 **特定タスクのメニューバー進捗固定（Pin）**：重要なダウンロードタスクを1クリックでピン留めし、メニューバーの時計横に進捗パーセンテージ（例: `↓ 12.0 MB/s 85%`）を常時表示。
- ⚡️ **極小リソース消費のバックグラウンド常駐**：Electron ラッパーや常時ブラウザタブと異なり、Swift 6 ネイティブバイナリのためアイドル時 CPU 0.0%、メモリ約 35〜45MB でバッテリーを消費しません。
- 🐢 **ワンクリック一時停止 & 制限切り替え**：オンライン会議やゲーム中に全タスク一時停止や代替速度制限（🐢 カメモード）を瞬時に切り替え可能。
- 📋 **マグネットリンク自動検知 & ファイルツリー確認**：クリップボードの `magnet:` リンクや URL を自動検知し、`.torrent` ファイルのダウンロード前内部構造プレビューにも対応。

---

## 📸 スクリーンショット & 実機プレビュー

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass ポップオーバー画面" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS システム設定風 設定ウィンドウ" width="480" />
</p>

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar ウィジェット設定およびデータ共有権限説明" width="580" />
</p>

---

## 📊 機能比較：なぜ QBMenubar なのか？

| 機能・指標 | QBMenubar (ネイティブ) | ブラウザ WebUI | 公式 Qt クライアント | Python / SwiftBar プラグイン |
|---|:---:|:---:|:---:|:---:|
| **メニューバー常駐 & UI** | ✅ ネイティブ Liquid Glass | ❌ Web 画面のみ | ❌ Dock/大画面のみ | ⚠️ テキストのみ |
| **特定タスク進捗ピン留め** | ✅ メニューバーにバッジ直出し | ❌ | ❌ | ❌ |
| **リアルタイム帯域波形** | ✅ Swift Charts 滑らか物理波形 | ⚠️ 静的更新折れ線 | ⚠️ 簡易グラフ | ❌ |
| **メモリ消費量** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **アイドル時 CPU 負荷** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **リモート NAS & Docker 接続** | ✅ LAN / NAS / HTTPS 反代 | ✅ | ❌ ローカル限定 | ⚠️ 認証制限あり |
| **ファイルツリー展開プレビュー** | ✅ カード内で階層展開 & 進捗 | ⚠️ 複数回クリックの表 | ⚠️ 密集した表 | ❌ |
| **デスクトップ & 通知センター ウィジェット (WidgetKit)** | ✅ 小・中・大の3サイズ対応 | ❌ | ❌ | ❌ |
| **macOS ネイティブ通知** | ✅ 完了通知プッシュ | ⚠️ ブラウザ許可必要 | ⚠️ 旧式アラート | ❌ |

---

## ✨ 主な機能一覧

1. **メニューバー常駐モニター**:
   - リアルタイムの上り/下り速度表示と動的矢印アイコン（`↓` / `↑`）。
   - ピン留めタスクの進捗パーセンテージ（モノクロカプセルバッジ）。
   - テキスト幅の動的追従による文字切れ防止。
2. **Liquid Glass ポップオーバーパネル**:
   - macOS の最新液態マテリアルデザイン、スペキュラハイライトエッジ。
   - Swift Charts によるリアルタイム帯域波形グラフ。
   - クイックアクション：全一時停止、全再開、代替速度制限（🐢）、WebUI 起動。
   - フィルタータブ：すべて、ダウンロード中、シード中、一時停止中。
   - **➕ ローカル Torrent 追加**：追加前にファイル一覧・サイズを確認し、保存先ディレクトリを指定可能。
3. **インタラクティブな Torrent カード**:
   - タスク名、ステータス、進行バー、サイズ、ETA、速度を一目で把握。
   - カードをクリックするとファイル一覧がスムーズに展開し、ファイル種別アイコンと個別進捗を表示。
   - 右クリックメニュー：Finder で表示、ハッシュ再チェック、削除（ファイル保持選択可能）。
4. **macOS システム設定風 プレファレンス**:
   - 固定2ペインレイアウト。
   - 9言語の完全ローカライズ（日本語、英語、中国語簡体/繁体、韓国語、ドイツ語、フランス語、スペイン語、ロシア語）。
   - リアルタイム Ping 遅延・サーバーバージョン測定ツール内蔵。
5. **macOS デスクトップ & 通知センター ウィジェット (WidgetKit)**:
   - **小サイズ (`.systemSmall`)**: 最もアクティブなダウンロードタスクの進行状況、リアルタイム転送速度、残り時間（ETA）をコンパクトに表示。
   - **中サイズ (`.systemMedium`)**: 2ペインレイアウト。左側にリアルタイムの全体帯域幅とタスク数、右側にアクティブなダウンロードタスクのプログレスバーを一覧表示。
   - **大サイズ (`.systemLarge`)**: フルダウンロードダッシュボード。帯域サマリー、タスク一覧、ステータスバッジ、QBMenubar への即座ジャンプを統合。
   - **ゼロオーバーヘッド App Group 共有ストレージ**: メニューバー常駐プロセスと macOS 通知センター・デスクトップ間の超軽量同期。
   - macOS のフルカラー、ダーク、着色・アクセント（`widgetAccentable`）モードに完全準拠。

### 🧩 デスクトップウィジェットとシステム権限ガイド

QBMenubar は、macOS デスクトップおよび通知センターのウィジェット（Small、Medium、Large の3サイズ）をネイティブサポートしています。メニューバー常駐本体とウィジェット間の同期：

1. **設定で有効化**: メニューバーアイコンをクリックして「設定」(**⌘,**) を開き -> 「**ウィジェット**」タブ -> 「**デスクトップウィジェット同期を有効にする**」をオンにします。
2. **macOS「他のアプリのデータ」システム権限について**:
   - **システム警告が出る理由**: macOS 15 (Sequoia) および macOS 26 (Tahoe) では、サンドボックス化された WidgetKit 拡張機能とメニューバー本体は独立したプロセスであり、App Group（`~/Library/Group Containers/`）を介してデータを共有します。オープンソース版はローカル自己署名（有料の Apple Developer Team ID プロファイルなし）でビルドされているため、macOS はこの共有ディレクトリへのアクセスを「他のアプリのデータ」と判定し、*「“QBMenubar”が他のアプリケーションのデータへのアクセスを試み、ブロックされました」*という警告を表示します。
   - **🔒 完全なプライバシー保護**: QBMenubar は共有ディレクトリ内に自身の `widget_snapshot.json`（タスク名、速度、進捗率のみ）を読み書きするだけであり、**ユーザーの個人ファイルや他アプリのデータには一切アクセスしません**。
   - **権限の許可および再取得方法**:
     - **方法 1（アプリ内から再トリガー）**: 「設定 -> ウィジェット」画面で「**システム権限プロンプトを再トリガー**」をクリックすると、システムダイアログが直ちに再表示されます。「管理」をクリックして許可してください。
     - **方法 2（システム設定）**: 「**システム設定 > プライバシーとセキュリティ > ファイルとフォルダ**」（または「**フルディスクアクセス**」）を開き、**QBMenubar** を許可します。
     - **方法 3（ターミナルでリセット）**: 以前にアクセスを拒否してシステム設定一覧に見当たらない場合は、ターミナルで以下を実行します：
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
       その後 QBMenubar を再起動してウィジェット同期スイッチをオンにすると、再度許可プロンプトが表示されます。
   - **注意点**: ウィジェットがリアルタイム同期を行うにはこの権限が必要です（未許可時は「権限が必要です」と表示されます）。**この権限を許可しなくても、メニューバー本体のすべての監視・制御・マグネット追加機能は 100% 正常に動作します。**

---

### 🚀 v1.3.2 の主な更新内容
- **Transmission クライアントのネイティブ対応**：サービス層の抽象化により Transmission JSON-RPC プロトコルをネイティブサポート（409 CSRF Session-Id ハンドシェイクおよび Basic 認証を自動処理）。qBittorrent と Transmission のシームレスな切り替えに対応し、デスクトップウィジェット、速度グラフ、タスク追加も完全互換で動作します。
- **設定サイドバーのリキッドグラス光学レンズ**：macOS Tahoe のクリスタルガラスレンズ質感を完全再現。上下の物理的な屈折シャドウ、エッジの虹色プリズム分散、スプリングアニメーションを搭載（クラシックな単色ハイライトも設定から切り替え可能）。
- **ウィジェット用リキッドグラスリング進捗表示**：方向矢印付きのリング型プログレスダイヤルと浮遊ガラスバッジを追加（従来のクラシック横型カプセルバーも保持し、設定から切り替え可能）。
- **ネイティブ WidgetKit エントリポイントの最適化**：`_NSExtensionMain` リンクを適正化し、macOS `chronod` による確実な検出とプレースホルダー読み込みを保証。
- **フルディスクアクセスの認証フロー簡素化**：設定画面のレイアウト崩れや文字見切れを解消し、わかりやすい権限案内を提供。
- **単一バンドル登録の最適化**：重複バイナリ登録を排除し、システムウィジェットギャラリーでの素早い検出を実現。

---

## 📥 インストールと起動

### 方法 1: リリース版バイナリの直接ダウンロード（推奨）
Xcode や開発環境不要ですぐに使えます：

👉 **[QBMenubar 最新版をダウンロード (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. `QBMenubar-*-macOS.zip` を解凍します。
2. `QBMenubar.app` を **「アプリケーション (/Applications)」** フォルダへ移動します。
3. **`QBMenubar.app` をダブルクリックして起動**します！メニューバーに常駐します。

> [!TIP]
> **初回起動時の Gatekeeper 警告について:**  
> 「開発元を検証できないため開けません」と表示された場合は、Finder で **`QBMenubar.app` を右クリック（または Control キーを押しながらクリック）** して **「開く」** を選択してください。

---


---

## ⚙️ クライアント設定ガイド (qBittorrent & Transmission)

| クライアント | 推奨設定 | ポート / パス | 認証 |
|---|---|---|---|
| **qBittorrent** | WebUI を有効化 (API v2) | デフォルト `8080` (例: `http://192.168.1.100:8080`) | ユーザー名 & パスワード |
| **Transmission** | RPC リモートアクセスを有効化 | デフォルト `9091` (パス: `/transmission/rpc`) | RPC 認証 & 409 CSRF 自動処理 |

> [!TIP]
> **ワンクリックでクライアント切り替え:**  
> 設定画面 (**⌘,**) の「**WebUI 接続**」で「qBittorrent」または「Transmission」を選択するだけで、すべてのメニューバー速度表示、ウィジェット、タスク管理が自動的に適応します。

---

## ❓ よくある質問 (FAQ)

<details>
<summary><b>1. リモート NAS、Unraid、Docker 上のクライアントに接続できますか？</b></summary>
はい。ローカル Mac はもちろん、Synology DSM、QNAP、Unraid、TrueNAS、Docker コンテナ、リモート VPS 上で稼働する qBittorrent / Transmission に、LAN IP、DDNS ドメイン、HTTPS リバースプロキシ経由で完全に接続できます。
</details>

<details>
<summary><b>2. ウィジェットのシステム権限を許可しなくてもアプリは使えますか？</b></summary>
はい。デスクトップウィジェットの同期権限（「他のアプリのデータ」）を許可しなくても、メニューバー常駐本体の速度監視、タスクピン留め、一時停止/再開、マグネット追加などすべての機能は 100% 完全に動作します。
</details>

<details>
<summary><b>3. メニューバーのポップオーバーウィンドウの高さを調整できますか？</b></summary>
はい！v1.3.2 より、ポップオーバー下部のインタラクティブなハンドルバーを上下にドラッグすることで、380pt から 920pt まで自由に高さを調整できます。ダブルクリックするとデフォルトの 550pt に瞬時に復帰します。またウィンドウ上端は常にメニューバー直下に美しく固定されます。
</details>

<details>
<summary><b>4. ブラウザ WebUI や Electron アプリと比較してどれくらい軽快ですか？</b></summary>
ブラウザの常時オープンタブ（300MB〜1GB、CPU 1〜5%）や Electron ラッパーと異なり、QBMenubar は純粋な Swift 6 ネイティブバイナリです。アイドル時メモリは約 35〜45MB、CPU 負荷は 0.1% 未満で、MacBook のバッテリーをほとんど消費しません。
</details>

<details>
<summary><b>5. 特定のダウンロードタスクをメニューバーにピン留めするには？</b></summary>
ポップオーバー内のタスクカードにあるピン留めアイコン（📌）をクリックするだけで、メニューバーの時計横にリアルタイム速度と進捗率（例: `↓ 12.0 MB/s 85%`）が常時表示されます。
</details>

## 🏷️ 検索キーワード (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-controller` • `transmission-remote` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `menubar-extra` • `widgetkit` • `macos-widgets` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid`

---

## 📄 ライセンス
本プロジェクトは [MIT License](LICENSE) のもとで公開されています。
