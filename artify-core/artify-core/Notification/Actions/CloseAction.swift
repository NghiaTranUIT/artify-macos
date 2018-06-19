//
//  CloseAction.swift
//  artify-core
//
//  Created by Nghia Tran on 6/19/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

struct CloseAtion: PushAction {

    var type: PushActionType { return .close }

    var title: String { return "Close" }

    var url: String { return "" }
}
