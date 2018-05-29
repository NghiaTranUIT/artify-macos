//
//  GaussianAlgorithm.swift
//  artify-core
//
//  Created by Nghia Tran on 5/28/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

struct GaussianAlgorithm: GenerationAlgorithm {

    func process(data: DataGeneration) -> DataGeneration {

        let context = NSGraphicsContext.current!.graphicsPort

        return data
    }
}

// MARK: - Private
extension GaussianAlgorithm {

    fileprivate func initGaussianView(size: NSSize) -> NSVisualEffectView {
        let visualView = NSVisualEffectView(frame: NSRect(origin: CGPoint.zero, size: size))
        visualView.material = .mediumLight
        return visualView
    }
}
