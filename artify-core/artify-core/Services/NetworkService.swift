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

    func fetchFeaturePhoto() -> Observable<Photo>
}


final class NetworkingService: NetworkingServiceType {

    // MARK: - Variable
    private let environment: Environment
    private let plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true,
                                                             responseDataFormatter: NetworkingService.JSONResponseDataFormatter)]
    private let provider: MoyaProvider<ArtifyCoreAPI>

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
