//
//  HBEncoder.swift
//  Pulse
//
//  Created by Chong Han on 7/18/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

public class HBEncoder {
    
    fileprivate let keygen: HBKeyGen
    lazy var rootObject = HBObject();
    
    public init(mapping: [String: UInt8]? = nil) {
        keygen = HBKeyGen(mapping: mapping)
    }
    
    // Convenience initializer
    init(object: Any, mapping: [String: UInt8]? = nil) throws {
        keygen = HBKeyGen(mapping: mapping)
        
        let parsedObject = asObject(object)
        if let parsedObject = parsedObject {
            rootObject = parsedObject
        } else {
            throw HBError.unableToParse(message: "Unable to parse hummingbird root object in HBEncoder initializer")
        }
    }
    // Primitive type encoding
    public func encode(_ value: UInt8?, forKey key: String) {
        if let value = value {
            rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
        }
    }
    
    public func encode(_ value: UInt16, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: Int16, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: UInt32, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: Int32, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: UInt64, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: Int64, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: Int, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: Double, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: Float, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: String?, forKey key: String) {
        if let value = value {
            rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
        }
    }
    
    public func encode(_ value: Bool, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode(_ value: HBGuid, forKey key: String) {
        rootObject.add(HBPrimitive(value: value), forKey: keygen.get(key))
    }
    
    public func encode<T: HBEncodable>(_ value: T, forKey key: String) {
        let newEncoder = HBEncoder(mapping: keygen.mapping)
        value.encode(newEncoder)
        rootObject.add(newEncoder.rootObject, forKey: keygen.get(key))
    }
    
    public func encode<T: HBEncodable>(_ value: [T], forKey key: String) throws {
        let collection = HBCollection()
        for item in value {
            try collection.add(item, mapping: keygen.mapping)
        }
        rootObject.add(collection, forKey: keygen.get(key))
    }
    
    // Object and array type encoding
    public func encode(_ value: AnyObject, forKey key: String) {
        if let object = asObject(value) {
            rootObject.add(object, forKey: keygen.get(key))
        }
    }
    
    public func encode<T: Collection>(_ value: T, forKey key: String) {
        if let object = asCollection(value) {
            rootObject.add(object, forKey: keygen.get(key))
        }
    }
    
    func finalize() -> [UInt8] {
        return rootObject.toTypedBytes() 
    }
    
    fileprivate func asPrimitive(_ value: Any) -> HBPrimitive? {
        var result: HBPrimitive?
        switch value {
        case let value as UInt8:
            result = HBPrimitive(value: value)
        case let value as Int16:
            result = HBPrimitive(value: value)
        case let value as UInt16:
            result = HBPrimitive(value: value)
        case let value as Int32:
            result = HBPrimitive(value: value)
        case let value as UInt32:
            result = HBPrimitive(value: value)
        case let value as Int64:
            result = HBPrimitive(value: value)
        case let value as UInt64:
            result = HBPrimitive(value: value)
        case let value as Double:
            result = HBPrimitive(value: value)
        case let value as Int:
            result = HBPrimitive(value: value)
        case let value as Float:
            result = HBPrimitive(value: value)
        case let value as String:
            result = HBPrimitive(value: value)
        case let value as Bool:
            result = HBPrimitive(value: value)
        case let value as HBGuid:
            result = HBPrimitive(value: value)
        default:
            break
        }
        return result
    }
    
    fileprivate func asCollection(_ value: Any) -> HBCollection? {
        var result: HBCollection?
        
        let objMirror = Mirror(reflecting: value)
        if let displayStyle = objMirror.displayStyle {
            if displayStyle == .collection || displayStyle == .set {
                do {
                    result = HBCollection()
                    for case let (_, value) in objMirror.children {
                        if let primitive = asPrimitive(value) {
                            try result?.add(primitive)
                        } else if let collection = asCollection(value) {
                            try result?.add(collection)
                        } else if let object = asObject(value) {
                            try result?.add(object)
                        }
                    }
                } catch {
                    result = nil
                }
            } else if displayStyle == .optional && objMirror.children.count == 1 {
                if let child = objMirror.children.first {
                    result = asCollection(child.value)
                }
            }
        }
        
        return result
    }
    
    fileprivate func asObject(_ value: Any) -> HBObject? {
        var result: HBObject?
        
        let objMirror = Mirror(reflecting: value)
        if let displayStyle = objMirror.displayStyle {
            if displayStyle == .class || displayStyle == .struct {
                result = HBObject()
                for case let (key, value) in objMirror.children {
                    if let key = key {
                        if let primitive = asPrimitive(value) {
                            result?.add(primitive, forKey: keygen.get(key))
                        } else if let collection = asCollection(value) {
                            result?.add(collection, forKey: keygen.get(key))
                        } else if let object = asObject(value) {
                            result?.add(object, forKey: keygen.get(key))
                        }
                    }
                }
            } else if displayStyle == .optional && objMirror.children.count == 1 {
                if let child = objMirror.children.first {
                    result = asObject(child.value)
                }
            }
        }
        
        return result
    }
    
}
