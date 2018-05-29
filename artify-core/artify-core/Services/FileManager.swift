//
//  FileManager.swift
//  artify-core
//
//  Created by Nghia Tran on 5/27/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Cocoa
import RxSwift

protocol FileHandler {

    func isPhotoFileExist(_ name: String) -> Bool
    func saveImageIfNeed(_ image: NSImage, name: String) -> URL
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
        appFolder = handler.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(Constant.AppFolderName)
        createFolderApp()
    }

    private func createFolderApp() {
        guard !handler.fileExists(atPath: appFolder.path) else {
            print("[INFO] App folder exists \(appFolder)")
            return
        }
        do {
            try handler.createDirectory(at: appFolder, withIntermediateDirectories: false, attributes: nil)
            print("[INFO] Created new folder at \(appFolder)")
        } catch (let error) {
            print("[ERROR] Can't Create folder = \(appFolder), error = \(error)")
        }
    }

    func saveImageIfNeed(_ image: NSImage, name: String) -> URL {
        let path = appFolder.appendingPathComponent("\(name).jpg")
        guard !isPhotoFileExist(name) else {
            return path
        }
        try? NSBitmapImageRep(data: image.tiffRepresentation!)?.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])?.write(to: path, options: Data.WritingOptions.atomic)
        return path
    }

    func isPhotoFileExist(_ name: String) -> Bool {
        let imagePath = appFolder.appendingPathComponent("\(name).jpg")
        return handler.fileExists(atPath: imagePath.path)
    }
}

extension FileHandler {

    func rx_saveImageIfNeed(_ image: NSImage, name: String) -> Observable<URL> {
        return Observable.create({ (observer) -> Disposable in

            // Save
            let path = self.saveImageIfNeed(image, name: name)

            // Success
            observer.onNext(path)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
