//
//  HBObject.swift
//  Pulse
//
//  Created by Chong Han on 7/13/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

class HBObject: HBSerializable {
    
    var dictionary: [HBKey: HBSerializable] = [:]
    
    init() {}
    
    init(parser: ByteParser) throws {
        let count = try parser.getVariableLengthHeader()
        for _ in 0 ..< count {
            let key = try parser.getKey()
            let subType = HBType(rawValue: try parser.getUInt8())!
            if subType == HBType.array {
                let collection = try HBCollection(parser: parser)
                add(collection, forKey: key)
            } else if subType == HBType.object {
                let object = try HBObject(parser: parser)
                add(object, forKey: key)
            } else {
                let primitive = try HBPrimitive(parser: parser, type: subType)
                add(primitive, forKey: key)
            }
        }
    }
    
    var type: HBType {
        return HBType.object
    }
    
    func add(_ value: HBPrimitive, forKey key: HBKey) {
        dictionary[key] = value
    }
    
    func add(_ value: HBCollection, forKey key: HBKey) {
        dictionary[key] = value
    }
    
    func add(_ value: HBObject, forKey key: HBKey) {
        dictionary[key] = value
    }
    // Get primitives
    func getByte(_ key: HBKey) throws -> UInt8 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toByte()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getInt16(_ key: HBKey) throws -> Int16 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toInt16()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getUInt16(_ key: HBKey) throws -> UInt16 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toUInt16()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getInt32(_ key: HBKey) throws -> Int32 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toInt32()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getUInt32(_ key: HBKey) throws -> UInt32 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toUInt32()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getInt64(_ key: HBKey) throws -> Int64 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toInt64()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getUInt64(_ key: HBKey) throws -> UInt64 {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toUInt64()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getInt(_ key: HBKey) throws -> Int {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toInt()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getBool(_ key: HBKey) throws -> Bool {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toBool()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getFloat(_ key: HBKey) throws -> Float {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toFloat()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getDouble(_ key: HBKey) throws -> Double {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toDouble()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getString(_ key: HBKey) throws -> String {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toString()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    
    func getGuid(_ key: HBKey) throws -> HBGuid {
        guard let primitive = dictionary[key] as? HBPrimitive else {
            throw HBError.incompatibleType(key: key)
        }
        do {
            return try primitive.toGuid()
        } catch HBError.primitiveTypeMismatch {
            throw HBError.incompatibleType(key: key)
        }
    }
    // Get Object
    func getObject<T: HBDecodable>(_ key: HBKey) throws -> T {
        guard let object = dictionary[key] as? HBObject else {
            throw HBError.incompatibleType(key: key)
        }
        let decoder = HBDecoder(rootObject: object)
        return try T.init(decoder: decoder)
    }
    // Get collections
    func getCollection<T: HBDecodable>(_ key: HBKey) throws -> [T] {
        guard let collection = dictionary[key] as? HBCollection else {
            throw HBError.incompatibleType(key: key)
        }
        return try collection.get()
    }
    
    func getCollection<T>(_ key: HBKey) throws -> [T] {
        guard let collection = dictionary[key] as? HBCollection else {
            throw HBError.incompatibleType(key: key)
        }
        return try collection.get()
    }
    
    // Serialization methods
    func toBytes() -> [UInt8] {
        var result: [UInt8] = []
        result += ByteUtils.toVariableLengthBytes(dictionary.count)
        for (key, item) in dictionary {
            result += key.toByte()
            result += item.toTypedBytes()
        }
        return result
    }
    
    func toTypedBytes() -> [UInt8] {
        var result: [UInt8] = []
        result.append(HBType.object.rawValue)
        result += ByteUtils.toVariableLengthBytes(dictionary.count)
        for (key, item) in dictionary {
            result += key.toByte()
            result += item.toTypedBytes()
        }
        return result
    }
    
}
