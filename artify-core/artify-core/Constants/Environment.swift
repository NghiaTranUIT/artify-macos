//
//  Environment.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

public struct Environment {

    public enum Kind {
        case sandbox
        case production
    }

    // MARK: - Variable
    let kind: Kind
    var baseURL: String {
        switch kind {
        case .sandbox:
            return "http://0.0.0.0:7300"
        case .production:
            return "https://www.megaton.xzy"
        }
    }
}
