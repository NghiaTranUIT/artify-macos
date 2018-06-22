//
//  NetworkService.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol NetworkingServiceType {

    var provider: MoyaProvider<ArtifyCoreAPI> { get }
    func fetchFeaturePhoto() -> Observable<Photo>
    func fetchRandomPhoto() -> Observable<Photo>
}


final class NetworkingService: NetworkingServiceType {

    // MARK: - Variable
    private let environment: Environment
    private let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true,
                                                             responseDataFormatter: NetworkingService.JSONResponseDataFormatter)]
    let provider: MoyaProvider<ArtifyCoreAPI>

    // MARK: - Init
    init(environment: Environment) {
        self.environment = environment
        self.provider = MoyaProvider<ArtifyCoreAPI>(plugins: plugins)
    }

    func fetchFeaturePhoto() -> Observable<Photo> {
        return provider
            .rx
            .request(.getFeature)
            .mapToModel(type: Photo.self)
            .asObservable()
            .do(onNext: { (photo) in
                TrackingService.default.tracking(.fetchFeaturePhoto(FetchFeaturePhotoParam(isSuccess: true, photo: photo)))
            }, onError: { (error) in
                TrackingService.default.tracking(.fetchFeaturePhoto(FetchFeaturePhotoParam(isSuccess: false, error: error)))
            })
    }

    func fetchRandomPhoto() -> Observable<Photo> {
        return provider
            .rx
            .request(.randomPhoto)
            .mapToModel(type: Photo.self)
            .asObservable()
            .do(onNext: { (photo) in
                TrackingService.default.tracking(.fetchRandomPhoto(FetchFeaturePhotoParam(isSuccess: true, photo: photo)))
            }, onError: { (error) in
                TrackingService.default.tracking(.fetchRandomPhoto(FetchFeaturePhotoParam(isSuccess: false, error: error)))
            })
    }
}

// MARK: - Private
extension NetworkingService {

    fileprivate class func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
}
