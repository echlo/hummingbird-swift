//
//  HBCollection.swift
//  Pulse
//
//  Created by Chong Han on 7/18/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

public class HBCollection: HBSerializable {
    
    var collection: [HBSerializable] = []
    
    var type: HBType { return .array }
    
    init() {}
    init(parser: ByteParser) throws {
        let count = try parser.getVariableLengthHeader()
        let subType = HBType(rawValue: try parser.getUInt8())!
        for _ in 0..<count {
            if subType == HBType.array {
                let collection = try HBCollection(parser: parser)
                try add(collection)
            } else if subType == HBType.object {
                let object = try HBObject(parser: parser)
                try add(object)
            } else {
                let primitive = try HBPrimitive(parser: parser, type: subType)
                try add(primitive)
            }
        }
    }
    
    func add(_ value: HBEncodable, mapping: [String: UInt8]? = nil) throws {
        let encoder = HBEncoder(mapping: mapping)
        value.encode(encoder)
        let object = encoder.rootObject
        
        if let firstItem = collection.first {
            guard firstItem.type == object.type else {
                throw HBError.inconsistentType
            }
        }
        
        collection.append(object)
    }
    
    func add(_ value: HBPrimitive) throws {
        if let firstItem = collection.first {
            guard firstItem.type == value.type else {
                throw HBError.inconsistentType
            }
        }
        
        collection.append(value)
    }
    
    func add(_ value: HBCollection) throws {
        if let firstItem = collection.first {
            guard firstItem.type == value.type else {
                throw HBError.inconsistentType
            }
        }
        collection.append(value)
    }
    
    func add(_ value: HBObject) throws {
        if let firstItem = collection.first {
            guard firstItem.type == value.type else {
                throw HBError.inconsistentType
            }
        }
        collection.append(value)
    }
    
    func get<T: HBDecodable>() throws -> [T] {
        if let firstItem = collection.first {
            guard firstItem.type == HBType.object else {
                throw HBError.inconsistentType
            }
        }
        return try collection.map{
            if let item = $0 as? HBObject {
                let decoder = HBDecoder(rootObject: item)
                return try T.init(decoder: decoder)
            } else {
                throw HBError.inconsistentType
            }
        }
    }
    
    func get<T>() throws -> [T] {
        var result: [T] = []
        for item in collection {
            if let item = item as? HBPrimitive {
                if let val = try item.toAny() as? T {
                    result.append(val)
                } else {
                    throw HBError.inconsistentType
                }
            } else {
                throw HBError.inconsistentType
            }
        }
        return result
    }
    
    func toBytes() -> [UInt8] {
        var result: [UInt8] = []
        result += ByteUtils.toVariableLengthBytes(collection.count)
        result.append(getCollectionType().rawValue)
        for item in collection {
            result += item.toBytes()
        }
        return result
    }
    
    func toTypedBytes() -> [UInt8] {
        var result: [UInt8] = []
        result.append(HBType.array.rawValue)
        result += ByteUtils.toVariableLengthBytes(collection.count)
        result.append(getCollectionType().rawValue)
        for item in collection {
            result += item.toBytes()
        }
        return result
    }
    
    fileprivate func getCollectionType() -> HBType {
        guard let firstItem = collection.first else {
            return HBType.byte
        }
        return firstItem.type
    }
    
}
