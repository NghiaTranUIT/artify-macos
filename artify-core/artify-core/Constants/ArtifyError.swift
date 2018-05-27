//
//  ArtifyError.swift
//  artify-core
//
//  Created by Nghia Tran on 5/21/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

enum ArtfiyError: Error {

    case serializeError(Any)
    case saveImageError(String)
}

extension ArtfiyError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .serializeError(let obj):
            return "Can't serialize \(obj.self)"
        case .saveImageError(let path):
            return "Can't Save image \(path)"
        }
    }
}
