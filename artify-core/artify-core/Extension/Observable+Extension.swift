//
//  Observable+Extension.swift
//  artify-core
//
//  Created by Nghia Tran on 6/1/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {

    func mapToVoid() -> Observable<Void> {
        return self.map { _ in }
    }
}
