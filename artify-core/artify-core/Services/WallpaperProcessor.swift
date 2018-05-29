//
//  WallpaperProcessor.swift
//  artify-core
//
//  Created by Nghia Tran on 5/29/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift

enum Effect {
    case gaussianBeautify
}

protocol ProcessorType {

    func apply(image: NSImage, screenSize: CGSize, with effect: Effect) -> NSImage
}

struct WallpaperProcessor: ProcessorType {

    func apply(image: NSImage, screenSize: CGSize, with effect: Effect) -> NSImage {
        switch effect {
        case .gaussianBeautify:
            let payload = GaussianData(screenSize: screenSize, originalImage: image)
            return GaussianAlgorithm().process(data: payload)
        }
    }
}

extension ProcessorType {

    func rx_apply(image: NSImage, screenSize: CGSize, with effect: Effect) -> Observable<NSImage> {
        return Observable.create({ (observer) -> Disposable in
            let finalImage = self.apply(image: image, screenSize: screenSize, with: effect)
            observer.onNext(finalImage)
            observer.onCompleted()
            return Disposables.create()
        })
    }

    func rx_apply(url: URL, screenSize: CGSize, with effect: Effect) -> Observable<NSImage> {
        return Observable.create({ (observer) -> Disposable in
            let image = NSImage(contentsOfFile: url.path)!
            let finalImage = self.apply(image: image, screenSize: screenSize, with: effect)
            observer.onNext(finalImage)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
