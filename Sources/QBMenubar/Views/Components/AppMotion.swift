import SwiftUI

/// Unified Apple Motion Design System conforming to native Apple platform guidelines (apple-motion-feel).
/// Eliminates unnatural bounce on tap-driven interactions, ensures consistent timing across components,
/// and respects the macOS Accessibility Reduce Motion setting.
public enum AppMotion {
    /// Tap-driven selection (Tab bar filter pills, segmented controls):
    /// Critically damped (damping: 1.0, bounce: 0.0) for brisk, responsive feedback without wobble.
    public static let selection: Animation = .snappy(duration: 0.28, extraBounce: 0.0)

    /// Drawer / card expand & collapse (Torrent internal files list):
    /// Smooth critically damped expansion that glides open without bouncing lower content.
    public static let expand: Animation = .smooth(duration: 0.32)

    /// Continuous live data flow (Progress bar updates, bandwidth waveform updates):
    /// Smooth forward interpolation that never oscillates backward or jitters.
    public static let liveData: Animation = .smooth(duration: 0.35)

    /// Quick micro-interactions (Status badges, icon rotation, button feedback):
    /// Brisk, instantaneous response.
    public static let micro: Animation = .snappy(duration: 0.22, extraBounce: 0.0)

    /// Accessibility-aware animation resolver: substitutes motion with a clean,
    /// shortened crossfade when Accessibility "Reduce Motion" is enabled in System Settings.
    public static func resolve(_ standard: Animation, reduceMotion: Bool) -> Animation {
        if reduceMotion {
            return .easeInOut(duration: 0.15)
        }
        return standard
    }
}
