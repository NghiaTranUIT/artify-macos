//
//  CGSize+String.swift
//  artify-core
//
//  Created by Nghia Tran on 6/1/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

extension CGSize {

    var toString: String {
        return "\(Int(self.width))_\(Int(self.height))"
    }
}
