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
}

extension ArtifyCoreAPI: TargetType {
    var baseURL: URL {
        return URL(string: Coordinator.default.environment.baseURL)!
    }

    var path: String {
        switch self {
        case .getFeature:
            return "feature/today"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getFeature:
            return Moya.Method.get
        }
    }

    var sampleData: Data {
        return "Fake".data(using: .utf8)!
    }

    var task: Task {
        if let parameter = self.parameter {
            return Task.requestParameters(parameters: parameter, encoding: JSONEncoding.default)
        }
        return Task.requestPlain
    }

    var headers: [String : String]? {
        return nil
    }

    var parameter: [String: Any]? {
        return nil
    }

}
