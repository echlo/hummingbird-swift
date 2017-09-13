//
//  HummingBird.swift
//  Pulse
//
//  Created by Chong Han on 7/20/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

private let rootKey = "HB" // do not change this as it will break serialization

public class HummingBird {
    
    public static func serialize(_ object: Any, mapping: [String: UInt8]? = nil) throws -> [UInt8] {
        let encoder = try HBEncoder(object: object, mapping: mapping)
        return encoder.finalize()
    }
    
    public static func serializeAsRoot<T: Collection>(_ object: T) throws -> [UInt8] {
        let encoder = HBEncoder()
        encoder.encode(object, forKey: rootKey)
        return encoder.finalize()
    }
    
    public static func serialize(_ object: HBEncodable, mapping: [String: UInt8]? = nil) throws -> [UInt8] {
        let encoder = HBEncoder(mapping: mapping)
        object.encode(encoder)
        return encoder.finalize()
    }
    
    public static func deserialize<T: HBDecodable>(_ bytes: [UInt8], mapping: [String: UInt8]? = nil) throws -> T {
        let decoder = try HBDecoder(bytes: bytes, mapping: mapping)
        return try T.init(decoder: decoder)
    }
    
    public static func deserialize<T: HBDecodable>(_ bytes: [UInt8], type: T.Type, mapping: [String: UInt8]? = nil) throws -> T {
        let decoder = try HBDecoder(bytes: bytes, mapping: mapping)
        return try T.init(decoder: decoder)
    }
    
    public static func deserializeAsRoot<T>(_ bytes: [UInt8]) throws -> [T] {
        let decoder = try HBDecoder(bytes: bytes)
        return try decoder.decode(rootKey)
    }
    
}
