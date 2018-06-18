//
//  Image+AutoEnchance.swift
//  artify-core
//
//  Created by Nghia Tran on 6/18/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import CoreImage

extension NSImage {

    func autoEnchance() -> NSImage {
        guard let data = self.tiffRepresentation else {
            return self
        }
        var ciImage = CIImage(data: data)
        let options: [String: Any] = [kCIImageAutoAdjustRedEye: false,
                                      kCIImageAutoAdjustEnhance: true]
        guard let adjustments = ciImage?.autoAdjustmentFilters(options: options) else {
            return self
        }
        for filter in adjustments {
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            ciImage = filter.outputImage!
        }
        return ciImage!.toNSImage()
    }
}

extension CIImage {

    func toNSImage() -> NSImage {
        let ref = NSCIImageRep(ciImage: self)
        let image = NSImage(size: ref.size)
        image.addRepresentation(ref)
        return image
    }
}
