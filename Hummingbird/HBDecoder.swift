//
//  HBDecoder.swift
//  Pulse
//
//  Created by Chong Han on 7/18/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

public class HBDecoder {

    var rootObject: HBObject
    var keygen: HBKeyGen
    
    public init(bytes: [UInt8], mapping: [String: UInt8]? = nil) throws {
        keygen = HBKeyGen(mapping: mapping)
        let parser = ByteParser(bytes: bytes)
        if let type = HBType(rawValue: try parser.getUInt8()) , type == HBType.object{
            rootObject = try HBObject(parser: parser)
        } else {
            throw HBError.unableToParse(message: "Could not determine HummingBird type at root in HBDecoder")
        }
    }
    
    init(rootObject: HBObject, mapping: [String: UInt8]? = nil) {
        keygen = HBKeyGen(mapping: mapping)
        self.rootObject = rootObject
    }
    // Throw methods
    public func decode(_ key: String) throws -> UInt8 {
        return try rootObject.getByte(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Int16 {
        return try rootObject.getInt16(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> UInt16 {
        return try rootObject.getUInt16(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Int32 {
        return try rootObject.getInt32(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> UInt32 {
        return try rootObject.getUInt32(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Int64 {
        return try rootObject.getInt64(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> UInt64 {
        return try rootObject.getUInt64(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Bool {
        return try rootObject.getBool(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Float {
        return try rootObject.getFloat(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Double {
        return try rootObject.getDouble(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> String {
        return try rootObject.getString(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> Int {
        return try rootObject.getInt(keygen.get(key))
    }
    
    public func decode(_ key: String) throws -> HBGuid {
        return try rootObject.getGuid(keygen.get(key))
    }
    // Decode objects
    public func decode<T: HBDecodable>(_ key: String) throws -> T {
        return try rootObject.getObject(keygen.get(key))
    }
    // Decode collections
    public func decode<T>(_ key: String) throws -> [T] {
        return try rootObject.getCollection(keygen.get(key))
    }
    
    public func decode<T: HBDecodable>(_ key: String) throws -> [T] {
        return try rootObject.getCollection(keygen.get(key))
    }
    
}
