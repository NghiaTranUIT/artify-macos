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
import RxOptional
import Nuke
import RxNuke

final class ScreenshotService {

    // MARK: - Variable
    private let network: NetworkingServiceType
    private let fileHandler: FileHandler
    private let bag = DisposeBag()
    private let currentPhoto = Variable<Photo?>(nil)
    private let currentScreenshot = Variable<NSImage?>(nil)
    private let setWallpaperPublisher = PublishSubject<URL>()

    // MARK: - Public
    lazy var getFeaturePhotoAction: Action<Void, Photo> = {
        return Action<Void, Photo> {
            return self.network.provider
                .rx
                .request(.getFeature)
                .mapToModel(type: Photo.self)
        }
    }()

    // MARK: - Init
    init(network: NetworkingServiceType, fileHandler: FileHandler) {
        self.network = network
        self.fileHandler = fileHandler

        // Bind to current screenshot
        getFeaturePhotoAction
            .elements
            .bind(to: currentPhoto)
            .disposed(by: bag)

        // Log
        currentPhoto.asObservable()
            .filterNil()
            .subscribe(onNext: { (photo) in
                print("==== Photo = \(photo)")
            })
            .disposed(by: bag)

        // Download
        currentPhoto.asObservable()
            .filterNil()
            .map { ImageRequest(url: URL(string: $0.imageURL)!)}
            .flatMapLatest { (request) -> Single<ImageResponse> in
                return ImagePipeline.shared.loadImage(with: request)
            }
            .map { $0.image }
            .bind(to: currentScreenshot)
            .disposed(by: bag)

        // Map to current workspace
        currentScreenshot.asObservable()
            .filterNil()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
            .flatMapLatest { (image) -> Observable<URL> in
                return self.fileHandler.rx_saveImageIfNeed(image, name: "1")
            }
            .subscribe(onNext: { (path) in
                self.setWallpaperPublisher.onNext(path)
            })
            .disposed(by: bag)

        // Set wallpaper in current workspace
        setWallpaperPublisher.asObserver()
            .subscribe(onNext: { (path) in
                NSScreen.screens.forEach {
                    try? NSWorkspace.shared.setDesktopImageURL(path, for: $0, options: [:])
                }
            })
            .disposed(by: bag)


    }
}
