//
//  FabricTracker.swift
//  Artify
//
//  Created by Nghia Tran on 6/4/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Foundation
import artify_core
import Crashlytics

final class FabricTracker: Trackable {

    func tracking(_ type: TrackingService.Kind) {
        switch type {
        case .openApp:
            let attribute = Device.info
            Answers.logLogin(withMethod: type.methodName, success: NSNumber(booleanLiteral: true), customAttributes: attribute)
        case .exitApp:
            Answers.logCustomEvent(withName: type.methodName, customAttributes: nil)
        case .fetchFeaturePhoto(let param):
            Answers.logCustomEvent(withName: type.methodName, customAttributes: param.toAttribute())
        case .launchOnStartup(let param):
            Answers.logCustomEvent(withName: type.methodName, customAttributes: param.toAttribute())
        case .setWallapper(let param):
            Answers.logCustomEvent(withName: type.methodName, customAttributes: param.toAttribute())
        }
    }
}
