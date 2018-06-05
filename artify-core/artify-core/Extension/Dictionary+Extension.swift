//
//  Dictionary+Extension.swift
//  artify-core
//
//  Created by Nghia Tran on 6/5/18.
//  Copyright © 2018 com.art.artify.core. All rights reserved.
//

import Foundation

func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

extension Dictionary where Value == Optional<Any>  {

    func filterNil() -> [Key: Any] {
        return self.filter( { $0.value != nil }).mapValues( { $0! })
    }
}
