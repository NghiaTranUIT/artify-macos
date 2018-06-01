//
//  AppInfo.swift
//  artify-core
//
//  Created by Nghia Tran on 5/31/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

struct AppInfo {

    static let current = AppInfo(bundleInfo: Bundle.main.infoDictionary!)
    
    let appVersion: String
    let buildNumber: String

    init(bundleInfo: [String: Any]) {
        appVersion = bundleInfo["CFBundleShortVersionString"] as! String
        buildNumber = bundleInfo["CFBundleVersion"] as! String
    }
}
