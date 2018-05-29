//
//  NSImage+Scale.swift
//  GaussionEffect
//
//  Created by Nghia Tran on 5/29/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Foundation
import Cocoa

// MARK: - Image Scaling.
extension NSImage {

    enum ScaleMode {
        case fillHeight(CGFloat)
        case fillWidth(CGFloat)
    }

    func scale(with mode: ScaleMode) -> NSImage {
        let originalSize = pixelSize

        // Calculate fill size
        let newSize: CGSize
        switch mode {
        case .fillWidth(let width):
            newSize = CGSize(width: width, height: width * originalSize.height / originalSize.width)
        case .fillHeight(let height):
            newSize = CGSize(width: height * originalSize.width / originalSize.height, height: height)
        }

        // Draw
        let image = NSImage(size: newSize)
        image.lockFocus()
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        image.unlockFocus()

        // Map to NSImage
        let data = image.tiffRepresentation!
        let newImage = NSImage(data: data)!
        return newImage
    }
}
