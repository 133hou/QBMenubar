import Foundation
@preconcurrency import UserNotifications
import AppKit

public final class NotificationManager: NSObject, UNUserNotificationCenterDelegate, @unchecked Sendable {
    public static let shared = NotificationManager()

    private override init() {
        super.init()
    }

    public func requestAuthorization() {
        guard Bundle.main.bundleIdentifier != nil else { return }
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
        }
    }

    public func checkAuthorizationStatus() async -> UNAuthorizationStatus {
        guard Bundle.main.bundleIdentifier != nil else { return .notDetermined }
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let settings = await center.notificationSettings()
        return settings.authorizationStatus
    }

    // Ensures banner notifications pop up even when the app is active and persist in Notification Center
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .list, .sound])
    }

    // When the user clicks the notification, reveal downloaded file/directory in Finder
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        if let savePath = userInfo["savePath"] as? String, !savePath.isEmpty {
            DispatchQueue.main.async {
                if FileManager.default.fileExists(atPath: savePath) {
                    NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: savePath)
                }
            }
        }
        completionHandler()
    }

    public func sendNotification(
        title: String,
        subtitle: String = "",
        body: String = "",
        savePath: String? = nil
    ) {
        guard Bundle.main.bundleIdentifier != nil else {
            print("NotificationManager: bundleIdentifier is nil, skipping notification: \(title)")
            return
        }
        let center = UNUserNotificationCenter.current()
        center.delegate = self

        let content = UNMutableNotificationContent()
        content.title = title
        if !subtitle.isEmpty {
            content.subtitle = subtitle
        }
        content.body = body
        content.sound = .default
        if let savePath = savePath {
            content.userInfo = ["savePath": savePath]
        }

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil // deliver immediately
        )

        center.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            center.delegate = self
            switch settings.authorizationStatus {
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        print("Notification authorization error: \(error)")
                    }
                    if granted {
                        center.add(request) { error in
                            if let error = error {
                                print("Failed to deliver notification after authorization: \(error)")
                            }
                        }
                    } else {
                        print("Notification authorization not granted by user.")
                    }
                }
            case .authorized, .provisional:
                center.add(request) { error in
                    if let error = error {
                        print("Failed to deliver notification: \(error)")
                    }
                }
            case .denied:
                print("Notification delivery skipped: notifications are denied in macOS System Settings.")
            @unknown default:
                center.add(request) { error in
                    if let error = error {
                        print("Failed to deliver notification (unknown status): \(error)")
                    }
                }
            }
        }
    }

    public func sendTestNotification(lang: AppLanguage) {
        let title = L10n.tr(
            lang,
            zhHans: "🔔 测试通知",
            zhHant: "🔔 測試通知",
            en: "🔔 Test Notification",
            ja: "🔔 テスト通知",
            ko: "🔔 테스트 알림",
            de: "🔔 Testbenachrichtigung",
            fr: "🔔 Notification de test",
            es: "🔔 Notificación de prueba",
            ru: "🔔 Тестовое уведомление"
        )
        let subtitle = "QBMenubar"
        let body = L10n.tr(
            lang,
            zhHans: "macOS 系统通知已成功启用与接收！",
            zhHant: "macOS 系統通知已成功啟用與接收！",
            en: "macOS system notifications are successfully enabled and received!",
            ja: "macOSのシステム通知が正常に有効化され、受信されました！",
            ko: "macOS 시스템 알림이 성공적으로 활성화되고 수신되었습니다!",
            de: "macOS-Systembenachrichtigungen wurden erfolgreich aktiviert und empfangen!",
            fr: "Les notifications système macOS sont activées et reçues avec succès !",
            es: "¡Las notificaciones del sistema de macOS están activadas y se reciben correctamente!",
            ru: "Системные уведомления macOS успешно включены и получены!"
        )
        sendNotification(
            title: title,
            subtitle: subtitle,
            body: body
        )
    }
}
