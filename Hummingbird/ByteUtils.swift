//
//  ByteUtils.swift
//  KrumIphoneClient
//
//  Created by Peter Turner on 9/24/15.
//  Copyright (c) 2015 Krum. All rights reserved.
//

import Foundation

/// This is the enum that indicates the endianness the util requires
/// HummingBird transfers everything as Little, but Swift is architecture specific
/// Example: Int32(100) toByte
///     Binary notation: 0000 0000 0000 0000 0000 0000 0110 0100
///     LittleEndian: [0110 0100, 0000 0000, 0000 0000, 0000 0000]/[100, 0 ,0 ,0]
///     BigEndian: [0000 0000, 0000 0000, 0000 0000, 0110 0100]/[0, 0, 0, 100]
enum ByteOrder {
    case littleEndian, bigEndian
}

class ByteUtils {
    
    static let hostByteOrder = Int(OSHostByteOrder()) == OSLittleEndian ? ByteOrder.littleEndian : ByteOrder.bigEndian
    
    static func toBytes(_ int16: Int16, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        let convertedValue = hostByteOrder == byteOrder ? int16: int16.byteSwapped
        return _toByteArray(convertedValue)
    }
    
    static func toBytes(_ uInt16: UInt16, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        let convertedValue = hostByteOrder == byteOrder ? uInt16: uInt16.byteSwapped
        return _toByteArray(convertedValue)
    }
    
    static func toBytes(_ int32: Int32, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        let convertedValue = hostByteOrder == byteOrder ? int32: int32.byteSwapped
        return _toByteArray(convertedValue)
    }
    
    static func toBytes(_ uInt32: UInt32, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        let convertedValue = hostByteOrder == byteOrder ? uInt32: uInt32.byteSwapped
        return _toByteArray(convertedValue)
    }
    
    static func toBytes(_ int64: Int64, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        let convertedValue = hostByteOrder == byteOrder ? int64: int64.byteSwapped
        return _toByteArray(convertedValue)
    }
    
    static func toBytes(_ uInt64: UInt64, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        let convertedValue = hostByteOrder == byteOrder ? uInt64: uInt64.byteSwapped
        return _toByteArray(convertedValue)
    }
    
    static func toBytes(_ double: Double, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        if hostByteOrder == byteOrder {
            return _toByteArray(double)
        } else {
            return _toByteArray(CFConvertDoubleHostToSwapped(double))
        }
    }
    
    static func toBytes(_ float: Float, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        if hostByteOrder == byteOrder {
            return _toByteArray(float)
        }
        return _toByteArray(CFConvertFloatHostToSwapped(float))
    }
    
    static func toEncodedString(_ string: String) -> [UInt8] {
        return wrapVariableLengthBytes(ByteStringConverter.stringToBytes(string))
    }
    
    static func toVariableLengthBytes(_ count: Int64) -> [UInt8] {
        var retVal: [UInt8] = []
        
        if count < Int64(UInt8.max) {
            let countAsByte = UInt8(count)
            retVal.append(countAsByte)
        } else if count < Int64(UInt16.max) {
            retVal.append(UInt8.max)
            retVal += _toByteArray(UInt16(count))
        } else {
            retVal.append(UInt8.max)
            retVal += _toByteArray(UInt16.max)
            retVal += _toByteArray(UInt32(count))
        }
        return retVal
    }
    
    static func toVariableLengthBytes(_ count: Int) -> [UInt8] {
        var retVal: [UInt8] = []
        
        if count < Int(UInt8.max) {
            let countAsByte = UInt8(count)
            retVal.append(countAsByte)
        } else if count < Int(UInt16.max) {
            retVal.append(UInt8.max)
            retVal += _toByteArray(UInt16(count))
        } else if count < 2147483647 /* max number of elements in C# array :p */ {
            retVal.append(UInt8.max)
            retVal += _toByteArray(UInt16.max)
            retVal += _toByteArray(UInt32(count))
        } else {
            retVal.append(UInt8.max)
            retVal += _toByteArray(UInt16.max)
            retVal += _toByteArray(UInt32.max)
        }
        return retVal
    }
    
    static func wrapVariableLengthBytes(_ bytes: [UInt8]) -> [UInt8] {
        let count = bytes.count
        let countBytes = toVariableLengthBytes(count)
        
        var retVal: [UInt8] = []
        retVal += countBytes
        retVal += bytes
        
        return retVal
    }
    
    static func toDouble(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> Double {
        return fromByteArray(bytes, Double.self, byteOrder: byteOrder)
    }
    
    static func toFloat(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> Float {
        return fromByteArray(bytes, Float.self, byteOrder: byteOrder)
    }
    
    static func toInt16(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> Int16 {
        let value = padBytes(bytes, Int16.self, byteOrder: byteOrder)
        return fromByteArray(value, Int16.self, byteOrder: byteOrder)
    }
    
    static func toUInt16(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> UInt16 {
        let value = padBytes(bytes, UInt16.self, byteOrder: byteOrder)
        return fromByteArray(value, UInt16.self, byteOrder: byteOrder)
    }
    
    static func toUInt32(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> UInt32 {
        let value = padBytes(bytes, UInt32.self, byteOrder: byteOrder)
        return fromByteArray(value, UInt32.self, byteOrder: byteOrder)
    }
    
    static func toInt32(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> Int32 {
        let value = padBytes(bytes, Int32.self, byteOrder: byteOrder)
        return fromByteArray(value, Int32.self, byteOrder: byteOrder)
    }
    
    static func toInt64(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> Int64 {
        let value = padBytes(bytes, Int64.self, byteOrder: byteOrder)
        return fromByteArray(value, Int64.self, byteOrder: byteOrder)
    }
    
    static func toUInt64(_ bytes: [UInt8], byteOrder: ByteOrder = .littleEndian) -> UInt64 {
        let value = padBytes(bytes, UInt64.self, byteOrder: byteOrder)
        return fromByteArray(value, UInt64.self, byteOrder: byteOrder)
    }
    
    fileprivate static func padBytes<T: SignedInteger>(_ value: [UInt8], _: T.Type, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        var bytes = value
        let length = MemoryLayout<T>.size
        if bytes.count < length {
            for _ in bytes.count...length {
                var appendByte: UInt8 = 0
                if let leastSigByte = byteOrder == .littleEndian ? bytes.last : bytes.first {
                    if leastSigByte > 128 { // larger than 1000 0000
                        appendByte = 255
                    }
                }
                if byteOrder == .littleEndian {
                    bytes.append(appendByte)
                } else {
                    bytes.insert(appendByte, at: 0)
                }
            }
        } else if bytes.count > length {
            let len = bytes.count - length
            if byteOrder == .littleEndian {
                bytes = Array(bytes.dropLast(len))
            } else {
                bytes = Array(bytes.dropFirst(len))
            }
        }
        return bytes
    }
    
    fileprivate static func padBytes<T: UnsignedInteger>(_ value: [UInt8], _: T.Type, byteOrder: ByteOrder = .littleEndian) -> [UInt8] {
        var bytes = value
        let length = MemoryLayout<T>.size
        if bytes.count < length {
            for _ in bytes.count...length {
                let appendByte: UInt8 = 0
                if byteOrder == .littleEndian {
                    bytes.append(appendByte)
                } else {
                    bytes.insert(appendByte, at: 0)
                }
            }
        } else if bytes.count > length {
            let len = bytes.count - length
            if byteOrder == .littleEndian {
                bytes = Array(bytes.dropLast(len))
            } else {
                bytes = Array(bytes.dropFirst(len))
            }
        }
        return bytes
    }
    
    fileprivate static func fromByteArray<T>(_ value: [UInt8], _: T.Type, byteOrder: ByteOrder = .littleEndian) -> T {
        var bytes = value
        bytes = hostByteOrder == byteOrder ? bytes : bytes.reversed()
        return bytes.withUnsafeBufferPointer { unsafeBufferPointer in
            unsafeBufferPointer.baseAddress!.withMemoryRebound(to: T.self, capacity: 1) { memoryRebound in
                memoryRebound.pointee
            }
        }
    }
    
    fileprivate static func _toByteArray<T>(_ value: T) -> [UInt8] {
        let totalBytes = MemoryLayout<T>.size
        var value = value
        return withUnsafePointer(to: &value) { valuePtr in
            return valuePtr.withMemoryRebound(to: UInt8.self, capacity: totalBytes) { reboundPtr in
                return Array(UnsafeBufferPointer(start: reboundPtr, count: totalBytes))
            }
        }
    }
}
