//
//  HBKeyGen.swift
//  Pulse
//
//  Created by Chong Han on 7/30/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

class HBKeyGen {
 
    let mapping: [String: UInt8]?
    
    init(mapping: [String: UInt8]?) {
        self.mapping = mapping
    }
    
    func get(_ key: String) -> HBKey {
        if let shortKey = mapping?[key] {
            return HBKey(key: shortKey)
        } else {
            return HBKey(key: key)
        }
    }
}
