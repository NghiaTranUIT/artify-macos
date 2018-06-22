//
//  ArtifyCoreApi.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum ArtifyCoreAPI {
    case getFeature
    case randomPhoto
    case checkUpdate(AppInfo)
}

extension ArtifyCoreAPI: TargetType {
    var baseURL: URL {
        return URL(string: Coordinator.default.environment.baseURL)!
    }

    var path: String {
        switch self {
        case .getFeature:
            return "feature/today"
        case .randomPhoto:
            return "feature/random"
        case .checkUpdate:
            return "version/update"
        }
    }

    var method: Moya.Method {
        switch self {
        case .randomPhoto:
            fallthrough
        case .checkUpdate:
            fallthrough
        case .getFeature:
            return Moya.Method.get
        }
    }

    var sampleData: Data {
        return "Fake".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .checkUpdate:
            let param = self.parameter!
            return Task.requestParameters(parameters: param, encoding: URLEncoding.default)
        default:
            if let parameter = self.parameter {
                return Task.requestParameters(parameters: parameter, encoding: JSONEncoding.default)
            }
        }
        return Task.requestPlain
    }

    var headers: [String : String]? {
        return nil
    }

    var parameter: [String: Any]? {
        switch self {
        case .checkUpdate(let info):
            return ["build_version": info.appVersion]
        default:
            return nil
        }
    }

}
