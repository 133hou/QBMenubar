import AppKit
import SwiftUI

@MainActor
public final class AddTorrentWindowController: NSObject, NSWindowDelegate {
    public static let shared = AddTorrentWindowController()

    private var window: NSWindow?

    public func show(viewModel: QBMenubarViewModel, initialFileURL: URL? = nil, autoPick: Bool = false) {
        if let existing = window {
            existing.title = L10n.addTorrentWindowTitle(viewModel.config.language)
            existing.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let contentView = AddTorrentView(viewModel: viewModel, initialFileURL: initialFileURL)
        let hostingView = NSHostingView(rootView: contentView)

        let newWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 580, height: 520),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        newWindow.title = L10n.addTorrentWindowTitle(viewModel.config.language)
        newWindow.isReleasedWhenClosed = false
        newWindow.contentView = hostingView
        newWindow.center()
        newWindow.delegate = self

        self.window = newWindow
        newWindow.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    public func close() {
        window?.close()
        window = nil
    }

    public func windowWillClose(_ notification: Notification) {
        window = nil
    }
}
