//
//  HBKey.swift
//  Pulse
//
//  Created by Chong Han on 7/30/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

enum HBKeyType {
    case stringKey(value: String)
    case shortKey(value: UInt8)
}

public struct HBKey: Hashable {
    var type: HBKeyType
    
    public init(key: String) {
        self.type = .stringKey(value: key)
    }
    
    public init(key: UInt8) {
        self.type = .shortKey(value: key)
    }
    
    public func toByte() -> [UInt8] {
        switch type {
        case .stringKey(let value):
            return ByteUtils.toEncodedString(value)
        case .shortKey(let value):
            return [0, value]
        }
    }
    
    public var hashValue: Int {
        switch type {
        case .stringKey(let value):
            return value.hashValue
        case .shortKey(let value):
            return value.hashValue
        }
    }
}

public func ==(lhs: HBKey, rhs: HBKey) -> Bool {
    switch lhs.type {
    case .stringKey(let s1):
        if case .stringKey(let s2) = rhs.type , s1 == s2 { return true }
    case .shortKey(let i1):
        if case .shortKey(let i2) = rhs.type , i1 == i2 { return true }
    }
    return false
}
