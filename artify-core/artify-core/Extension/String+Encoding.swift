//
//  String+Encoding.swift
//  artify-core
//
//  Created by Nghia Tran on 5/28/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

extension String {

    func toBase64() -> String? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.base64EncodedString()
    }
}
