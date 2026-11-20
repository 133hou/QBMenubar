import SwiftUI
import AppKit

@MainActor
public struct SnapshotGenerator {
    public static func generateSnapshots(outputDir: String) {
        let viewModel = QBMenubarViewModel(isMock: true)
        viewModel.isMock = true
        viewModel.config.language = .en // Ensure UI renders in clean English

        // Mock realistic and clean data
        viewModel.connectionState = .connected(ping: 12)
        viewModel.transferInfo = TransferInfo(
            dlInfoSpeed: 12_582_912, // 12.0 MB/s
            upInfoSpeed: 1_258_291,  // 1.2 MB/s
            dlInfoData: 45_000_000_000,
            upInfoData: 12_000_000_000,
            connectionStatus: "connected",
            dhtNodes: 386
        )

        // Mock 20 points of speed history wave
        let now = Date()
        var mockPoints: [SpeedHistoryPoint] = []
        for i in 0..<25 {
            let t = now.addingTimeInterval(Double(i - 25) * 2)
            let dl = Int64((8.0 + sin(Double(i) * 0.5) * 4.0) * 1024 * 1024)
            let ul = Int64((1.0 + cos(Double(i) * 0.5) * 0.5) * 1024 * 1024)
            mockPoints.append(SpeedHistoryPoint(timestamp: t, downloadBytes: dl, uploadBytes: ul))
        }
        viewModel.speedHistory = mockPoints
        
        // Generic open-source Linux distributions for privacy
        let mockTorrent1 = Torrent(
            hash: "11111111111111111111",
            name: "Ubuntu-24.04-desktop-amd64.iso",
            size: 5_200_000_000,
            progress: 0.852,
            dlspeed: 10_485_760,
            upspeed: 512_000,
            eta: 134,
            state: "downloading"
        )
        
        let mockTorrent2 = Torrent(
            hash: "22222222222222222222",
            name: "Debian-12.5.0-netinst.iso",
            size: 650_000_000,
            progress: 0.325,
            dlspeed: 2_097_152,
            upspeed: 128_000,
            eta: 45,
            state: "downloading"
        )
        
        let mockTorrent3 = Torrent(
            hash: "33333333333333333333",
            name: "ArchLinux-2026.11-x86_64.iso",
            size: 900_000_000,
            progress: 1.0,
            dlspeed: 0,
            upspeed: 618_000,
            eta: 0,
            state: "uploading",
            ratio: 2.45
        )

        let mockTorrent4 = Torrent(
            hash: "44444444444444444444",
            name: "Fedora-Workstation-Live-40.iso",
            size: 2_400_000_000,
            progress: 0.540,
            dlspeed: 0,
            upspeed: 0,
            eta: -1,
            state: "pausedDL"
        )
        
        viewModel.torrents = [mockTorrent1, mockTorrent2, mockTorrent3, mockTorrent4]
        viewModel.config.pinnedTorrentHash = "11111111111111111111"
        viewModel.config.showPinnedProgress = true
        
        // 1. Snapshot MenuBarHeaderView (Simulating macOS menu bar dark glass)
        let menubarView = HStack(spacing: 12) {
            Text("").font(.system(size: 14)).foregroundStyle(.white)
            Text("Finder").font(.system(size: 13, weight: .semibold)).foregroundStyle(.white)
            Text("File").font(.system(size: 13)).foregroundStyle(.white.opacity(0.85))
            Text("Edit").font(.system(size: 13)).foregroundStyle(.white.opacity(0.85))
            Spacer()
            // Our QBMenubar Header
            MenuBarHeaderView(viewModel: viewModel)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.white.opacity(0.15))
                )
            Spacer().frame(width: 20)
            Image(systemName: "wifi").font(.system(size: 12)).foregroundStyle(.white)
            Image(systemName: "battery.100").font(.system(size: 12)).foregroundStyle(.white)
            Text("13:38").font(.system(size: 12, weight: .medium)).foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .frame(width: 700, height: 32)
        .background(
            LinearGradient(colors: [Color(red: 0.1, green: 0.12, blue: 0.16), Color(red: 0.15, green: 0.18, blue: 0.24)], startPoint: .leading, endPoint: .trailing)
        )
        
        saveView(menubarView, width: 700, height: 32, to: "\(outputDir)/preview_menubar.png")
        
        // 2. Snapshot SettingsWindowView
        let settingsView = SettingsWindowView(viewModel: viewModel)
            .frame(width: 780, height: 560)
        saveView(settingsView, width: 780, height: 560, to: "\(outputDir)/preview_settings.png")
        
        // 3. Snapshot PopoverContentView
        let popoverView = PopoverContentView(viewModel: viewModel)
            .frame(width: 380, height: 550)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
            .padding(10)
        saveView(popoverView, width: 400, height: 570, to: "\(outputDir)/preview_popover.png")
    }
    
    private static func saveView<V: View>(_ view: V, width: CGFloat, height: CGFloat, to path: String) {
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = NSRect(x: 0, y: 0, width: width, height: height)
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: width, height: height),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.isReleasedWhenClosed = false
        window.contentView = hostingView
        window.layoutIfNeeded()
        hostingView.layoutSubtreeIfNeeded()
        
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.2))
        
        let bounds = hostingView.bounds
        guard let rep = hostingView.bitmapImageRepForCachingDisplay(in: bounds) else {
            print("Failed to create bitmap rep for \(path)")
            return
        }
        hostingView.cacheDisplay(in: bounds, to: rep)
        if let png = rep.representation(using: .png, properties: [:]) {
            try? png.write(to: URL(fileURLWithPath: path))
            print("Saved screenshot to \(path) (\(png.count) bytes)")
        } else {
            print("Failed to save view to \(path)")
        }
    }
}
