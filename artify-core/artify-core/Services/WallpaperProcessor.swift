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

    func apply(payload: WallpaperPayload) -> WallpaperResponse
}

struct WallpaperProcessor: ProcessorType {

    func apply(payload: WallpaperPayload) -> WallpaperResponse {
        switch payload.effect {
        case .gaussianBeautify:
            let data = GaussianData(screenSize: payload.screenSize, originalImage: payload.originalImage)
            let processedImage = GaussianAlgorithm().process(data: data)
            return WallpaperResponse(photo: payload.photo,
                                    screenSize: payload.screenSize,
                                    wallpaperImage: processedImage)
        }
    }
}

extension ProcessorType {

    func rx_apply(payload: WallpaperPayload) -> Observable<WallpaperResponse> {
        return Observable.create({ (observer) -> Disposable in
            let finalImage = self.apply(payload: payload)
            observer.onNext(finalImage)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
