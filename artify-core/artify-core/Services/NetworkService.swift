//
//  NetworkService.swift
//  artify-core
//
//  Created by Nghia Tran on 5/20/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

protocol NetworkingServiceType {

}

final class NetworkingService: NetworkingServiceType {

    // MARK: - Variable
    private let environment: Environment

    // MARK: - Init
    init(environment: Environment) {
        self.environment = environment
    }
}
