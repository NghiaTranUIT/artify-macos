//
//  AppUpdateService.swift
//  artify-core
//
//  Created by Nghia Tran on 5/31/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Squirrel
import RxSwift
import Action
import Moya

protocol Updatable {

    func updateAppIfNeed()
}

class AppUpdateService: Updatable {

    struct Constant {
        static let UpdateInterval: TimeInterval = 60 * 60 * 4 // 4 hours
    }

    // MARK: - Variable
    private lazy var updater: SQRLUpdater = {
        let appInfo = AppInfo.current
        let updateUrl = try! self.network.provider.endpoint(ArtifyCoreAPI.checkUpdate(appInfo)).urlRequest()
        return SQRLUpdater(update: updateUrl)
    }()

    private let network: NetworkingServiceType

    // MARK: - Init
    init(network: NetworkingServiceType) {
        self.network = network
    }

    func updateAppIfNeed() {
        updater.startAutomaticChecks(withInterval: Constant.UpdateInterval)
        updater.updates.subscribeNext({[weak self] (update) in
            guard let strongSelf = self,
                let download = update as? SQRLDownloadedUpdate else {
                return
            }
            print("New build = \(download.update)")

            // Force re-launch
            strongSelf.updater.relaunchToInstallUpdate().subscribeError({ (error) in
                let appInfo = AppInfo.current
                TrackingService.default.tracking(.appUpdated(AppUpdatedParam(buildVersion: appInfo.appVersion,
                                                                             buildNumber: appInfo.buildNumber)))
                print("Error \(String(describing: error))")
            })
        }) { (error) in
            print("Error = \(String(describing: error))")
        }
    }
}
