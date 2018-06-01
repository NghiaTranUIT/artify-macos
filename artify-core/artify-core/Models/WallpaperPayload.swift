//
//  WallpaperPayload.swift
//  artify-core
//
//  Created by Nghia Tran on 6/1/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

struct WallpaperPayload {

    let photo: Photo
    let originalImage: NSImage
    let screenSize: NSSize
    let effect: Effect
}

struct WallpaperResponse {
    let photo: Photo
    let screenSize: NSSize
    let wallpaperImage: NSImage
}
