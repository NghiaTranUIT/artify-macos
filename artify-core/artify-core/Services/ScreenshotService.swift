//
//  ScreenshotService.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Cocoa
import Action
import Unbox

class ScreenshotService {

    // MARK: - Variable
    private let bag = DisposeBag()
    let currentScreenshot = Variable<Photo?>(nil)

    // MARK: - Public
    lazy var getFeaturePhotoAction: Action<Void, Photo> = {
        return Action<Void, Photo> {
            return Coordinator.default.networkingService.provider
                .rx
                .request(.getFeature)
                .mapToModel(type: Photo.self)
        }
    }()

    init() {

        // Bind to current screenshot
        getFeaturePhotoAction
            .elements
            .bind(to: currentScreenshot)
            .disposed(by: bag)
    }
}
