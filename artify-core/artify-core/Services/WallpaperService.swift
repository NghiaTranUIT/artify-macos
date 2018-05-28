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
    private let downloadService: DownloadServiceType
    private let bag = DisposeBag()

    // MARK: - Init
    init(downloadService: DownloadServiceType) {
        self.downloadService = downloadService
    }

    // MARK: - Public
    lazy var setFeaturePhotoAction: CocoaAction = {
        return CocoaAction {
            return self
                .downloadService
                .downloadFeaturePhoto()
                .flatMapLatest({ (path) -> Observable<Void> in
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
