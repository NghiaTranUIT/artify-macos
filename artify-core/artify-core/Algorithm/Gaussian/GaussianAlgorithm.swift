//
//  GaussianAlgorithm.swift
//  artify-core
//
//  Created by Nghia Tran on 5/28/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

struct GaussianAlgorithm: GenerationAlgorithm {

    func process(data: DataGenerationType) -> DataGenerationType {

        let scaleImage = scalePerfectImage(data: data)
        let backgroundImage = generateGaussianBackground(scaleImage, width: data.perfectSize.width)
        let artifyImage = drawArtify(image: scaleImage, backgroundImage: backgroundImage, size: data.screenSize)
        
        return GaussianData(screenSize: data.screenSize, originalImage: artifyImage)
    }
}

// MARK: - Private
extension GaussianAlgorithm {

    fileprivate func scalePerfectImage(data: DataGenerationType) -> NSImage {
        let height = data.perfectSize.height
        return data.originalImage.scale(with: .fillHeight(height))
    }

    fileprivate func generateGaussianBackground(_ image: NSImage, width: CGFloat) -> NSImage {
        let backgroundImage = image.scale(with: .fillWidth(width))
        return GaussianEffect.imageByApplyingLightEffect(to: backgroundImage)!
    }

    fileprivate func drawArtify(image: NSImage, backgroundImage: NSImage, size: CGSize) -> NSImage {

        let final = NSImage(size: size)
        final.lockFocus()

        // Background
        let backgroundOrigin = NSPoint.zero
        backgroundImage.draw(in: CGRect(origin: backgroundOrigin, size: size))

        // Prepare
        let imageOrigin = NSPoint(x: (size.width - image.pointSize.width) / 2,
                                  y: (size.height - image.pointSize.height) / 2)
        let imageRect = CGRect(origin: imageOrigin, size: image.pointSize)

        // Shadow
        let ctx = NSGraphicsContext.current!.cgContext
        ctx.saveGState()
        ctx.setShadow(offset: CGSize.zero, blur: 50.0, color: NSColor(white: 0.0, alpha: 0.4).cgColor)
        ctx.fill(imageRect)
        ctx.restoreGState()

        // Image
        image.draw(in: imageRect)

        // Release
        final.unlockFocus()

        // Get image
        let data = final.tiffRepresentation!
        let newImage = NSImage(data: data)!
        return newImage
    }
}
