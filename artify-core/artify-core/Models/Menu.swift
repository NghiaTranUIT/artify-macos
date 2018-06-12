//
//  Menu.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

public struct Menu {

    public enum Kind {
        case getFeature
        case separator
        case launchOnStartup
        case checkForUpdate
        case about
        case quit
    }

    // MARK: - Variable
    public let kind: Menu.Kind
    public let keyEquivalent: String
    public var selector: Selector?
    public let defaultState: NSControl.StateValue

    public var title: String {
        switch kind {
        case .getFeature:
            return "Feature"
        case .quit:
            return "Quit"
        case .launchOnStartup:
            return "Launch on Startup"
        case .separator:
            return ""
        case .checkForUpdate:
            return "Check for Updates..."
        case .about:
            return "About"
        }
    }

    // MARK: - Init
    public init(kind: Menu.Kind, selector: Selector?, keyEquivalent: String = "", defaultState: NSControl.StateValue = .off) {
        self.kind = kind
        self.selector = selector
        self.keyEquivalent = keyEquivalent
        self.defaultState = defaultState
    }
}
