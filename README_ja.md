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

**QBMenubar** は、**Swift 6 + SwiftUI + MenuBarExtra (.window)** を用いて完全ネイティブで構築された、macOS 向けの最先端 **qBittorrent メニューバークライアント** および **Transmission リモート GUI（Transgui / Transmission Remote GUI の現代的代替アプリ）** です。Apple Silicon（M1/M2/M3/M4）および Intel Mac に完全対応し、先進的な **Liquid Glass（リキッドグラス）** 半透明マテリアルと **Apple Motion Feel** のネイティブ物理スプリングアニメーション、macOS **デスクトップウィジェット** を融合。Mac ローカルのダウンロード管理はもちろん、**Synology DSM、QNAP、Unraid、TrueNAS、Docker コンテナ** などの自宅 NAS や、**PT / プライベートトラッカー（Seedbox）** の遠隔監視まで、アイドル時 CPU 0.1% 未満・メモリ約40MB という超低リソースで快適な常駐監視を実現します。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar メニューバー速度モニターとピン留め進捗バッジ" width="650" />
</p>

## 🧭 クイックナビゲーション (Table of Contents)
- [🎯 主な利用シーン (Use Cases)](#use-cases)
- [📸 スクリーンショット & 実機プレビュー](#screenshots)
- [📊 機能比較：なぜ QBMenubar なのか？](#comparison)
- [✨ 主な機能一覧](#features)
  - [🧩 デスクトップウィジェット（追加権限不要）](#desktop-widgets)
- [🔒 セキュリティ・プライバシー & 信頼性](#security)
- [🚀 v1.3.2 の主な更新内容](#whats-new)
- [📥 インストールと起動](#download)
- [⚙️ クライアント設定ガイド (qBittorrent & Transmission)](#configuration)
- [❓ よくある質問 (FAQ)](#faq)
- [🏷️ 検索キーワード (Keywords)](#keywords)
- [📄 ライセンス](#license)

---

<a id="use-cases"></a>
## 🎯 主な利用シーン (Use Cases)

- 🚀 **ローカル & リモート NAS 統合監視**：Mac ローカル、**Synology DSM、QNAP、Unraid、TrueNAS、Docker** コンテナ、リモート Linux / VPS 上で動作する qBittorrent および Transmission を、LAN IP、ドメイン、HTTPS リバースプロキシ経由でシームレスに遠隔制御。
- 📌 **特定タスクのメニューバー進捗固定（Pin）**：重要なダウンロードタスクを1クリックでピン留めし、メニューバーの時計横に進捗パーセンテージ（例: `↓ 12.0 MB/s 85%`）を常時表示 — **PT / プライベートトラッカーやシードボックス監視**に最適。
- ⚡️ **極小リソース消費のバックグラウンド常駐**：Electron ラッパーや常時ブラウザタブと異なり、Swift 6 ネイティブバイナリのためアイドル時 CPU 0.0%、メモリ約 35〜45MB でバッテリーを消費しません。
- 🐢 **ワンクリック一時停止 & 制限切り替え**：オンライン会議やゲーム中に全タスク一時停止や代替速度制限（🐢 カメモード）を瞬時に切り替え可能。
- 📋 **マグネットリンク自動検知 & ファイルツリー確認**：クリップボードの `magnet:?xt=` リンクや URL を自動検知し、`.torrent` ファイルのダウンロード前内部構造プレビューと保存先指定に対応。
- 🖥️ **qBittorrent macOS デスクトップウィジェット**：WidgetKit に準拠した Small、Medium、Large の各サイズで、アプリやブラウザを開くことなくデスクトップや通知センターで通信速度と進行状況をひと目で把握。

---

<a id="screenshots"></a>
## 📸 スクリーンショット & 実機プレビュー

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass ポップオーバー画面" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS システム設定風 設定ウィンドウ" width="480" />
</p>

<p align="center">
  <em>Liquid Glass 円形リング進捗スタイル (新機能):</em><br />
  <img src="docs/images/preview_widgets_showcase.png" alt="Liquid Glass Widget Showcase" width="650" />
</p>

<p align="center">
  <em>クラシック直線型カプセルバースタイル (完全保持):</em><br />
  <img src="docs/images/preview_widgets_classic.png" alt="Classic Linear Widget Showcase" width="650" />
</p>

<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar ウィジェット設定およびデスクトップウィジェット設定画面" width="580" />
</p>

---

<a id="comparison"></a>
## 📊 機能比較：なぜ QBMenubar なのか？

| 機能・指標 | QBMenubar (ネイティブ Mac アプリ) | ブラウザ WebUI | 公式 Qt クライアント | Transgui / 外部スクリプト |
|---|:---:|:---:|:---:|:---:|
| **デュアルクライアント対応** | ✅ **qBittorrent & Transmission** | ❌ 1インスタンスのみ | ❌ qBittorrent のみ | ⚠️ 単一 / メンテナンス停止 |
| **メニューバー常駐 & UI** | ✅ ネイティブ Liquid Glass | ❌ Web 画面のみ | ❌ Dock/大画面のみ | ⚠️ テキストのみ |
| **特定タスク進捗ピン留め** | ✅ メニューバーにバッジ直出し | ❌ | ❌ | ❌ |
| **リアルタイム帯域波形** | ✅ Swift Charts 滑らか物理波形 | ⚠️ 静的更新折れ線 | ⚠️ 簡易グラフ | ❌ |
| **伸縮可能なウィンドウ高さ** | ✅ 下部ハンドルでドラッグ (380-920pt) | ⚠️ 手動調整 | ⚠️ 複雑な画面 | ❌ 固定 |
| **メモリ消費量** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **アイドル時 CPU 負荷** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **リモート NAS & Docker 接続** | ✅ LAN / NAS / HTTPS 反代 | ✅ | ❌ ローカル限定 | ⚠️ 認証制限あり |
| **ファイルツリー展開プレビュー** | ✅ カード内で階層展開 & 進捗 | ⚠️ 複数回クリックの表 | ⚠️ 密集した表 | ❌ |
| **デスクトップウィジェット (WidgetKit)** | ✅ 小・中・大の3サイズ対応 | ❌ | ❌ | ❌ |
| **macOS ネイティブ通知** | ✅ 完了通知プッシュ | ⚠️ ブラウザ許可必要 | ⚠️ 旧式アラート | ❌ |
| **Apple Silicon ネイティブ対応** | ✅ 純 Swift 6 ユニバーサル | ⚠️ Web プロセス | 🟡 Rosetta / 巨大 Qt | ⚠️ Python / 依存関係 |

---

<a id="features"></a>
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
   - **📋 クリップボードリンク即時検知**：`magnet:?xt=` や `.torrent` リンクのコピーを検知。
3. **インタラクティブな Torrent カード**:
   - タスク名、ステータス、進行バー、サイズ、ETA、速度を一目で把握。
   - カードをクリックするとファイル一覧がスムーズに展開し、ファイル種別アイコンと個別進捗を表示。
   - **📌 メニューバーにピン留め**：1クリックで進行状況をステータスバーに固定。
   - 右クリックメニュー：Finder で表示、ハッシュ再チェック、削除（ファイル保持選択可能）。
4. **macOS システム設定風 プレファレンス**:
   - 固定2ペインレイアウト。
   - 9言語の完全ローカライズ（日本語、英語、中国語簡体/繁体、韓国語、ドイツ語、フランス語、スペイン語、ロシア語）。
   - リアルタイム Ping 遅延・サーバーバージョン測定ツール内蔵。
   - リバースプロキシ、API サブパス（`/api/v2`）、localhost バイパスに完全対応。
5. **macOS デスクトップ & 通知センター ウィジェット (WidgetKit)**:
   - **小サイズ (`.systemSmall`)**: 最もアクティブなダウンロードタスクの進行状況、リアルタイム転送速度、残り時間（ETA）をコンパクトに表示。
   - **中サイズ (`.systemMedium`)**: 2ペインレイアウト。左側にリアルタイムの全体帯域幅とタスク数、右側にアクティブなダウンロードタスクのプログレスバーを一覧表示。
   - **大サイズ (`.systemLarge`)**: フルダウンロードダッシュボード。帯域サマリー、タスク一覧、ステータスバッジ、QBMenubar への即座ジャンプを統合。
   - **ゼロオーバーヘッドのローカルスナップショット同期**：メニューバー常駐プロセスと macOS 通知センター・デスクトップ間の超軽量同期。
   - macOS のフルカラー、ダーク、着色・アクセント（`widgetAccentable`）モードに完全準拠。

<a id="desktop-widgets"></a>
### 🧩 デスクトップウィジェット（追加権限不要）

QBMenubar は、macOS デスクトップおよび通知センターのウィジェット（Small、Medium、Large の3サイズ）をネイティブサポートしています。

1. **設定で有効化**: メニューバーアイコンをクリックして「設定」(**⌘,**) を開き -> 「**ウィジェット**」タブ -> 「**デスクトップウィジェット同期を有効にする**」をオンにします。
2. **システム権限不要（フルディスクアクセス不要）**:
   - **🔒 ローカルサンドボックス同期**: 最新アップデートにより、軽量かつ安全なローカルスナップショット方式に刷新されました。従来のユーティリティのように**「フルディスクアクセス」などの過剰な権限は一切不要**であり、ユーザーの個人ファイルや他アプリのデータにはアクセスしません。
   - **🔋 バッテリーに優しいスマートスロットリング**: macOS の WidgetKit リロード予算を遵守する適応型スロットリングを導入。無駄なバックグラウンドポーリングを抑制し、MacBook のバッテリー消費を最小限に抑えます。
   - **🛡️ クリーンな切断・空状態ハンドリング**: クライアント未接続時やダウンロードタスクがない場合も、安全に自動復旧するクリーンな状態カードを表示し、画面のフリーズや古いデータの残留を防ぎます。
3. **ウィジェットをデスクトップに追加する方法**:
   - macOS デスクトップの何もない場所で**右クリック** -> 「**ウィジェットを編集...**」を選択（または通知センターを開いて一番下の「ウィジェットを編集」をクリック）。
   - 左側の検索バーで **`QBMenubar`** または **`qBittorrent`** を検索。
   - お好みのサイズ（**Small**、**Medium**、**Large**）を選んでデスクトップまたは通知センターへドラッグ＆ドロップします。

---

<a id="security"></a>
## 🔒 セキュリティ・プライバシー & 信頼性

QBMenubar はセキュリティとデータ保護を最重要事項として設計されています：

- 🔐 **macOS Keychain 暗号化クレデンシャル**: WebUI の接続認証パスワードは、Apple ネイティブの **Keychain Services** によって暗号化保護され、`UserDefaults` や設定ファイルに平文で保存されることは一切ありません。
- 🔋 **省電力な WidgetKit バジェットスロットリング**: 15分単位の結合更新ウィンドウとスマートな接続状態トラッキングにより、MacBook のバッテリー消費を抑えながらウィジェットの応答性を維持します。
- 🌐 **RFC 3986 準拠のネットワーク層**: 認証パスワード内の特殊記号（`@`, `#`, `$`, `%`, `&`, `+`）やマグネットリンクのクエリを正確にパーセントエンコーディングし、通信の欠損や認証失敗を防ぎます。
- 🛡️ **Transmission CSRF 並行性保護**: Transmission JSON-RPC 409 Session-ID ハンドシェイクをスレッドセーフに管理し、並行リクエスト時の競合を防止します。
- 📦 **Bencode パーサー堅牢化**: 256階層の再帰深度上限と整数オーバーフロー防御を内蔵し、悪意を持って細工された `.torrent` ファイルによるクラッシュを防ぎます。

---

<a id="whats-new"></a>
### 🚀 v1.3.2 の主な更新内容
- **Transmission クライアントのネイティブ対応**：サービス層の抽象化により Transmission JSON-RPC プロトコルをネイティブサポート（409 CSRF Session-Id ハンドシェイクおよび Basic 認証を自動処理）。qBittorrent と Transmission のシームレスな切り替えに対応し、デスクトップウィジェット、速度グラフ、タスク追加も完全互換で動作します。
- **macOS Keychain パスワード暗号化 & セキュリティ強化**：WebUI 接続パスワードを Keychain で保護。RFC 3986 フォームエンコーディング、並行 CSRF セーフティ、堅牢な Bencode パーサーを搭載。
- **スマート WidgetKit リロード制限（追加権限撤廃）**：フルディスクアクセス権限を完全不要化。ローカルスナップショットと省電力リロード制御によるスムーズなウィジェット同期を実現。
- **設定サイドバーのリキッドグラス光学レンズ**：macOS Tahoe のクリスタルガラスレンズ質感を完全再現。上下の物理的な屈折シャドウ、エッジの虹色プリズム分散、スプリングアニメーションを搭載（クラシックな単色ハイライトも設定から切り替え可能）。
- **ウィジェット用リキッドグラスリング進捗表示**：方向矢印付きのリング型プログレスダイヤルと浮遊ガラスバッジを追加（従来のクラシック横型カプセルバーも保持し、設定から切り替え可能）。
- **ネイティブ WidgetKit エントリポイントの最適化**：`_NSExtensionMain` リンクを適正化し、macOS `chronod` による確実な検出とプレースホルダー読み込みを保証。
- **単一バンドル登録の最適化**：重複バイナリ登録を排除し、システムウィジェットギャラリーでの素早い検出を実現。

---

<a id="download"></a>
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
> またはターミナルで実行: `xattr -cr /Applications/QBMenubar.app`

### 方法 2: ソースコードからビルド
動作要件: macOS 14.0+, Xcode 15+ / Swift 6.0+。

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

<a id="configuration"></a>
## ⚙️ クライアント設定ガイド (qBittorrent & Transmission)

### qBittorrent をご利用の場合:
1. **WebUI を有効化**: qBittorrent を開き -> **設定 (Preferences) -> Web UI** -> **Web ユーザーインターフェース (遠隔制御)** にチェック（デフォルトポート `8080`）。
2. **QBMenubar で接続**: QBMenubar 設定 -> **WebUI 接続** -> クライアントで **qBittorrent** を選択。アドレス（`http://127.0.0.1:8080`、API プレフィックス `/api/v2`）とユーザー名・パスワードを入力して **接続テスト** をクリック。

### Transmission をご利用の場合:
1. **RPC リモートアクセスを有効化**: Transmission を開き -> **設定 -> リモート (Remote)** -> **リモートアクセスを有効にする** にチェック（デフォルトポート `9091`）。
2. **QBMenubar で接続**: QBMenubar 設定 -> **WebUI 接続** -> クライアントを **Transmission** に切り替え（アドレスは自動で `http://127.0.0.1:9091`、`/transmission/rpc` が設定されます）。認証情報を入力して **接続テスト** をクリック！

---

<a id="faq"></a>
## ❓ よくある質問 (FAQ)

<details>
<summary><b>1. QBMenubar は macOS における Transmission Remote GUI (Transgui) の優れた代替アプリになりますか？</b></summary>
はい、非常に強力な現代的代替ソリューションとなります。かつて広く使われていた <i>Transmission Remote GUI (Transgui)</i> は古い Pascal/Lazarus ツールキットで構築されており、長年メンテナンスが滞っているため、Apple Silicon へのネイティブ対応や最新 macOS デザインの恩恵を受けられません。QBMenubar は最新の Swift 6 + SwiftUI でゼロから開発され、<b>Transmission と qBittorrent の双方</b>に対応。Liquid Glass 半透明デザイン、常駐メニューバー、デスクトップウィジェット、リアルタイム通信波形を備え、メモリ消費約40MB・CPU負荷 0.1% 未満という極小フットプリントで軽快に動作します。
</details>

<details>
<summary><b>2. QBMenubar は WebUI パスワードをどのように安全に保管していますか？</b></summary>
接続パスワードは、Apple の公式セキュリティフレームワーク（<code>kSecClassGenericPassword</code>）を利用して、暗号化された **macOS Keychain（キーチェーン）** に安全に保存されます。<code>UserDefaults</code> や設定ファイルに平文で記録されることはなく、接続通信時のみ安全に読み出されるため安心です。
</details>

<details>
<summary><b>3. リモート NAS、Unraid、Docker 上のクライアントに接続できますか？</b></summary>
はい。ローカル Mac はもちろん、Synology DSM、QNAP、Unraid、TrueNAS、Docker コンテナ、リモート VPS 上で稼働する qBittorrent / Transmission に、LAN IP、DDNS ドメイン、HTTPS リバースプロキシ経由で完全に接続できます。
</details>

<details>
<summary><b>4. ウィジェットを使用するために追加のシステム権限は必要ですか？</b></summary>
いいえ。最新の QBMenubar ではローカルスナップショット同期を採用しており、フルディスクアクセスなどの特別な権限は一切不要です。設定画面でウィジェット同期をオンにするだけで、すぐにご利用いただけます。
</details>

<details>
<summary><b>5. メニューバーのポップオーバーウィンドウの高さを調整できますか？</b></summary>
はい！ポップオーバー下部のインタラクティブなハンドルバーを上下にドラッグすることで、380pt から 920pt まで自由に高さを調整できます。ダブルクリックするとデフォルトの 550pt に瞬時に復帰します。
</details>

<details>
<summary><b>6. ブラウザ WebUI や Electron アプリと比較してどれくらい軽快ですか？</b></summary>
ブラウザの常時オープンタブ（300MB〜1GB、CPU 1〜5%）や Electron ラッパーと異なり、QBMenubar は純粋な Swift 6 ネイティブバイナリです。アイドル時メモリは約 35〜45MB、CPU 負荷は 0.1% 未満で、MacBook のバッテリーをほとんど消費しません。
</details>

<details>
<summary><b>7. 特定のダウンロードタスクをメニューバーにピン留めするには？</b></summary>
ポップオーバー内のタスクカードにあるピン留めアイコン（📌）をクリックするだけで、メニューバーの時計横にリアルタイム速度と進捗率（例: `↓ 12.0 MB/s 85%`）が常時表示されます。
</details>

---

<a id="keywords"></a>
## 🏷️ 検索キーワード (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-macos` • `transmission-mac` • `qbittorrent-menu-bar` • `transmission-remote-gui` • `transgui-alternative` • `qbittorrent-remote` • `transmission-rpc` • `qbittorrent-webui` • `macos-menubar` • `menubar-app` • `widgetkit` • `desktop-widgets` • `swiftui` • `swift6` • `liquid-glass` • `seedbox-monitor` • `pt-client` • `synology-nas` • `qnap` • `unraid` • `truenas` • `docker-torrent` • `apple-silicon` • `macos-tahoe` • `macos-sequoia` • `macos-sonoma`

---

<a id="license"></a>
## 📄 ライセンス
本プロジェクトは [MIT License](LICENSE) のもとで公開されています。
