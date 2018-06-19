//
//  NotificationService.swift
//  artify-core
//
//  Created by Nghia Tran on 6/19/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import NotificationCenter

protocol NotificationServiceType {

    func push(_ action: PushContent)
}

// MARK: - NotificationService
final class NotificationService: NSObject, NotificationServiceType {

    // MARK: - Variable
    private let center: NSUserNotificationCenter

    // MARK: - Init
    override init() {
        self.center = NSUserNotificationCenter.default
        super.init()
        center.delegate = self
    }

    func push(_ action: PushContent) {
        let payload = action.build()
        center.deliver(payload)
    }
}

// MARK: - NSUserNotificationCenterDelegate
extension NotificationService: NSUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: NSUserNotificationCenter,
                                       shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }

    public func userNotificationCenter(_ center: NSUserNotificationCenter,
                                       didActivate notification: NSUserNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let type = userInfo["type"] as? PushActionType else { return }

        switch type {
        case .openURL:
            guard let urlPath = userInfo["url"] as? String else { return }
            let url = URL(string: urlPath)!
            NSWorkspace.shared.open(url)
        default:
            break
        }
    }
}
