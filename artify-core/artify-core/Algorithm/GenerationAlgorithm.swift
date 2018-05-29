//
//  GenerationAlgorithm.swift
//  artify-core
//
//  Created by Nghia Tran on 5/28/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation
import RxSwift

struct DataGeneration {

    let screenSize: NSSize
    let image: NSImage
}

protocol GenerationAlgorithm {

    func process(data: DataGeneration) -> DataGeneration
}

extension GenerationAlgorithm {

    func rx_process(data: DataGeneration) -> Observable<DataGeneration> {
        return Observable.create({ (observer) -> Disposable in
            let finalData = self.process(data: data)
            observer.onNext(finalData)
            return Disposables.create()
        })
    }
}
