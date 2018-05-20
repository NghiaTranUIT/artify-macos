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
        case quit
    }

    // MARK: - Variable
    public let kind: Menu.Kind
    public let keyEquivalent: String
    public var selector: Selector?

    public var title: String {
        switch kind {
        case .getFeature:
            return "Feature"
        case .quit:
            return "Quit"
        case .separator:
            return ""
        }
    }

    // MARK: - Init
    public init(kind: Menu.Kind, selector: Selector?, keyEquivalent: String) {
        self.kind = kind
        self.selector = selector
        self.keyEquivalent = keyEquivalent
    }
}
