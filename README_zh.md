# QBMenubar - 原生 macOS qBittorrent 状态栏控制中心

<p align="center">
  <img src="docs/images/social_preview.png" alt="QBMenubar - 原生 macOS qBittorrent 菜单栏监控与控制器（Liquid Glass 设计）" width="800" />
</p>

<p align="center">
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/v/release/133hou/QBMenubar?color=blue" alt="GitHub Release"></a>
  <a href="https://github.com/133hou/QBMenubar/releases"><img src="https://img.shields.io/github/downloads/133hou/QBMenubar/total.svg?color=success" alt="总下载量"></a>
  <img src="https://img.shields.io/badge/平台-macOS%2014.0%2B-lightgrey" alt="Platform">
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

**QBMenubar** 是一款基于 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 纯原生开发的 macOS 状态栏控制应用。融合现代 **Liquid Glass（液态玻璃）** 半透明材质与 **Apple Motion Feel** 原生物理弹簧动效，为您提供近乎零资源开销（CPU < 0.1%，内存 ~40MB）的 qBittorrent 实时速率监控、图钉任务进度直显与远程 NAS WebUI 深度管理体验。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="QBMenubar 菜单栏实时速率监控与图钉进度胶囊预览" width="650" />
</p>

---

## 🎯 核心使用场景

- 🚀 **本地客户端与远程 NAS 双向监控**：无论 qBittorrent 运行在本地 Mac、群晖（Synology DSM）、威联通（QNAP）、Unraid、TrueNAS、Docker 容器还是云端 VPS / Seedbox，只需配置 WebUI 地址（支持内网 IP、域名与 HTTPS 反向代理）即可无缝秒级同步。
- 📌 **关键任务菜单栏图钉置顶**：点击卡片右上角图钉，将正在下载的关键种子进度百分比直接固定在屏幕顶部的系统状态栏（例如：`↓ 12.0 MB/s 85%`），无需切出窗口。
- ⚡️ **无感低功耗后台常驻**：基于 Swift 6 编译型原生代码开发，相较于臃肿的 Electron 包装器或常开浏览器标签页，日常静默运行 CPU 占用接近 0.0%，内存仅占用 ~35-45 MB，完全不损耗电池续航。
- 🐢 **会议与游戏一键限速**：顶部快捷面板一键暂停所有任务、一键恢复，或快速开启备用限速（🐢 小乌龟模式），开会打游戏不再被下载抢占带宽。
- 📋 **磁力与种子智能捕获**：自动识别系统剪贴板中的 `magnet:` 磁力链接或 HTTP 种子链接，并支持上传本地 `.torrent` 文件在下载前预览内部文件目录。

---

## 📸 界面预览与实机效果

<p align="center">
  <img src="docs/images/preview_popover.png" alt="QBMenubar Liquid Glass 主弹窗、动态带宽波形图与种子列表" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="QBMenubar macOS 系统设置风格偏好设置窗口" width="480" />
</p>

<p align="center">
  <img src="docs/images/preview_widgets_showcase.png" alt="QBMenubar macOS 桌面与通知中心小组件" width="650" />
</p>
<p align="center">
  <img src="docs/images/preview_settings_widgets.png" alt="QBMenubar 小组件设置与跨应用数据权限说明" width="580" />
</p>

---

## 📊 深度对比：为什么选择 QBMenubar？

| 功能维度 | QBMenubar (原生) | 浏览器 WebUI 网页 | 官方 Qt 客户端 | Python / SwiftBar 脚本插件 |
|---|:---:|:---:|:---:|:---:|
| **状态栏常驻与交互** | ✅ 原生 Liquid Glass 弹窗 | ❌ 仅限网页窗口 | ❌ 仅限 Dock / 独立主窗 | ⚠️ 纯文本下拉菜单（无交互卡片） |
| **菜单栏图钉任务进度** | ✅ 状态栏黑白单色徽章直显 | ❌ | ❌ | ❌ |
| **实时动态带宽波形图** | ✅ Swift Charts 平滑物理波形 | ⚠️ 静态刷新折线 | ⚠️ 简易折线 | ❌ |
| **内存占用** | 🟢 **~35 - 45 MB** | 🔴 300 MB - 1 GB+ | 🟡 150 MB - 300 MB | 🟢 ~30 MB |
| **后台空闲 CPU** | 🟢 **< 0.1%** | 🟡 1% - 5% | 🟡 1% - 3% | 🟡 1% - 2% |
| **远程 NAS / Docker 连接** | ✅ 本地、内网 NAS 与域名反代 | ✅ | ❌ 仅支持本机守护进程 | ⚠️ 鉴权与反代支持有限 |
| **交互式文件树穿透展开** | ✅ 原生卡片层级展开与单文件进度 | ⚠️ 复杂表格多次点击 | ⚠️ 密集表格 | ❌ |
| **桌面与通知中心小组件 (WidgetKit)** | ✅ 支持小/中/大三种尺寸 | ❌ | ❌ | ❌ |
| **macOS 系统通知推送** | ✅ 任务下载完成原生通知 | ⚠️ 需浏览器权限常驻 | ⚠️ 旧式弹窗 | ❌ |

---

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
   - 内置**连通性测试器**：一键探测延迟（Ping）与 qBittorrent 服务端版本。
   - 支持 macOS 原生系统通知（任务开始下载与下载完成提醒）。
   - 完整 9 种语言本地化支持（简体中文、繁體中文、English、日本語、한국어、Deutsch、Français、Español、Русский）。
5. **macOS 桌面与通知中心小组件 (WidgetKit)**：
   - **小号组件 (.systemSmall)**：单任务焦点进度卡片，直观显示最活跃任务进度条、当前速度与剩余时间 (ETA)。
   - **中号组件 (.systemMedium)**：双栏布局，左侧显示全局实时上传下载带宽与任务计数，右侧列出前 2-3 个活跃下载任务进度。
   - **大号组件 (.systemLarge)**：全功能任务看板，包含多任务进度、状态标签、传输统计与一键跳转。
   - **零开销 App Group 共享存储**：主应用与小组件进程间极速低耗同步。
   - 完美适配 macOS 全彩、深色以及着色/高亮模式 (`widgetAccentable`)。

### 🧩 桌面小组件与系统权限指南

QBMenubar 原生支持 macOS 桌面与通知中心小组件（提供 Small、Medium、Large 三种尺寸）。主程序与小组件之间通过高效的本地快照进行数据同步：

1. **在设置中启用**：点击菜单栏图标打开「偏好设置」(**⌘,**) -> 进入「**小组件**」标签页 -> 开启「**启用桌面小组件同步**」。
2. **macOS「其他 App 的数据」系统权限说明**：
   - **为什么会出现系统弹窗**：在 macOS 15 (Sequoia) 和 macOS 26 (Tahoe) 中，菜单栏主程序与沙盒化的小组件扩展（WidgetKit Extension）属于独立进程，需通过苹果标准的 App Group 共享目录（`~/Library/Group Containers/`）传递任务进度。由于开源项目采用本地自签名（未附加每年 $99 的苹果商业开发者 Team ID 配置文件），macOS 会自动将该跨进程共享目录标记为「其他 App 的数据」，并弹出警告：*“QBMenubar 尝试访问来自其他 App 的数据并已被阻止”*。
   - **🔒 零隐私风险承诺**：QBMenubar **仅**在共享目录中读写自身的 `widget_snapshot.json` 快照（仅包含当前任务名称、上下行速度及进度百分比），**绝不扫描或读取您的任何个人隐私文件或其他软件数据**。
   - **如何授权或恢复权限**：
     - **系统设置授权**：在「偏好设置 -> 小组件」页面中，点击「**打开完全磁盘访问权限设置**」（或前往「系统设置 > 隐私与安全性 > 完全磁盘访问权限」），点击下方的「`+`」号添加 `/Applications/QBMenubar.app` 并开启开关即可。
     - **终端一键重置**：若此前误点了拒绝且需要重置权限，只需在终端中运行：
       ```bash
       tccutil reset All com.antigravity.QBMenubar
       ```
   - **注意事项**：桌面小组件必须获得该数据共享权限才能实时更新；若未授权，小组件将显示「需数据访问权限」状态。**即使不授予该权限，菜单栏的所有监控、控制、磁力链接抓取等核心功能依然 100% 正常运行，完全不受影响。**
3. **如何将小组件添加到桌面**：
   - 在 macOS 桌面任意空白处**右键单击** -> 选择「**编辑小组件...**」（或点击屏幕右上角时间呼出通知中心，滑到最底部点击「编辑小组件」）。
   - 在左侧应用列表找到 **`QBMenubar`**（或在上方搜索框搜索 **`QBMenubar`** / **`qBittorrent`**）。
   - 点击或直接拖拽 **Small（小）**、**Medium（中）**、**Large（大）** 组件至桌面或通知中心即可！

---

### 🚀 v1.3.2 更新亮点
- **原生 WidgetKit 扩展入口点适配**：链接器正式补齐 `_NSExtensionMain` 符号入口，使系统 `chronod` 与通知中心能够稳定拉起插件并预载 Small、Medium、Large 桌面小组件占位图与描述符。
- **简化「完全磁盘访问权限」授权流程**：彻底精简小组件权限配置，直通 macOS 完全磁盘访问权限，消除冗余按钮，修复卡片边框溢出与文字截断问题。
- **单应用包生命周期优化**：清理多余的构建注销与 LaunchServices 缓存冲突，确保系统小组件库即时感知与更新。

---

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

## ⚙️ 首次使用配置步骤（1 分钟快速上手）

1. **启用 qBittorrent WebUI**：
   - 打开您的 qBittorrent（本地、NAS 或服务器均可）；
   - 进入 **设置 (Preferences) -> Web UI**，勾选 **Web 用户界面 (远程控制)**；
   - 默认端口一般为 `8080`，默认本地地址通常为 `http://127.0.0.1:8080`。
2. **连接 QBMenubar**：
   - 点击 macOS 屏幕右上角菜单栏的 QBMenubar 图标；
   - 点击面板右上角的齿轮图标 (**⚙️**) 打开偏好设置；
   - 填入您的 WebUI 地址、用户名和密码，点击 **测试连接**；
   - 状态栏立即开始实时显示下载与上传速率！

---

## 🏷️ 搜索关键词与索引标签 (Keywords)
`qbittorrent` • `qbittorrent-controller` • `qbittorrent-webui` • `qbittorrent-client` • `macos-menubar` • `menubar-app` • `menubar-extra` • `swiftui` • `swift6` • `liquid-glass` • `torrent-client` • `torrent-manager` • `bittorrent` • `nas` • `synology` • `unraid` • `truenas` • `docker`

---

## 📄 开源许可协议
本项目采用 [MIT License](LICENSE) 授权开源。
