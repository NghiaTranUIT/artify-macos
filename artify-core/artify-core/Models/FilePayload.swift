//
//  FilePayload.swift
//  artify-core
//
//  Created by Nghia Tran on 6/1/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

struct FilePayload {

    enum Kind: String {
        case jpg
        case png

        var systemFileType: NSBitmapImageRep.FileType {
            switch self {
            case .jpg:
                return .jpeg
            case .png:
                return .png
            }
        }
    }

    let image: NSImage
    let photo: Photo
    let kind: Kind
    let prefix: String?

    // MARK: - Public
    init(image: NSImage, photo: Photo, kind: Kind = .jpg, prefix: String? = nil) {
        self.image = image
        self.photo = photo
        self.kind = kind
        self.prefix = prefix
    }

    var fileExtension: String {
        return kind.rawValue
    }

    var fileName: String {
        guard let prefix = prefix else {
            return "\(formatName).\(fileExtension)"
        }
        return "\(prefix)_\(formatName).\(fileExtension)"
    }

    var dataRepresentation: Data {
        return NSBitmapImageRep(data: image.tiffRepresentation!)!
            .representation(using: kind.systemFileType, properties: [:])!
    }

    private var formatName: String {
        return photo.name.replacingOccurrences(of: " ", with: "_").lowercased()
    }
}
