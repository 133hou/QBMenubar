import AppKit
import SwiftUI

@MainActor
public final class SettingsWindowController: NSObject, NSWindowDelegate {
    public static let shared = SettingsWindowController()

    private var window: NSWindow?

    public func show(viewModel: QBMenubarViewModel, category: SettingsCategory = .general) {
        if let existing = window {
            existing.title = L10n.settingsWindowTitle(viewModel.config.language)
            let contentView = SettingsWindowView(viewModel: viewModel, initialCategory: category)
            existing.contentView = NSHostingView(rootView: contentView)
            existing.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let contentView = SettingsWindowView(viewModel: viewModel, initialCategory: category)
        let hostingView = NSHostingView(rootView: contentView)

        let newWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 780, height: 560),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        newWindow.title = L10n.settingsWindowTitle(viewModel.config.language)
        newWindow.titleVisibility = .hidden
        newWindow.titlebarAppearsTransparent = true
        newWindow.toolbar = nil
        newWindow.isReleasedWhenClosed = false
        newWindow.isOpaque = false
        newWindow.backgroundColor = NSColor.windowBackgroundColor
        newWindow.contentView = hostingView
        newWindow.minSize = NSSize(width: 720, height: 480)
        newWindow.center()
        newWindow.delegate = self

        self.window = newWindow
        newWindow.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    public func windowWillClose(_ notification: Notification) {
        self.window = nil
    }
}
