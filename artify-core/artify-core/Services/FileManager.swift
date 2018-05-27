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
    func saveImageIfNeed(_ image: NSImage, name: String) -> URL?
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

    func saveImageIfNeed(_ image: NSImage, name: String) -> URL? {
        guard !isPhotoFileExist(name) else {
            return nil
        }
        let path = appFolder.appendingPathComponent(name)
        try? NSBitmapImageRep(data: image.tiffRepresentation!)?.representation(using: NSBitmapImageRep.FileType.png, properties: [:])?.write(to: path, options: Data.WritingOptions.atomic)
        return path
    }

    func isPhotoFileExist(_ name: String) -> Bool {
        let imagePath = appFolder.appendingPathComponent(name)
        return handler.fileExists(atPath: imagePath.absoluteString)
    }
}

extension FileHandler {

    func rx_saveImageIfNeed(_ image: NSImage, name: String) -> Observable<URL> {
        return Observable.create({ (observer) -> Disposable in
            guard let path = self.saveImageIfNeed(image, name: name) else {
                observer.onError(ArtfiyError.saveImageError(name))
                return Disposables.create()
            }

            // Success
            observer.onNext(path)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
