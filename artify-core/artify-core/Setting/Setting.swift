//
//  Setting.swift
//  artify-core
//
//  Created by Nghia Tran on 6/2/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

public final class Setting {

    enum Kind: String {
        case startAppOnLaunch
    }

    // MARK: - Variable
    public static let shared = Setting()
    private let userDefault = UserDefaults.standard

    // Launch
    public var isLaunchOnStartup: Bool {
        get {
            return getValue(key: Kind.startAppOnLaunch.rawValue, type: Bool.self) ?? true
        }
        set {
            setValue(newValue, key: Kind.startAppOnLaunch.rawValue)
        }
    }
}

// MARK: - Storage
extension Setting {

    fileprivate func getValue<T>(key: String, type: T.Type) -> T? {
        return userDefault.value(forKey: key) as? T
    }

    fileprivate func setValue<T>(_ value: T, key: String) {
        userDefault.setValue(value, forKey: key)
    }
}
