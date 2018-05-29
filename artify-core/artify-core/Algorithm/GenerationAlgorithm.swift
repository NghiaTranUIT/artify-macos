//
//  GenerationAlgorithm.swift
//  artify-core
//
//  Created by Nghia Tran on 5/28/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift

protocol DataGenerationType {

    var screenSize: CGSize { get }
    var perfectSize: CGSize { get }
    var originalImage: NSImage { get }
}

protocol GenerationAlgorithm {

    func process(data: DataGenerationType) -> DataGenerationType
}

extension GenerationAlgorithm {

    func rx_process(data: DataGenerationType) -> Observable<DataGenerationType> {
        return Observable.create({ (observer) -> Disposable in
            let finalData = self.process(data: data)
            observer.onNext(finalData)
            return Disposables.create()
        })
    }
}
