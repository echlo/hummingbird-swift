//
//  HBPrimitive.swift
//  Pulse
//
//  Created by Chong Han on 7/18/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

struct HBPrimitive: HBSerializable {
    
    let bytes: [UInt8]
    let type: HBType
    
    init(parser: ByteParser, type: HBType) throws {
        self.type = type
        switch type {
        case .byte:
            bytes = try parser.getSubBytes(1)
        case .int16:
            bytes = try parser.getSubBytes(2)
        case .uInt16:
            bytes = try parser.getSubBytes(2)
        case .int32:
            bytes = try parser.getSubBytes(4)
        case .uInt32:
            bytes = try parser.getSubBytes(4)
        case .int64:
            bytes = try parser.getSubBytes(8)
        case .uInt64:
            bytes = try parser.getSubBytes(8)
        case .double:
            bytes = try parser.getSubBytes(8)
        case .float:
            bytes = try parser.getSubBytes(4)
        case .string:
            bytes = try parser.getVariableSubBytes()
        case .bool:
            bytes = try parser.getSubBytes(1)
        case .guid:
            bytes = try parser.getSubBytes(16)
        default:
            bytes = []
        }
    }
    init(value: UInt8) {
        bytes = [value]
        type = HBType.byte
    }    
    init(value: Int16) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.int16
    }
    init(value: UInt16) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.uInt16
    }
    init(value: Int32) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.int32
    }
    init(value: UInt32) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.uInt32
    }
    init(value: Int64) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.int64
    }
    init(value: UInt64) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.uInt64
    }
    init(value: Int) {
        if MemoryLayout<Int>.size == 8 {
            self.init(value: Int64(value))
        } else {
            self.init(value: Int32(value))
        }
    }
    init(value: Double) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.double
    }
    init(value: Float) {
        bytes = ByteUtils.toBytes(value)
        type = HBType.float
    }
    init(value: String) {
        bytes = ByteUtils.toEncodedString(value)
        type = HBType.string
    }
    init(value: Bool) {
        let boolByte = value ? UInt8(1) : UInt8(0)
        bytes = [boolByte]
        type = HBType.bool
    }
    init(value: HBGuid) {
        bytes = value.toBytes()
        type = HBType.guid
    }
    // Return functions
    func toAny() throws -> Any? {
        switch type {
        case .byte:
            return try toByte()
        case .int16:
            return try toInt16()
        case .uInt16:
            return try toUInt16()
        case .int32:
            return try toInt32()
        case .uInt32:
            return try toUInt32()
        case .int64:
            return try toInt64()
        case .uInt64:
            return try toUInt64()
        case .double:
            return try toDouble()
        case .float:
            return try toFloat()
        case .bool:
            return try toBool()
        case .string:
            return try toString()
        case .guid:
            return try toGuid()
        default:
            return nil
        }
    }
    func toByte() throws -> UInt8 {
        if type == .byte {
            return bytes[0]
        }
        throw HBError.primitiveTypeMismatch
    }
    func toUInt16() throws -> UInt16 {
        switch type {
        case .byte:
            return UInt16(bytes[0])
        case .uInt16:
            return ByteUtils.toUInt16(bytes)
        case .int16:
            let val = try! toInt16()
            let result = UInt16(bitPattern: val)
            if result > UInt16.max / 2 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        default:
            throw HBError.primitiveTypeMismatch
        }
    }
    func toInt16() throws -> Int16 {
        switch type {
        case .byte:
            return Int16(bytes[0])
        case .uInt16:
            let val = ByteUtils.toUInt16(bytes)
            let result = Int16(bitPattern: val)
            if result >= 0 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        case .int16:
            return ByteUtils.toInt16(bytes)
        default:
            throw HBError.primitiveTypeMismatch
        }
    }
    func toUInt32() throws -> UInt32 {
        switch type {
        case .byte, .uInt16, .uInt32:
            return ByteUtils.toUInt32(bytes)
        case .int16, .int32:
            let val = ByteUtils.toInt32(bytes)
            let result = UInt32(bitPattern: val)
            if result > UInt32.max / 2 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        default:
            throw HBError.primitiveTypeMismatch
        }
    }
    func toInt32() throws -> Int32 {
        switch type {
        case .byte, .int16, .uInt16, .int32:
            return ByteUtils.toInt32(bytes)
        case .uInt32:
            let val = ByteUtils.toUInt32(bytes)
            let result = Int32(bitPattern: val)
            if result >= 0 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        case .int64:
            let val = ByteUtils.toInt64(bytes)
            let result = Int32(truncatingIfNeeded: val)
            if result >= 0 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        case .uInt64:
            let val = ByteUtils.toUInt64(bytes)
            let result = Int32(truncatingIfNeeded: val)
            if result >= 0 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        default:
            throw HBError.primitiveTypeMismatch
        }
    }
    func toUInt64() throws -> UInt64 {
        switch type {
        case .byte, .uInt16, .uInt32, .uInt64:
            return ByteUtils.toUInt64(bytes)
        case .int16, .int32:
            let val = ByteUtils.toInt64(bytes)
            let result = UInt64(bitPattern: val)
            if result > UInt64.max / 2 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        default:
            throw HBError.primitiveTypeMismatch
        }
    }
    func toInt64() throws -> Int64 {
        switch type {
        case .byte, .int16, .uInt16, .int32, .uInt32, .int64:
            return ByteUtils.toInt64(bytes)
        case .uInt64:
            let val = ByteUtils.toUInt64(bytes)
            let result = Int64(bitPattern: val)
            if result >= 0 {
                return result
            }
            throw HBError.primitiveTypeMismatch
        default:
            throw HBError.primitiveTypeMismatch
        }
    }
    func toInt() throws -> Int {
        if MemoryLayout<Int>.size == 8 {
            return Int(try toInt64())
        }
        return Int(try toInt32())
    }
    func toDouble() throws -> Double {
        if type == .float {
            let val = ByteUtils.toFloat(bytes)
            return Double(val)
        } else if type == .double {
            return ByteUtils.toDouble(bytes)
        }
        throw HBError.primitiveTypeMismatch
    }
    func toFloat() throws -> Float {
        if type == .float {
            return ByteUtils.toFloat(bytes)
        }
        throw HBError.primitiveTypeMismatch
    }
    func toString() throws -> String {
        if type == .string {
            return ByteStringConverter.bytesToString(bytes)
        }
        throw HBError.primitiveTypeMismatch
    }
    func toGuid() throws -> HBGuid {
        if type == .guid {
            return HBGuid(bytes: bytes)
        }
        throw HBError.primitiveTypeMismatch
    }
    func toBool() throws -> Bool {
        if type == .bool {
            return bytes[0] == 0 ? false : true
        }
        throw HBError.primitiveTypeMismatch
    }
    func toBytes() -> [UInt8] {
        return bytes
    }
    func toTypedBytes() -> [UInt8] {
        return [type.rawValue] + bytes
    }
}
