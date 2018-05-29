//
//  NSImage+Extenstion.swift
//  artify-core
//
//  Created by Nghia Tran on 5/29/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

extension NSImage {

    var pixelSize: CGSize {
        let imageRep = representations.first!
        return CGSize(width: imageRep.pixelsWide, height: imageRep.pixelsHigh)
    }

    var pointSize: CGSize {
        let size = pixelSize
        return CGSize(width: size.width / 2.0, height: size.height / 2.0)
    }
}
