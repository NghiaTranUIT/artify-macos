//
//  DownloadService.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxNuke
import Nuke

protocol DownloadServiceType {

    func downloadFeaturePhoto() -> Observable<URL>
}

final class DownloadService: DownloadServiceType {

    // MARK: - Variable
    private let network: NetworkingServiceType
    private let fileHandler: FileHandler
    private let imagePipline: ImagePipeline
    private let bag = DisposeBag()

    // MARK: - Init
    init(network: NetworkingServiceType, fileHandler: FileHandler) {
        self.network = network
        self.fileHandler = fileHandler

        // Nuke Config
        var config = ImagePipeline.Configuration()
        config.enableExperimentalAggressiveDiskCaching { $0.toBase64() }
        self.imagePipline = ImagePipeline(configuration: config)
    }

    // MARK: - Public
    func downloadFeaturePhoto() -> Observable<URL> {
        return self
            .network
            .fetchFeaturePhoto()
            .map { ImageRequest(url: URL(string: $0.imageURL)!)}
            .flatMapLatest {[unowned self] (request) -> Single<ImageResponse> in
                return self.imagePipline.loadImage(with: request)
            }
            .map { $0.image }
            .flatMapLatest {[unowned self] (image) -> Observable<URL> in
                return self.fileHandler.rx_saveImageIfNeed(image, name: "1")
            }
    }
}

