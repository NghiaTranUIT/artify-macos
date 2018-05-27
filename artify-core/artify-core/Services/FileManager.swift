//
//  FileManager.swift
//  artify-core
//
//  Created by Nghia Tran on 5/27/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Cocoa

protocol FileHandler {

    func isPhotoFileExist(_ name: String) -> Bool
    func saveImageIfNeed(_ image: NSImage, name: String) -> String?
}

final class FileStorage: FileHandler {

    struct Constant {
        static let AppFolderName = "Artify"
    }

    // MARK: - Variable
    private let handler = FileManager.default
    private let appFolder: URL

    // MARK: - Init
    init() {
        appFolder = handler.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(Constant.AppFolderName)
        createFolderApp()
    }

    private func createFolderApp() {
        guard handler.fileExists(atPath: appFolder.absoluteString) else {
            print("[INFO] App folder exists \(appFolder)")
            return
        }
        try? handler.createDirectory(at: appFolder, withIntermediateDirectories: false, attributes: nil)
    }

    func saveImageIfNeed(_ image: NSImage, name: String) -> String? {
        guard !isPhotoFileExist(name) else {
            return nil
        }
        let path = appFolder.appendingPathComponent(name)
        try? NSBitmapImageRep(data: image.tiffRepresentation!)?.representation(using: NSBitmapImageRep.FileType.png, properties: [:])?.write(to: path, options: Data.WritingOptions.atomic)
        return path.absoluteString
    }

    func isPhotoFileExist(_ name: String) -> Bool {
        let imagePath = appFolder.appendingPathComponent(name)
        return handler.fileExists(atPath: imagePath.absoluteString)
    }
}
