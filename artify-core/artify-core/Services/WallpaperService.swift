//
//  WallpaperService.swift
//  artify-core
//
//  Created by Nghia Tran on 5/28/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol WallpaperServiceType {

    var setFeaturePhotoAction: Action<Void, Photo> { get }
    var randomizePhotoAction: Action<Void, Photo> { get }
}

final class WallpaperService: WallpaperServiceType {

    // MARK: - Variable
    private let notificationService: NotificationServiceType
    private let currentScreen = NSScreen.main!
    private var screenSize: CGSize { return currentScreen.frame.size }
    private let fileHandler: FileHandler
    private let processor: ProcessorType = WallpaperProcessor()
    private let downloadService: DownloadServiceType
    private let bag = DisposeBag()

    // MARK: - Init
    init(downloadService: DownloadServiceType, fileHandler: FileHandler, notificationService: NotificationServiceType) {
        self.downloadService = downloadService
        self.fileHandler = fileHandler
        self.notificationService = notificationService
    }

    // MARK: - Public
    lazy var setFeaturePhotoAction: Action<Void, Photo> = {
        return Action<Void, Photo> { (_) -> Observable<Photo> in
            return self.downloadService
                .downloadFeaturePhoto()
                .flatMapLatest {[unowned self] in self.processDownloadPayload($0) }
        }
    }()

    lazy var randomizePhotoAction: Action<Void, Photo> = {
        return Action<Void, Photo> { (_) -> Observable<Photo> in
            return self.downloadService
                .downloadRandomPhoto()
                .flatMapLatest {[unowned self] in self.processDownloadPayload($0) }
        }
    }()

    private func processDownloadPayload(_ payload: DownloadPayload) -> Observable<Photo> {
        return Observable.just(payload)
            .flatMapLatest({[unowned self] (payload) -> Observable<WallpaperResponse> in
                guard let image = NSImage(contentsOfFile: payload.fileUrl.path) else {
                    return .error(ArtfiyError.invalidFileURL(payload.fileUrl))
                }
                let processPayload = WallpaperPayload(photo: payload.photo,
                                                      originalImage: image,
                                                      screenSize: self.screenSize,
                                                      effect: .gaussianBeautify)
                return self.processor.rx_apply(payload: processPayload)
            })
            .flatMapLatest({[unowned self] (payload) -> Observable<(Photo, URL)> in
                let filePayload = FilePayload(image: payload.wallpaperImage,
                                              photo: payload.photo,
                                              prefix: self.screenSize.toString)
                TrackingService.default.tracking(.setWallapper(SetWallpaperParam(photo: payload.photo, screenSize: self.screenSize)))
                return self.fileHandler.rx_saveImageIfNeed(filePayload)
                    .map { return (payload.photo, $0) }
            })
            .observeOn(MainScheduler.instance)
            .do(onNext: { tub in
                print("✅[SUCCESS] Set Wallpaper at \(tub.1)")
            }, onError: { error in
                print("❌[ERROR] \(error)")
            })
            .flatMapLatest({[unowned self] (tub) -> Observable<Photo> in
                return self.setWallpaper(at: tub)
            })
    }

    private func setWallpaper(at payload: (Photo, URL)) -> Observable<Photo> {
        var isApplied = false

        // Apply Wallpaper
        NSScreen.screens.forEach {
            if let url = NSWorkspace.shared.desktopImageURL(for: $0),
                url.absoluteString != payload.1.absoluteString {
                isApplied = true
                try? NSWorkspace.shared.setDesktopImageURL(payload.1, for: $0, options: [:])
            }
        }

        // Push
        if isApplied {
            self.notificationService.push(SetWallpaperPush(photo: payload.0))
        }

        //
        return Observable.just(payload.0)
    }
}

