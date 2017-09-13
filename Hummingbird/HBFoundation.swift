//
//  HBSerializable.swift
//  Pulse
//
//  Created by Chong Han on 7/15/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

enum HBType: UInt8 {
    case byte = 1
    case int16 = 2
    case uInt16 = 3
    case int32 = 4
    case uInt32 = 5
    case int64 = 6
    case uInt64 = 7
    case double = 8
    case float = 9
    case string = 10
    case bool = 11
    case array = 12
    case object = 13
    case guid = 14
}


public enum HBError: Error {
    case inconsistentType
    case unableToParse(message: String)
    case incompatibleType(key: HBKey?)
    case primitiveTypeMismatch
}

public struct HBGuid: ExpressibleByStringLiteral {
    
    public var value: String = ""

    public init(string: String) {
        self.value = string
    }
    
    public init(stringLiteral value: String) {
        self.value = value
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.value = value
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.value = value
    }
    
    public init(bytes: [UInt8]) {
        self.value = ByteStringConverter.byteArrayToBase64(bytes)
    }
    
    public func toBytes() -> [UInt8] {
        var bytes = ByteStringConverter.base64ToByteArray(self.value) ?? []
        for _ in bytes.count..<16 {
            bytes.append(0)
        }
        return bytes
    }
    
    public func toString() -> String {
        return value
    }
}
