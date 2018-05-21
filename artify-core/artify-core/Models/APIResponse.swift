//
//  APIResponse.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Unbox

struct Key {
    static let Code = "code"
    static let Message = "message"
    static let Data = "data"
}

struct APIResponse<T: Unboxable>: Unboxable {

    // MARK: - Variable
    let code: Int
    let message: String
    let data: T

    // MARK: - Init
    init(unboxer: Unboxer) throws {
        self.code = try unboxer.unbox(key: Key.Code)
        self.message = try unboxer.unbox(key: Key.Message)
        self.data = try unboxer.unbox(key: Key.Data)
    }
}
