//
//  AppUpdater.swift
//  Artify
//
//  Created by Nghia Tran on 6/12/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Foundation
import Sparkle
import artify_core

final class SparkleUpdater: AppUpdatable {

    // MARK: - Variable
    private let updater = SUUpdater.shared()!

    func checkForUpdate() {
        updater.checkForUpdates(nil)
    }
}
