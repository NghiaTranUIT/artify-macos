//
//  StatusBarViewModel.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift

public protocol StatusBarViewModelType {

    var input: StatusBarViewModelInput { get }
    var output: StatusBarViewModelOutput { get }
}

public protocol StatusBarViewModelInput {

}

public protocol StatusBarViewModelOutput {

    var menus: Variable<[Menu]> { get }
}

public final class StatusBarViewModel: StatusBarViewModelType, StatusBarViewModelInput, StatusBarViewModelOutput {

    public var input: StatusBarViewModelInput { return self }
    public var output: StatusBarViewModelOutput { return self }

    // MARK: - Output
    public var menus = Variable<[Menu]>([])

    // MARK: - Init
    public init() {
        
    }

}
