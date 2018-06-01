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
    func saveImageIfNeed(_ payload: FilePayload) -> URL
}

final class FileStorage: FileHandler {

    struct Constant {
        static let AppFolderName = "Artify"
    }

    // MARK: - Variable
    private let handler = FileManager.default
    fileprivate let appFolder: URL

    // MARK: - Init
    init() {
        appFolder = handler.urls(for: .cachesDirectory, in: .userDomainMask).first!
                            .appendingPathComponent(Constant.AppFolderName)
        createFolderApp()
    }

    func saveImageIfNeed(_ payload: FilePayload) -> URL {
        let path = appFolder.appendingPathComponent(payload.fileName)
        guard !isPhotoFileExist(payload.fileName) else {
            return path
        }
        try? payload.dataRepresentation.write(to: path, options: .atomic)
        return path
    }

    func isPhotoFileExist(_ fileName: String) -> Bool {
        let imagePath = appFolder.appendingPathComponent(fileName)
        return handler.fileExists(atPath: imagePath.path)
    }
}

// MARK: - Private
extension FileStorage {

    fileprivate func createFolderApp() {
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
}

// MARK: - Rx
extension FileHandler {

    func rx_saveImageIfNeed(_ payload: FilePayload) -> Observable<URL> {
        return Observable.create({ (observer) -> Disposable in

            // Save
            let path = self.saveImageIfNeed(payload)

            // Success
            observer.onNext(path)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}
