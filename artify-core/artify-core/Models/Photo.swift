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
        static let ID = "ID"
        static let Name = "name"
        static let ImageURL = "image_url"
        static let AuthorID = "author_id"
        static let Width = "width"
        static let Height = "height"
    }

    // MARK: - Variable
    public let id: String
    public let name: String
    public let imageURL: String
    public let author: Author
    public let size: NSSize

    // MARK: - Init
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: Keys.ID)
        self.name = try unboxer.unbox(key: Keys.ID)
        self.imageURL = try unboxer.unbox(key: Keys.ID)
        self.author = try unboxer.unbox(key: Keys.AuthorID)
        let width: Int = try unboxer.unbox(key: Keys.Width)
        let height: Int = try unboxer.unbox(key: Keys.Height)
        self.size = NSSize(width: width, height: height)
    }
}
