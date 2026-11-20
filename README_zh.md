# QBMenubar - 原生 macOS qBittorrent 状态栏控制中心

<p align="center">
  <a href="README.md">English</a> | <b>简体中文</b>
</p>

一款基于 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 构建的轻量级、高性能 macOS 原生状态栏应用。融合 **Liquid Glass 液态玻璃材质** 视觉设计与 **Apple Motion Feel 原生物理弹簧手感**，让您在 macOS 菜单栏中随时随地监控与管理 qBittorrent 下载任务。

<p align="center">
  <img src="docs/images/preview_menubar.png" alt="菜单栏状态项效果预览" width="650" />
</p>

---

## 界面预览与实机效果

<p align="center">
  <img src="docs/images/preview_popover.png" alt="主弹窗界面预览" width="380" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="docs/images/preview_settings.png" alt="偏好设置窗口预览" width="480" />
</p>

---

## 核心特性

1. **状态栏常驻与动态监控**：
   - 实时上传 / 下载速率与动态方向图标。
   - 专属任务完成度百分比直显（如 `↓ 12.0 MB/s 85%`）。
   - 文本宽度自动扩展，彻底消除 AppKit 菜单栏文字裁切。
2. **Liquid Glass 现代毛玻璃主弹窗**：
   - 遵循 macOS 液态材质设计，适配深色与浅色外观。
   - **实时动态带宽波形图**（Swift Charts），平滑呈现流量起伏。
   - 顶部快捷操作栏：暂停全部、全部继续、备用限速（🐢 小乌龟）、一键直达 WebUI。
   - 纯净分类过滤标签（全部、下载中、做种中、已暂停）。
   - **➕ 本地种子上传**：支持解析 `.torrent` 文件，在添加前预览内部文件清单、体积并自定义保存路径。
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

---

## 快速上手与下载

### 1. 直接下载运行包（推荐，开箱即用）
无需安装 Xcode 或终端环境，直接下载预编译好的 macOS 原生应用包：

👉 **[下载最新版 QBMenubar v1.0.0 (macOS)](https://github.com/133hou/QBMenubar/releases/download/v1.0.0/QBMenubar-v1.0.0-macOS.zip)**

- 下载后双击解压出 `QBMenubar.app`；
- 将其拖拽至访达的 **「应用程序 (/Applications)」** 文件夹中；
- 双击即可直接运行！应用将静默常驻在屏幕顶部的系统菜单栏。

### 2. 源码本地编译 (Build from Source)
如果您希望自行修改代码或本地编译：
```bash
cd QBMenubar
swift build -c release
./build_app.sh
```

---

## 许可证
本项目采用 [MIT License](LICENSE) 授权开源。
