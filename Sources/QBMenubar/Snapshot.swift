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
            state: "downloading",
            completed: 4_430_400_000
        )
        
        let mockTorrent2 = Torrent(
            hash: "22222222222222222222",
            name: "Debian-12.5.0-netinst.iso",
            size: 650_000_000,
            progress: 0.325,
            dlspeed: 2_097_152,
            upspeed: 128_000,
            eta: 45,
            state: "downloading",
            completed: 211_250_000
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
            ratio: 2.45,
            completed: 900_000_000
        )

        let mockTorrent4 = Torrent(
            hash: "44444444444444444444",
            name: "Fedora-Workstation-Live-40.iso",
            size: 2_400_000_000,
            progress: 0.540,
            dlspeed: 0,
            upspeed: 0,
            eta: -1,
            state: "pausedDL",
            completed: 1_296_000_000
        )
        
        viewModel.torrents = [mockTorrent1, mockTorrent2, mockTorrent3, mockTorrent4]
        viewModel.config.pinnedTorrentHash = "11111111111111111111"
        viewModel.config.showPinnedProgress = true
        
        // 1. Snapshot MenuBarHeaderView (Authentic macOS translucent menu bar with ambient backlight)
        let menubarPresentation = ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.11, blue: 0.17),
                    Color(red: 0.13, green: 0.16, blue: 0.25),
                    Color(red: 0.07, green: 0.10, blue: 0.15)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay {
                Circle()
                    .fill(Color.blue.opacity(0.35))
                    .frame(width: 260, height: 260)
                    .blur(radius: 50)
                    .offset(x: 180, y: -20)
            }
            
            HStack(spacing: 14) {
                HStack(spacing: 12) {
                    Text("")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                    Text("Finder")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.white)
                    Text("File")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.85))
                    Text("Edit")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.85))
                    Text("View")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.85))
                }
                
                Spacer()
                
                // QBMenubar Status Item (Live speed + Pinned torrent progress)
                MenuBarHeaderView(viewModel: viewModel)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.white.opacity(0.18))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .strokeBorder(Color.white.opacity(0.22), lineWidth: 0.5)
                    )
                
                HStack(spacing: 11) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                    Image(systemName: "switch.2")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                    Image(systemName: "wifi")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                    Image(systemName: "battery.100")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                    Text("13:38")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .padding(.horizontal, 18)
            .frame(width: 820, height: 36)
            .background(.ultraThinMaterial.opacity(0.85))
            .overlay(alignment: .bottom) {
                Divider().opacity(0.2)
            }
        }
        .frame(width: 820, height: 36)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(Color.white.opacity(0.12), lineWidth: 0.5)
        )
        
        saveView(menubarPresentation, width: 820, height: 36, to: "\(outputDir)/preview_menubar.png")
        
        // 2. Snapshot SettingsWindowView
        let settingsView = SettingsWindowView(viewModel: viewModel)
            .frame(width: 780, height: 560)
        saveView(settingsView, width: 780, height: 560, to: "\(outputDir)/preview_settings.png")
        
        // 3. Snapshot PopoverContentView over macOS ambient backdrop to showcase Liquid Glass refraction
        let popoverPresentation = ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.08, green: 0.11, blue: 0.16),
                    Color(red: 0.12, green: 0.15, blue: 0.22),
                    Color(red: 0.06, green: 0.08, blue: 0.12)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .overlay {
                Circle()
                    .fill(Color.blue.opacity(0.28))
                    .frame(width: 300, height: 300)
                    .blur(radius: 70)
                    .offset(x: -90, y: -120)

                Circle()
                    .fill(Color.teal.opacity(0.22))
                    .frame(width: 260, height: 260)
                    .blur(radius: 60)
                    .offset(x: 90, y: 140)
            }

            PopoverContentView(viewModel: viewModel)
                .frame(width: 380, height: 550)
                .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.14), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.5), radius: 22, x: 0, y: 12)
        }
        .frame(width: 440, height: 610)
        
        saveView(popoverPresentation, width: 440, height: 610, to: "\(outputDir)/preview_popover.png")
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
