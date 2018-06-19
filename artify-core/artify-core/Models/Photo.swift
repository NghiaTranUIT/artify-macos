//
//  Photo.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Unbox

public struct Photo: Unboxable {

    struct Keys {
        static let ID = "id"
        static let Name = "name"
        static let ImageURL = "image_url"
        static let Author = "author"
        static let Width = "width"
        static let Height = "height"
        static let Style = "style"
        static let Date = "date"
        static let Dimensions = "dimensions"
        static let Location = "location"
        static let Media = "media"
        static let Info = "info"
        static let OriginalSource = "original_source"
    }

    // MARK: - Variable
    public let id: String
    public let name: String
    public let imageURL: String
    public let author: Author
    public let size: NSSize
    public let style: String
    public let dimensions: String
    public let date: String
    public let location: String
    public let media: String
    public let info: String
    public let originalSource: String

    // MARK: - Init
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: Keys.ID)
        self.name = try unboxer.unbox(key: Keys.Name)
        self.imageURL = try unboxer.unbox(key: Keys.ImageURL)
        self.author = try unboxer.unbox(key: Keys.Author)
        let width: Int = try unboxer.unbox(key: Keys.Width)
        let height: Int = try unboxer.unbox(key: Keys.Height)
        self.size = NSSize(width: width, height: height)
        self.style = try unboxer.unbox(key: Keys.Style)
        self.dimensions = try unboxer.unbox(key: Keys.Dimensions)
        self.date = try unboxer.unbox(key: Keys.Date)
        self.location = try unboxer.unbox(key: Keys.Location)
        self.media = try unboxer.unbox(key: Keys.Media)
        self.info = try unboxer.unbox(key: Keys.Info)
        self.originalSource = try unboxer.unbox(key: Keys.OriginalSource)
    }
}
