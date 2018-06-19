//
//  Coordinator.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

public class Coordinator {

    // MARK: - Default
    public static var `default`: Coordinator!

    // MARK: - Variable
    private let fileHandler: FileHandler
    private let networkingService: NetworkingServiceType
    let trackingService: TrackingServiceType
    let wallpaperService: WallpaperServiceType
    let downloadService: DownloadService
    let notificationService: NotificationServiceType
    let environment: Environment

    // MARK: - Init
    public init(kind: Environment.Kind, trackable: Trackable) {
        self.environment = Environment(kind: kind)
        self.networkingService = NetworkingService(environment: environment)
        self.fileHandler = FileStorage()
        self.notificationService = NotificationService()
        self.downloadService = DownloadService(network: networkingService,
                                               fileHandler: fileHandler)
        self.wallpaperService = WallpaperService(downloadService: downloadService,
                                                 fileHandler: fileHandler,
                                                 notificationService: notificationService)
        self.trackingService = TrackingService(trackable: trackable)
    }

    // MARK: - Public
    public func makeDefaut() {
        Coordinator.default = self
    }
}
