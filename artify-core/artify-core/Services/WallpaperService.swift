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

    var setFeaturePhotoAction: CocoaAction { get }
}

final class WallpaperService: WallpaperServiceType {

    // MARK: - Variable
    private let currentScreen = NSScreen.main!
    private var screenSize: CGSize { return currentScreen.frame.size }
    private let fileHandler: FileHandler
    private let processor: ProcessorType = WallpaperProcessor()
    private let downloadService: DownloadServiceType
    private let bag = DisposeBag()

    // MARK: - Init
    init(downloadService: DownloadServiceType, fileHandler: FileHandler) {
        self.downloadService = downloadService
        self.fileHandler = fileHandler
    }

    // MARK: - Public
    lazy var setFeaturePhotoAction: CocoaAction = {
        return CocoaAction {
            return Observable.just(())
                .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
                .flatMapLatest({[unowned self] _ -> Observable<DownloadPayload> in
                    return self.downloadService.downloadFeaturePhoto()
                })
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
                .flatMapLatest({[unowned self] (payload) -> Observable<URL> in
                    let filePayload = FilePayload(image: payload.wallpaperImage,
                                                  photo: payload.photo,
                                                  prefix: self.screenSize.toString)
                    return self.fileHandler.rx_saveImageIfNeed(filePayload)
                })
                .do(onNext: { url in
                    print("✅[SUCCESS] Set Wallpaper at \(url)")
                }, onError: { error in
                    print("❌[ERROR] \(error)")
                })
                .observeOn(MainScheduler.instance)
                .flatMapLatest({[unowned self] (path) -> Observable<Void> in
                    return self.setWallpaper(at: path)
                })
        }
    }()

    private func setWallpaper(at path: URL) -> Observable<Void> {
        NSScreen.screens.forEach {
            try? NSWorkspace.shared.setDesktopImageURL(path, for: $0, options: [:])
        }
        return Observable.just(())
    }
}
