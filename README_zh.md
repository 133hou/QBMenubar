# ⚡️ QBMenubar — 原生 macOS qBittorrent & Transmission 状态栏监控与桌面小组件客户端

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - 原生 macOS qBittorrent 与 Transmission 菜单栏监控与桌面小组件客户端（Liquid Glass 设计）" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="总下载量"></a>
  <img src="https://img.shields.io/badge/客户端-qBittorrent%20%2B%20Transmission-blue" alt="支持客户端">
  <img src="https://img.shields.io/badge/小组件-WidgetKit%20(小%2F中%2F大)-emerald" alt="macOS 桌面小组件">
  <img src="https://img.shields.io/badge/平台-macOS%2014.0%2B%20(Sonoma%2FSequoia%2FTahoe)-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-6.0-orange" alt="Swift 6">
  <img src="https://img.shields.io/badge/架构-Universal%20(Apple%20Silicon%20%2B%20Intel)-purple" alt="Apple Silicon & Intel">
  <img src="https://img.shields.io/badge/开源协议-MIT-green" alt="MIT License">
</p>

<p align="center">
  <a href="README.md">English</a> | 
  <b>简体中文</b> | 
  <a href="README_zh-Hant.md">繁體中文</a> | 
  <a href="README_ja.md">日本語</a> | 
  <a href="README_ko.md">한국어</a> | 
  <a href="README_de.md">Deutsch</a> | 
  <a href="README_fr.md">Français</a> | 
  <a href="README_es.md">Español</a> | 
  <a href="README_ru.md">Русский</a>
</p>

**QBMenubar** 是一款专为 Mac 用户打造的纯原生 **macOS qBittorrent 菜单栏客户端** 与 **Transmission 远程管理工具（Transgui / Transmission Remote GUI 现代化替代方案）**，基于 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 深度工程化构建。完美适配 Apple Silicon M 系列芯片与 macOS Sonoma / Sequoia / Tahoe，融合现代 **Liquid Glass（液态玻璃）** 半透明视觉美学、**Apple Motion Feel** 原生物理弹簧动效与 macOS **桌面小组件**。无论管理本地下载，还是 **Mac 远程管理群晖（Synology DSM）、飞牛私有云（fnOS）、极空间、威联通（QNAP）、Unraid、TrueNAS 与 Docker 下载器**，亦或是 **PT（Private Tracker）私有种子下载与 Seedbox 状态栏实时网速监控**，QBMenubar 均能以近乎零资源占用（空闲 CPU < 0.1%，内存 ~40MB）提供极速流畅的常驻监控体验。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar 菜单栏实时速率监控与图钉进度胶囊预览" width="650" />
</p>

## 🧭 快速导航 (Table of Contents)
- [🎯 核心使用场景与亮点](#use-cases)
- [📸 界面预览与实机效果](#screenshots)
- [📊 深度对比：为什么选择 QBMenubar？](#comparison)
- [✨ 核心特性一览](#features)
  - [🧩 桌面小组件（零系统权限开箱即用）](#desktop-widgets)
- [🔒 安全隐私与底层可靠性保障](#security)
- [🚀 v1.3.2 更新亮点](#whats-new)
- [📥 下载安装与运行](#download)
- [⚙️ 首次配置指南（1 分钟快速上手）](#configuration)
- [❓ 常见问题与解答 (FAQ)](#faq)
- [🏷️ 搜索关键词与索引标签](#keywords)
- [📄 开源许可协议](#license)

---

<a id="use-cases"></a>
## 🎯 核心使用场景与亮点

- 🚀 **本地客户端与远程 NAS 双向监控**：无论 qBittorrent 还是 Transmission 运行在本地 Mac、群晖（Synology DSM）、飞牛（fnOS）、极空间、威联通（QNAP）、Unraid、TrueNAS、Docker 容器还是远程云端 Seedbox，只需配置 WebUI 地址（支持内网 IP、DDNS 域名与 HTTPS 反向代理）即可秒级同步。
- 📌 **PT / 关键任务菜单栏图钉置顶**：点击卡片右上角图钉，将正在高速下载的 PT 关键任务进度百分比与实时网速直接固定在屏幕顶部的系统状态栏（例如：`↓ 12.0 MB/s 85%`），无需切换窗口即可掌握种子状态。
- ⚡️ **无感低功耗后台常驻**：基于 Swift 6 编译型原生代码开发，相较于臃肿的 Electron 包装器或常开浏览器标签页，日常静默运行 CPU 占用接近 0.0%，内存仅占用 ~35-45 MB，完全不损耗电池续航。
- 🐢 **会议与游戏一键限速**：顶部快捷面板一键暂停所有任务、一键恢复，或快速开启备用限速（🐢 小乌龟模式），开会打游戏不再被下载抢占带宽。
- 📋 **磁力与种子智能捕获**：自动识别系统剪贴板中的 `magnet:` 磁力链接或 HTTP 种子链接，并支持上传本地 `.torrent` 文件在下载前预览内部文件目录与设定保存路径。
- 🖥️ **macOS 桌面小组件监控下载进度**：WidgetKit 原生小组件提供 Small、Medium、Large 三种规格，桌面与通知中心即时掌握全局上传下载速率与活跃任务。

---

<a id="screenshots"></a>
## 📸 界面预览与实机效果

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass 主弹窗、动态带宽波形图与种子列表" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS 系统设置风格偏好设置窗口与液态玻璃选中透镜" width="480" />
</p>

<p align="center">
  <em>液态玻璃环形圈样式 (流光导向箭头)：</em><br />
  <img src="docs/images/preview_widgets_showcase.png" alt="QBMenubar macOS 桌面与通知中心小组件 - 液态玻璃环形圈样式" width="650" />
</p>

<p align="center">
  <em>经典横向胶囊进度条样式 (完整保留)：</em><br />
  <img src="docs/images/preview_widgets_classic.png" alt="QBMenubar macOS 桌面与通知中心小组件 - 经典横向胶囊进度条样式" width="650" />
</p>

<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar 小组件设置与桌面小组件配置" width="580" />
</p>

---

<a id="comparison"></a>
## 📊 深度对比：为什么选择 QBMenubar？

| 功能维度 | QBMenubar (Mac 原生应用) | 浏览器 WebUI 网页 | 官方 Qt 桌面客户端 | Transgui / 脚本插件 |
|---|:---:|:---:|:---:|:---:|
| **双客户端引擎** | ✅ **qBittorrent & Transmission** | ❌ 仅限单个实例 | ❌ 仅限 qBittorrent | ⚠️ 单客户端 / 维护停滞 |
| **状态栏常驻与交互** | ✅ 原生 Liquid Glass 弹窗 | ❌ 仅限网页窗口 | ❌ 仅限 Dock / 独立主窗 | ⚠️ 纯文本下拉菜单（无交互卡片） |
| **菜单栏图钉任务进度** | ✅ 状态栏黑白单色徽章直显 | ❌ | ❌ | ❌ |
| **实时动态带宽波形图** | ✅ Swift Charts 平滑物理波形 | ⚠️ 静态刷新折线 | ⚠️ 简易折线 | ❌ |
| **可拉伸窗口高度** | ✅ 底部把手自由拖拽 (380-920pt) | ⚠️ 手动调整网页 | ⚠️ 复杂桌面窗口 | ❌ 固定纯文本 |
| **内存占用** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **后台空闲 CPU** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **远程 NAS / Docker 连接** | ✅ 本地、内网 NAS 与域名反代 | ✅ | ❌ 仅支持本机守护进程 | ⚠️ 鉴权与反代支持有限 |
| **交互式文件树穿透展开** | ✅ 原生卡片层级展开与单文件进度 | ⚠️ 复杂表格多次点击 | ⚠️ 密集表格 | ❌ |
| **桌面与通知中心小组件 (WidgetKit)** | ✅ 支持小/中/大三种尺寸 | ❌ | ❌ | ❌ |
| **macOS 系统通知推送** | ✅ 任务下载完成原生通知 | ⚠️ 需浏览器权限常驻 | ⚠️ 旧式弹窗 | ❌ |
| **Apple Silicon 原生架构** | ✅ 纯 Swift 6 Universal 通用二进制 | ⚠️ Web 渲染进程 | 🟡 Rosetta 转译 / Qt 臃肿 | ⚠️ 依赖 Python 等环境 |

---

<a id="features"></a>
## ✨ 核心特性一览

1. **状态栏常驻与动态监控**：
   - 实时上传 / 下载速率与动态方向图标（`↓` / `↑`）。
   - 专属任务完成度百分比直显（黑白单色半透明胶囊，完美融入状态栏）。
   - 文本宽度自动扩展，彻底杜绝 AppKit 菜单栏文字裁切与截断。
2. **Liquid Glass 现代毛玻璃主弹窗**：
   - 遵循 macOS 液态材质设计，高光镜面边缘与微光倒影。
   - **实时动态带宽波形图**（Swift Charts），平滑呈现流量起伏。
   - 顶部快捷操作栏：暂停全部、全部继续、备用限速（🐢 小乌龟）、一键直达 WebUI。
   - 分类过滤标签：全部、下载中、做种中、已暂停。
   - **➕ 本地种子上传**：支持解析 `.torrent` 文件，在添加前预览内部文件清单并自定义保存目录。
   - **📋 剪贴板快速添加**：一键识别磁力链接（`magnet:`）或 HTTP/HTTPS 种子链接。
3. **交互式种子卡片 & 文件穿透展开**：
   - 清晰呈现任务名、状态徽章、渐变进度条、已完成体积、ETA 剩余时间与速率。
   - **点击卡片流畅展开内部文件列表**：直观展示每一个文件的专属类型图标、文件名、体积与独立下载百分比。
   - **📌 图钉一键置顶**：点击卡片右上角图钉，将指定任务的下载进度锁定到 macOS 菜单栏展示。
   - 右键菜单支持定位 Finder 目录、重新校验完整性、删除任务（支持选择是否保留本地文件）。
4. **macOS 系统设置风格偏好面板**：
   - 原生固定双栏布局，彻底杜绝侧边栏折叠按钮。
   - 全面支持自定义 WebUI API（支持本地 `127.0.0.1:8080`、局域网 NAS、远程 VPS 或 HTTPS 反代域名）。
   - 内置**连通性测试器**：一键探测延迟（Ping）与服务端版本。
   - 支持 macOS 原生系统通知（任务开始下载与下载完成提醒）。
   - 完整 9 种语言本地化支持（简体中文、繁體中文、English、日本語、한국어、Deutsch、Français、Español、Русский）。
5. **macOS 桌面与通知中心小组件 (WidgetKit)**：
   - **小号组件 (.systemSmall)**：单任务焦点进度卡片，直观显示最活跃任务进度条、当前速度与剩余时间 (ETA)。
   - **中号组件 (.systemMedium)**：双栏布局，左侧显示全局实时上传下载带宽与任务计数，右侧列出前 2-3 个活跃下载任务进度。
   - **大号组件 (.systemLarge)**：全功能任务看板，包含多任务进度、状态标签、传输统计与一键跳转。
   - **零开销本地快照同步**：主应用与小组件进程间极速低耗同步。
   - 完美适配 macOS 全彩、深色以及着色/高亮模式 (`widgetAccentable`)。

<a id="desktop-widgets"></a>
### 🧩 桌面小组件（WidgetKit）—— 零系统权限开箱即用

QBMenubar 原生支持 macOS 桌面与通知中心小组件（提供 Small、Medium、Large 三种尺寸），无需打开主应用即可在桌面随时查看网速与下载进度：

1. **在设置中启用**：点击菜单栏图标打开「偏好设置」(**⌘,**) -> 进入「**小组件**」标签页 -> 开启「**启用桌面小组件同步**」。
2. **零权限隐私保障（无需完全磁盘访问权限）**：
   - **🔒 本地沙盒极速快照**：最新版本重构了数据同步通道，通过高度优化的轻量本地快照直连，**完全无需授予 macOS「完全磁盘访问权限 (Full Disk Access)」**，不触碰任何用户个人文件与外部数据，安全纯净。
   - **🔋 智能省电 WidgetKit 刷新限频**：严格遵从 macOS 系统 WidgetKit 刷新预算（智能 15 分钟合并刷新机制与状态变更感知），避免频繁唤醒芯片与无线网卡，大幅延长 MacBook 电池续航。
   - **🛡️ 优雅断连与空状态感知**：当 qBittorrent / Transmission 离线或无活跃任务时，小组件自动展示轻量清爽的自愈断连卡片，彻底避免界面卡死或旧数据残留。
3. **如何将小组件添加到桌面**：
   - 在 macOS 桌面任意空白处**右键单击** -> 选择「**编辑小组件...**」（或点击屏幕右上角时间呼出通知中心，滑到最底部点击「编辑小组件」）。
   - 在左侧应用列表找到 **`QBMenubar`**（或在上方搜索框搜索 **`QBMenubar`** / **`qBittorrent`**）。
   - 点击或直接拖拽 **Small（小）**、**Medium（中）**、**Large（大）** 组件至桌面或通知中心即可！

---

<a id="security"></a>
## 🔒 安全隐私与底层可靠性保障

QBMenubar 在网络传输、数据安全与协议解析层面进行了深度加固：

- 🔐 **macOS Keychain 钥匙串安全加密**：WebUI 远程访问密码经系统原生 **Keychain Services** 硬件级安全隔离加密保存，彻底根绝在 `UserDefaults` 或配置文件中明文存储密码的安全隐患。
- 🔋 **智能省电 WidgetKit 预算管控**：自适应管理 WidgetKit 刷新配额，杜绝无效轮询，无缝平衡实时性与笔记本功耗。
- 🌐 **严格 RFC 3986 网络表单编码**：针对含有特殊字符（如 `@`, `#`, `$`, `%`, `&`, `+`）的复杂密码与磁力链接参数进行标准化 Percent-Encoding，杜绝截断与鉴权失败。
- 🛡️ **Transmission CSRF 并发并发控制**：对 Transmission JSON-RPC 409 CSRF Session-Id 进行线程安全原子管理，防止并发请求下的鉴权碰撞与重复握手。
- 📦 **Bencode 种子解析防崩溃机制**：内置严格的 256 层递归深度上限与整数溢出防护，抵御恶意构造的畸形 `.torrent` 种子文件。

---

<a id="whats-new"></a>
### 🚀 v1.3.2 更新亮点
- **新增 Transmission 客户端原生支持**：架构抽象解耦，原生对接 Transmission JSON-RPC 协议（自动处理 409 CSRF Session-Id 握手与 Basic Auth 鉴权）。现已完美支持 qBittorrent 与 Transmission 双客户端无缝切换，桌面小组件、速度折线图与添加任务完全通用。
- **macOS Keychain 钥匙串密码加密与安全加固**：WebUI 连接密码已全面迁移至 macOS Keychain 加密托管；网络层遵循 RFC 3986 编码，并包含并发 CSRF 安全机制与 Bencode 防溢出保护。
- **智能 WidgetKit 刷新限频（零权限体验）**：彻底移除完全磁盘访问权限要求，基于本地快照与自适应限频实现桌面小组件极速省电同步。
- **设置侧边栏高透液态玻璃光学透镜**：复刻原生 macOS Tahoe 水晶液态玻璃透镜质感，具备上下凹面物理折射阴影、边缘棱镜色彩色散与平滑弹簧滑行动画（原经典纯色高亮样式完整保留，可在通用设置中自由切换）。
- **小组件液态玻璃环形进度圈**：新增带流光导向箭头的环形进度仪表盘与中央悬浮玻璃圆角状态指示器（经典横向胶囊进度条 100% 保留，可在偏好设置 -> 小组件中按需切换）。
- **原生 WidgetKit 扩展入口点适配**：链接器正式补齐 `_NSExtensionMain` 符号入口，使系统 `chronod` 与通知中心能够稳定拉起插件并预载 Small、Medium、Large 桌面小组件占位图与描述符。
- **单应用包生命周期优化**：清理多余的构建注销与 LaunchServices 缓存冲突，确保系统小组件库即时感知与更新。

---

<a id="download"></a>
## 📥 下载安装与运行

### 方式 1：直接下载运行包（推荐，开箱即用）
无需安装 Xcode 或终端环境，直接下载预编译打包好的 macOS 原生应用：

👉 **[下载最新版 QBMenubar (Latest) (macOS)](https://github.com/133hou/QBMenubar/releases/latest)**

1. 下载后双击解压出 `QBMenubar.app`；
2. 将其拖入访达的 **「应用程序 (/Applications)」** 文件夹中；
3. **双击 `QBMenubar.app` 即可直接运行**！应用将静默常驻在屏幕顶部的系统状态栏。

> [!TIP]
> **首次运行安全提示（Gatekeeper）：**  
> 开源应用首次打开时，macOS 可能会弹出 *“无法打开，因为无法验证开发者”* 提示。  
> 解决方法：在访达的「应用程序」中，**右键（或按住 Control 点击）`QBMenubar.app`** -> 选择 **「打开」** -> 在弹窗中点击 **「打开」** 即可正常放行。  
> 或在终端中执行一行命令清除隔离属性：`xattr -cr /Applications/QBMenubar.app`

### 方式 2：从源码本地编译 (Build from Source)
运行环境：macOS 14.0+，Xcode 15+ / Swift 6.0+。

```bash
git clone https://github.com/133hou/QBMenubar.git
cd QBMenubar
swift build -c release
./build_app.sh
open QBMenubar.app
```

---

<a id="configuration"></a>
## ⚙️ 首次配置指南（1 分钟快速上手）

### qBittorrent 用户：
1. **启用 WebUI**：打开 qBittorrent -> **偏好设置 (Preferences) -> Web UI**，勾选 **Web 用户界面 (远程控制)**（默认端口 `8080`）。
2. **连接 QBMenubar**：打开 QBMenubar 设置 -> **WebUI 连接**，客户端选择 **qBittorrent**，检查地址（默认 `http://127.0.0.1:8080`、API 前缀 `/api/v2`），输入账户密码后点击 **测试连接**。

### Transmission 用户：
1. **启用远程访问**：打开 Transmission -> **偏好设置 -> 远程 (Remote)**，勾选 **启用远程访问**（默认端口 `9091`）。
2. **连接 QBMenubar**：打开 QBMenubar 设置 -> **WebUI 连接**，将客户端类型切换为 **Transmission**，地址将自动预设为 `http://127.0.0.1:9091` 与 `/transmission/rpc`，若设置了密码请输入后点击 **测试连接** 即可！

---

<a id="faq"></a>
## ❓ 常见问题与解答 (FAQ)

<details>
<summary><b>1. QBMenubar 可以作为 macOS 上 Transmission Remote GUI (Transgui) 的现代替代品吗？</b></summary>
是的，完全可以并且体验显著提升。传统的 <i>Transmission Remote GUI (Transgui)</i> 基于古老的 Pascal/Lazarus 框架，多年疏于维护，UI 风格陈旧且无法良好适配 Apple Silicon 芯片与 Retina 高分屏。QBMenubar 专为现代 macOS 与 Apple Silicon 原生打造，采用纯 Swift 6 + SwiftUI 编写，不仅完美支持 <b>Transmission JSON-RPC 与 qBittorrent</b> 双客户端，还提供现代毛玻璃菜单栏面板、桌面小组件、图钉置顶与波形图，内存仅占 ~40MB，是当前 macOS 上极具现代化体验的替代方案。
</details>

<details>
<summary><b>2. QBMenubar 如何保障我的 WebUI 连接密码安全？</b></summary>
您的连接密码直接保存在苹果原生的 <b>macOS Keychain（钥匙串）</b> 中，受系统级加密保护。应用绝不会将密码明文写入 <code>UserDefaults</code> 或本地配置文件，在与 WebUI 建立连接时才会即时从钥匙串读取至安全内存，安全可靠。
</details>

<details>
<summary><b>3. QBMenubar 支持同时连接或切换 qBittorrent 与 Transmission 吗？</b></summary>
是的！QBMenubar 具备统一的服务抽象层。您只需在「设置 -> WebUI 连接」中选择 <b>qBittorrent</b> 或 <b>Transmission</b>，菜单栏实时速率、展开卡片、折线图与桌面小组件均全面无缝兼容。
</details>

<details>
<summary><b>4. 如何连接群晖 Synology、TrueNAS、威联通 QNAP、飞牛 fnOS 或 Docker 中的下载器？</b></summary>
只需在「服务器地址」一栏填入 NAS 的局域网 IP（例如 <code>http://192.168.1.100:8080</code> 或 <code>http://nas.local:9091</code>）、自定义域名或 HTTPS 反向代理地址即可。QBMenubar 原生支持反向代理子路径与基础认证。
</details>

<details>
<summary><b>5. 如何在 macOS Sonoma、Sequoia 或 Tahoe 桌面添加小组件？</b></summary>
在 Mac 桌面空白处右键点击<b>「编辑小组件」</b>（或在通知中心底部点击），搜索 <b>QBMenubar</b>，即可将<b>小（Small）</b>、<b>中（Medium）</b>或<b>大（Large）</b>规格的小组件拖至桌面或通知中心。您还可以在设置中自由选择<b>液态玻璃环形圈</b>或<b>经典横向胶囊条</b>样式，完全无需授予任何特殊系统权限。
</details>

<details>
<summary><b>6. 为什么 QBMenubar 的内存占用只有 40MB，而网页端占用几百 MB？</b></summary>
QBMenubar 采用纯原生 <b>Swift 6 + SwiftUI</b> 开发，零内嵌网页、零 Chromium/Electron 臃肿运行时，直接以原生网络协议并发调度，空闲时 CPU 占用近乎为零（&lt;0.1%），极其节能省电。
</details>

<details>
<summary><b>7. 菜单栏弹出的控制窗口可以拉长放大吗？</b></summary>
完全可以！点击菜单栏弹出面板后，将鼠标移至面板<b>最底部正中央的原生拖拽把手</b>，鼠标变为上下箭头后即可在 <b>380pt ~ 920pt</b> 之间任意拖拽拉伸窗口高度。高度会自动记住，双击把手可一键平滑弹回默认 550pt 高度。
</details>

---

<a id="keywords"></a>
## 🏷️ 搜索关键词与索引标签 (Keywords)
`qbittorrent` • `transmission` • `qbittorrent-mac` • `macos-menubar` • `transmission-remote-gui` • `transgui-mac替代` • `transmission-mac` • `群晖下载器管理` • `飞牛-fnos` • `极空间-docker` • `威联通-qnap` • `unraid-torrent` • `truenas` • `pt下载` • `pt监控` • `seedbox` • `桌面小组件` • `widgetkit` • `swiftui` • `swift6` • `liquid-glass` • `apple-silicon` • `macos-tahoe` • `macos-sequoia` • `macos-sonoma`

---

<a id="license"></a>
## 📄 开源许可协议
本项目采用 [MIT License](LICENSE) 授权开源。
