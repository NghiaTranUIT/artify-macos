//
//  TrackingParameter.swift
//  artify-core
//
//  Created by Nghia Tran on 6/4/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

public protocol TrackingParameter {

    func toAttribute() -> [String: Any]?
}

public struct Device {

    public static var info: [String: String] {
        return ["username": NSUserName()]
    }
}

public struct SetWallpaperParam: TrackingParameter {

    public let photo: Photo
    public let screenSize: CGSize

    public func toAttribute() -> [String : Any]? {
        return Device.info + ["photoName": photo.name,
                              "screenSize": screenSize.toString]
    }
}

public struct LaunchOnStartupParam: TrackingParameter {

    public let isEnable: Bool

    public func toAttribute() -> [String : Any]? {
        return Device.info + ["isEnable": isEnable]
    }
}

public struct FetchFeaturePhotoParam: TrackingParameter {

    public let isSuccess: Bool
    public let photo: Photo?
    public let error: Error?

    public init(isSuccess: Bool, photo: Photo? = nil, error: Error? = nil) {
        self.isSuccess = isSuccess
        self.photo = photo
        self.error = error
    }

    public func toAttribute() -> [String : Any]? {
        return ["photoName": photo?.name,
                "isSuccess": isSuccess,
                "error": error].filterNil()
    }
}

public struct AppUpdatedParam: TrackingParameter {

    public let buildVersion: String
    public let buildNumber: String

    public init(buildVersion: String, buildNumber: String) {
        self.buildVersion = buildVersion
        self.buildNumber = buildNumber
    }

    public func toAttribute() -> [String : Any]? {
        return Device.info + ["buildVersion": buildVersion,
                              "buildNumber": buildNumber]
    }
}
