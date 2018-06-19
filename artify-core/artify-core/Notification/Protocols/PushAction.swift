//
//  PushAction.swift
//  artify-core
//
//  Created by Nghia Tran on 6/19/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

enum PushActionType: String {

    // Close notification
    // Title = "Close"
    case close

    // Do another action
    // Example: Open certain URL
    case openURL
}

// MARK: - Push
protocol PushAction {

    // Type
    var type: PushActionType { get }

    // Title
    var title: String { get }

    // Deep-url
    var url: String { get }
}

extension PushAction {

    var userInfo: [String: Any] {
        return ["type": type.rawValue,
                "url": url]
    }
}
