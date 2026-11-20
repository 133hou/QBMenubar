# QBMenubar - 原生 macOS qBittorrent 状态栏控制中心

基于 **Swift 6 + SwiftUI + MenuBarExtra (.window)** 构建的独立 macOS 状态栏应用，融合 **Liquid Glass 液态玻璃材质** 与 **Apple Motion Feel 原生物理弹簧手感**，全面支持自定义 WebUI API。

---

## 核心特性

1. **状态栏常驻与动态监控**：
   - 实时上传/下载速率与动态 SF Symbols 图标。
   - 备用限速模式指示（小乌龟 🐢）。
   - 连接状态颜色提示（🟢 正常、🟡 连接中、🔴 离线）。
2. **Liquid Glass 现代毛玻璃浮窗**：
   - 遵循 `liquid-glass` 规范，高通透度材质分层与微阴影，适配 macOS 深浅色外观。
   - **实时动态带宽波形图**（Swift Charts），清晰展示流量起伏。
3. **种子任务卡片 & 文件穿透展开**：
   - 任务名、状态标签、平滑渐变进度条、ETA 预估时间、种子与节点数。
   - **点击卡片流畅展开内部文件列表**：直观展示每一个文件的扩展名专属图标、名称、体积与独立下载进度。
   - 原生弹簧动画（`apple-motion-feel` 物理曲线），杜绝机械线性过渡。
4. **便捷控制功能**：
   - 📋 **从剪贴板添加**：一键识别剪贴板中的磁力链接（`magnet:`）或 HTTP/HTTPS 种子链接并提交。
   - ⏸️ / ▶️ 单任务或一键全部暂停/恢复。
   - 🐢 备用限速一键切换。
   - 📂 本地下载目录一键 Finder 定位。
   - 🔄 种子哈希完整性重新校验。
   - 🗑️ 支持普通删除与连同本地文件彻底删除。
5. **完整的自定义 API 配置**：
   - 可自定义 **服务器地址**（支持本地 `http://127.0.0.1:8080`、局域网 NAS、远程 VPS 或 HTTPS 反向代理）。
   - 可自定义 **API 路径前缀**（如 `/api/v2`，支持子路径如 `/qbittorrent/api/v2`）。
   - 可自定义 **用户名、密码**，支持本地跳过身份验证开关。
   - 可调节 **后台轮询频率**（1.0s ~ 10.0s）与 **图表历史时长**。
   - **在线连接测试器**：点击“测试连接”立即探测延迟（Ping）与 qBittorrent 服务端版本。

---

## 运行与使用

### 直接运行 App
应用已编译打包为标准的 macOS App Bundle：
[`/Users/Shared/QBittorrent/QBMenubar/QBMenubar.app`](file:///Users/Shared/QBittorrent/QBMenubar/QBMenubar.app)

您可以直接双击运行，或在终端通过 `open` 启动：
```bash
open /Users/Shared/QBittorrent/QBMenubar/QBMenubar.app
```
*(应用设置了 `LSUIElement = true`，启动后仅静默常驻在屏幕顶部的状态栏，不占用 Dock 栏)*

### 自定义配置 API
1. 启动应用后，点击状态栏图标打开弹窗；
2. 点击右上角的 **⚙️ (齿轮)** 图标打开「API 与服务配置」面板；
3. 输入您的 qBittorrent 地址、端口、路径和密码；
4. 点击 **“测试连接”** 验证连通性，点击 **“保存配置”** 立即生效！

---

## 重新构建 (Build)

如需修改代码后重新编译打包：
```bash
cd /Users/Shared/QBittorrent/QBMenubar
./build_app.sh
```
即可自动生成最新的 Release 版本 `QBMenubar.app`。
