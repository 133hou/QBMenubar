import SwiftUI
import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if CommandLine.arguments.contains("--snapshot"),
           let idx = CommandLine.arguments.firstIndex(of: "--snapshot"),
           idx + 1 < CommandLine.arguments.count {
            let outDir = CommandLine.arguments[idx + 1]
            SnapshotGenerator.generateSnapshots(outputDir: outDir)
            exit(0)
        }
        // Run purely as an accessory app without appearing in the Dock
        NSApplication.shared.setActivationPolicy(.accessory)
        // Initialize notifications delegate and request user authorization
        NotificationManager.shared.requestAuthorization()
    }
}

@main
struct QBMenubarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var viewModel = QBMenubarViewModel()

    var body: some Scene {
        MenuBarExtra {
            PopoverContentView(viewModel: viewModel)
        } label: {
            MenuBarHeaderView(viewModel: viewModel)
        }
        .menuBarExtraStyle(.window)
    }
}
