//
//  Author.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import Unbox

public struct Author: Unboxable {

    struct Keys {
        static let ID = "id"
        static let Name = "name"
        static let Born = "born"
        static let Died = "died"
        static let Nationality = "nationality"
        static let Wikipedia = "wikipedia"
    }

    // MARK: - Variable
    public let id: String
    public let name: String
    public let born: String
    public let died: String
    public let nationality: String
    public let wikipedia: String

    // MARK: - Init
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: Keys.ID)
        self.name = try unboxer.unbox(key: Keys.Name)
        self.born = try unboxer.unbox(key: Keys.Born)
        self.died = try unboxer.unbox(key: Keys.Died)
        self.nationality = try unboxer.unbox(key: Keys.Nationality)
        self.wikipedia = try unboxer.unbox(key: Keys.Wikipedia)
    }
}
