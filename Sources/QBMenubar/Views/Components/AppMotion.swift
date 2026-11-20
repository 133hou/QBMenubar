import SwiftUI

/// Unified Apple Motion Design System conforming to native Apple platform guidelines (apple-motion-feel).
/// Eliminates unnatural bounce on tap-driven interactions, ensures consistent timing across components,
/// and respects the macOS Accessibility Reduce Motion setting.
public enum AppMotion {
    /// Tap-driven selection (Tab bar filter pills, sidebar categories):
    /// Snappy spring with lively Apple elasticity.
    public static let selection: Animation = .spring(response: 0.30, dampingFraction: 0.78)

    /// Drawer / card expand & collapse (Torrent internal files list):
    /// Fluid spring expansion that glides open naturally.
    public static let expand: Animation = .spring(response: 0.32, dampingFraction: 0.82)

    /// Continuous live data flow (Progress bar updates, bandwidth waveform updates):
    /// Interactive spring for natural, fluid waveform dynamics.
    public static let liveData: Animation = .interactiveSpring(response: 0.30, dampingFraction: 0.80)

    /// Quick micro-interactions (Status badges, icon rotation, button feedback):
    /// Crisp, tactile spring.
    public static let micro: Animation = .spring(response: 0.25, dampingFraction: 0.75)

    /// Accessibility-aware animation resolver: substitutes motion with a clean,
    /// shortened crossfade when Accessibility "Reduce Motion" is enabled in System Settings.
    public static func resolve(_ standard: Animation, reduceMotion: Bool) -> Animation {
        if reduceMotion {
            return .easeInOut(duration: 0.15)
        }
        return standard
    }
}
