//
//  GaussianData.swift
//  artify-core
//
//  Created by Nghia Tran on 5/29/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

class GaussianData: DataGenerationType {

    let screenSize: CGSize
    let originalImage: NSImage

    private let ratio: CGFloat = 14.0 / 255.0
    var perfectSize: NSSize {
        return CGSize(width: ratio * screenSize.width,
                      height: ratio * screenSize.height)
    }

    init(screenSize: CGSize, originalImage: NSImage) {
        self.screenSize = screenSize
        self.originalImage = originalImage
    }
}
