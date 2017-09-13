//
//  HBEncoderTests.swift
//  Pulse
//
//  Created by Chong Han on 7/15/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import XCTest
@testable import Hummingbird

class HBEncoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncodeByte() {
        let encoder = HBEncoder()
        let value = UInt8(155)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let testString = ByteUtils.toEncodedString(key)
        let testArray = Array(results[2..<(2 + testString.count)])
        XCTAssert(testArray == testString)
        XCTAssert(results[2 + testString.count] == HBType.byte.rawValue)
        XCTAssert(results[2 + testString.count + 1] == 155)
    }
    
    func testEncodeInt16() {
        let encoder = HBEncoder()
        let value = Int16(32525)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.int16.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<Int16>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeUInt16() {
        let encoder = HBEncoder()
        let value = UInt16(17212)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.uInt16.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<UInt16>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeInt32() {
        let encoder = HBEncoder()
        let value = Int32(-17211212)
        let key = "test"
        encoder.encode(value, forKey: key)
    
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.int32.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<Int32>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeUInt32() {
        let encoder = HBEncoder()
        let value = UInt32(17212111)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.uInt32.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<UInt32>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeInt64() {
        let encoder = HBEncoder()
        let value = Int64(-17211212)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.int64.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<Int64>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeUInt64() {
        let encoder = HBEncoder()
        let value = UInt64(17212111)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.uInt64.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<UInt64>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeInt() {
        // Since we know all subtypes are tested, we only need to test the logic
        // branching here
        let key = "intTest"
        let keyAsBytes = ByteUtils.toEncodedString(key)
        
        var encoder = HBEncoder()
        encoder.encode(128, forKey: key)
        var results = encoder.finalize()
        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
        
        encoder = HBEncoder()
        encoder.encode(3000, forKey: key)
        results = encoder.finalize()
        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
        
        encoder = HBEncoder()
        encoder.encode(85538, forKey: key)
        results = encoder.finalize()
        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
        
//        encoder = HBEncoder()
//        encoder.encode(Int64(4294967296), forKey: key) // UInt32 max + 1
//        results = encoder.finalize()
//        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
        
        encoder = HBEncoder()
        encoder.encode(-1000, forKey: key)
        results = encoder.finalize()
        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
        
        encoder = HBEncoder()
        encoder.encode(-33000, forKey: key)
        results = encoder.finalize()
        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
        
//        encoder = HBEncoder()
//        encoder.encode(Int64(-2147483649), forKey: key) // Int32 min - 1
//        results = encoder.finalize()
//        XCTAssert(results[2 + keyAsBytes.count] == HBType.int64.rawValue)
    }
    
    func testEncodeDouble() {
        let encoder = HBEncoder()
        let value = Double(312.2311)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.double.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<Double>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeFloat() {
        let encoder = HBEncoder()
        let value = Float(3.1415279)
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.float.rawValue)
        
        let valueAsBytes = ByteUtils.toBytes(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<Float>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeString() {
        let encoder = HBEncoder()
        let value = "foobar"
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.string.rawValue)
        
        let valueAsBytes = ByteUtils.toEncodedString(value)
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + valueAsBytes.count
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeBool() {
        let encoder = HBEncoder()
        let value = false
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.bool.rawValue)
        
        let valueAsBytes = [UInt8(0)]
        let valueStartIndex = keyEndIndex + 1
        let valueEndIndex = valueStartIndex + MemoryLayout<Bool>.size
        let testValue = Array(results[valueStartIndex..<valueEndIndex])
        XCTAssert(valueAsBytes == testValue)
    }
    
    func testEncodeSimpleObject() {
        // straight boring object
        class TestObj {
            let foo = 100
            let bar = "Bar"
        }
        
        let encoder = HBEncoder()
        let value = TestObj()
        let key = "test"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.object.rawValue)
        XCTAssert(results[keyEndIndex + 1] == 2) // 2 keys
        // The test should not be deterministic, and is thus fragile
        let barKeyStartIndex = keyEndIndex + 2
        let barKey = "bar"
        let barKeyAsBytes = ByteUtils.toEncodedString(barKey)
        let barKeyTestArray = Array(results[barKeyStartIndex..<barKeyStartIndex + barKeyAsBytes.count])
        XCTAssert(barKeyAsBytes == barKeyTestArray)
        XCTAssert(results[barKeyStartIndex + barKeyAsBytes.count] == HBType.string.rawValue)
        let barValueAsBytes = ByteUtils.toEncodedString("Bar")
        let barValueStartIndex = barKeyStartIndex + barKeyAsBytes.count + 1
        let barValueEndIndex = barValueStartIndex + barValueAsBytes.count
        let barValueTestArray = Array(results[barValueStartIndex..<barValueEndIndex])
        XCTAssert(barValueAsBytes == barValueTestArray)
        
        let fooKeyStartIndex = barValueEndIndex
        let fooKey = "foo"
        let fooKeyAsBytes = ByteUtils.toEncodedString(fooKey)
        let fooKeyTestArray = Array(results[fooKeyStartIndex..<fooKeyStartIndex + fooKeyAsBytes.count])
        XCTAssert(fooKeyAsBytes == fooKeyTestArray)
        XCTAssert(results[fooKeyStartIndex + fooKeyAsBytes.count] == HBType.int64.rawValue)
        let fooValueStartIndex = fooKeyStartIndex + fooKeyAsBytes.count + 1
        if MemoryLayout<Int>.size == 8 {
            let fooValue = Int64(100)
            let fooValueAsBytes = ByteUtils.toBytes(fooValue)
            let fooValueEndIndex = fooValueStartIndex + fooValueAsBytes.count
            let fooValueTestArray = Array(results[fooValueStartIndex ..< fooValueEndIndex])
            XCTAssert(fooValueAsBytes == fooValueTestArray)
        } else {
            let fooValue = Int32(100)
            let fooValueAsBytes = ByteUtils.toBytes(fooValue)
            let fooValueEndIndex = fooValueStartIndex + fooValueAsBytes.count
            let fooValueTestArray = Array(results[fooValueStartIndex ..< fooValueEndIndex])
            XCTAssert(fooValueAsBytes == fooValueTestArray)
        }
    }
    
    func testEncodeNestedSimpleObject() {
        
        class InnerTestObj {
            let foo = 100
            let bar = "Bar"
        }
        
        class OuterTestObj {
            let inner = InnerTestObj()
            let count = 65536
        }
        
        let encoder = HBEncoder()
        let value = OuterTestObj()
        let key = "data"
        encoder.encode(value, forKey: key)
        // Wrapper object
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        // Wrapper key, aka data
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.object.rawValue)
        XCTAssert(results[keyEndIndex + 1] == 2) // 2 keys
        
        // Second outer key, aka count
        let secondOuterKeyStartIndex = keyEndIndex + 2
        let secondOuterKey = "count"
        let secondOuterKeyAsBytes = ByteUtils.toEncodedString(secondOuterKey)
        let secondOuterKeyEndIndex = secondOuterKeyStartIndex + secondOuterKeyAsBytes.count
        let secondOuterKeyTestArray = Array(results[secondOuterKeyStartIndex..<secondOuterKeyEndIndex])
        XCTAssert(secondOuterKeyAsBytes == secondOuterKeyTestArray)
        XCTAssert(results[secondOuterKeyEndIndex] == HBType.int64.rawValue)
        let secondOuterValueAsBytes = ByteUtils.toBytes(Int64(65536))
        let secondOuterValueStartIndex = secondOuterKeyEndIndex + 1
        let secondOuterValueEndIndex = secondOuterValueStartIndex + secondOuterValueAsBytes.count
        let secondOuterValueTestArray = Array(results[secondOuterValueStartIndex..<secondOuterValueEndIndex])
        XCTAssert(secondOuterValueAsBytes == secondOuterValueTestArray)
        
        // First outer key, aka inner
        let firstOuterKeyStartIndex = secondOuterValueEndIndex
        let firstOuterKey = "inner"
        let firstOuterKeyAsBytes = ByteUtils.toEncodedString(firstOuterKey)
        let firstOuterKeyTestArray = Array(results[firstOuterKeyStartIndex..<firstOuterKeyStartIndex + firstOuterKeyAsBytes.count])
        XCTAssert(firstOuterKeyAsBytes == firstOuterKeyTestArray)
        XCTAssert(results[firstOuterKeyStartIndex + firstOuterKeyAsBytes.count] == HBType.object.rawValue)
        XCTAssert(results[firstOuterKeyStartIndex + firstOuterKeyAsBytes.count + 1] == 2) // 2 keys
        // Second inner key, aka bar
        let secondInnerKeyStartIndex = firstOuterKeyStartIndex + firstOuterKeyAsBytes.count + 2
        let secondInnerKey = "bar"
        let secondInnerKeyAsBytes = ByteUtils.toEncodedString(secondInnerKey)
        let secondInnerKeyTestArray = Array(results[secondInnerKeyStartIndex..<secondInnerKeyStartIndex + secondInnerKeyAsBytes.count])
        XCTAssert(secondInnerKeyAsBytes == secondInnerKeyTestArray)
        XCTAssert(results[secondInnerKeyStartIndex + secondInnerKeyAsBytes.count] == HBType.string.rawValue)
        let secondInnerValueAsBytes = ByteUtils.toEncodedString("Bar")
        let secondInnerValueStartIndex = secondInnerKeyStartIndex + secondInnerKeyAsBytes.count + 1
        let secondInnerValueEndIndex = secondInnerValueStartIndex + secondInnerValueAsBytes.count
        let secondInnerValueTestArray = Array(results[secondInnerValueStartIndex..<secondInnerValueEndIndex])
        XCTAssert(secondInnerValueAsBytes == secondInnerValueTestArray)
        // First inner key, aka foo
        let firstInnerKeyStartIndex = secondInnerValueEndIndex
        let firstInnerKey = "foo"
        let firstInnerKeyAsBytes = ByteUtils.toEncodedString(firstInnerKey)
        let firstInnerKeyTestArray = Array(results[firstInnerKeyStartIndex..<firstInnerKeyStartIndex + firstInnerKeyAsBytes.count])
        XCTAssert(firstInnerKeyAsBytes == firstInnerKeyTestArray)
        XCTAssert(results[firstInnerKeyStartIndex + firstInnerKeyAsBytes.count] == HBType.int64.rawValue)
        let firstInnerValueStartIndex = firstInnerKeyStartIndex + firstInnerKeyAsBytes.count + 1
        let firstInnerValue = Int64(100)
        let firstInnerValueAsBytes = ByteUtils.toBytes(firstInnerValue)
        let firstInnerValueEndIndex = firstInnerValueStartIndex + firstInnerValueAsBytes.count
        let firstInnerValueTestArray = Array(results[firstInnerValueStartIndex ..< firstInnerValueEndIndex])
        XCTAssert(firstInnerValueAsBytes == firstInnerValueTestArray)
    }
    
    func testEncodeSimpleArray() {
        let encoder = HBEncoder()
        let value: [UInt8] = [1, 2, 3, 4, 5]
        let key = "array"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.array.rawValue)
        XCTAssert(results[keyEndIndex + 1] == 5) // number of elements
        XCTAssert(results[keyEndIndex + 2] == HBType.byte.rawValue) // number of elements
        XCTAssert(results[keyEndIndex + 3] == 1)
        XCTAssert(results[keyEndIndex + 4] == 2)
        XCTAssert(results[keyEndIndex + 5] == 3)
        XCTAssert(results[keyEndIndex + 6] == 4)
        XCTAssert(results[keyEndIndex + 7] == 5)
    }
    
    func testEncodeNestedArray() {
        let encoder = HBEncoder()
        let value: [[UInt8]] = [ [1, 2], [3, 4, 5] ]
        let key = "array"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.array.rawValue)
        XCTAssert(results[keyEndIndex + 1] == 2) // number of elements
        XCTAssert(results[keyEndIndex + 2] == HBType.array.rawValue) // number of elements
        XCTAssert(results[keyEndIndex + 3] == 2) // number of sub-elements
        XCTAssert(results[keyEndIndex + 4] == HBType.byte.rawValue)
        XCTAssert(results[keyEndIndex + 5] == 1)
        XCTAssert(results[keyEndIndex + 6] == 2)
        XCTAssert(results[keyEndIndex + 7] == 3) // number of sub-elements
        XCTAssert(results[keyEndIndex + 8] == HBType.byte.rawValue)
        XCTAssert(results[keyEndIndex + 9] == 3)
        XCTAssert(results[keyEndIndex + 10] == 4)
        XCTAssert(results[keyEndIndex + 11] == 5)
    }
    
    func testArrayObjects() {
        class TestObj {
            let foo = 100
            let bar = "Bar"
        }
        
        let encoder = HBEncoder()
        let value: [TestObj] = [TestObj(), TestObj()]
        let key = "data"
        encoder.encode(value, forKey: key)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 1) // 1 key
        
        let keyAsBytes = ByteUtils.toEncodedString(key)
        let keyEndIndex = 2 + keyAsBytes.count
        let testArray = Array(results[2..<keyEndIndex])
        XCTAssert(testArray == keyAsBytes)
        XCTAssert(results[keyEndIndex] == HBType.array.rawValue)
        XCTAssert(results[keyEndIndex + 1] == 2) // number of elements
        XCTAssert(results[keyEndIndex + 2] == HBType.object.rawValue)
        
        let o1StartIndex = keyEndIndex + 3
        XCTAssert(results[o1StartIndex] == 2) // number of keys
        
        let o1k2StartIndex = o1StartIndex + 1
        let o1k2AsBytes = ByteUtils.toEncodedString("bar")
        let o1k2EndIndex = o1k2StartIndex + o1k2AsBytes.count
        let o1k2TestArray = Array(results[o1k2StartIndex..<o1k2EndIndex])
        XCTAssert(o1k2AsBytes == o1k2TestArray)
        XCTAssert(results[o1k2EndIndex] == HBType.string.rawValue)
        let o1v2StartIndex = o1k2EndIndex + 1
        let o1v2AsBytes = ByteUtils.toEncodedString("Bar")
        let o1v2EndIndex = o1v2StartIndex + o1v2AsBytes.count
        let o1v2TestArray = Array(results[o1v2StartIndex..<o1v2EndIndex])
        XCTAssert(o1v2AsBytes == o1v2TestArray)
        
        let o1k1StartIndex = o1v2EndIndex
        let o1k1AsBytes = ByteUtils.toEncodedString("foo")
        let o1k1EndIndex = o1k1StartIndex + o1k1AsBytes.count
        let o1k1TestArray = Array(results[o1k1StartIndex..<o1k1EndIndex])
        XCTAssert(o1k1AsBytes == o1k1TestArray)
        XCTAssert(results[o1k1EndIndex] == HBType.int64.rawValue)
        let o1v1StartIndex = o1k1EndIndex + 1
        let o1v1AsBytes = ByteUtils.toBytes(Int64(100))
        let o1v1EndIndex = o1v1StartIndex + o1v1AsBytes.count
        let o1v1TestArray = Array(results[o1v1StartIndex..<o1v1EndIndex])
        XCTAssert(o1v1AsBytes == o1v1TestArray)
        
        let o2StartIndex = o1v1EndIndex
        XCTAssert(results[o2StartIndex] == 2) // number of keys
        
        let o2k2StartIndex = o2StartIndex + 1
        let o2k2AsBytes = ByteUtils.toEncodedString("bar")
        let o2k2EndIndex = o2k2StartIndex + o2k2AsBytes.count
        let o2k2TestArray = Array(results[o2k2StartIndex..<o2k2EndIndex])
        XCTAssert(o2k2AsBytes == o2k2TestArray)
        XCTAssert(results[o2k2EndIndex] == HBType.string.rawValue)
        let o2v2StartIndex = o2k2EndIndex + 1
        let o2v2AsBytes = ByteUtils.toEncodedString("Bar")
        let o2v2EndIndex = o2v2StartIndex + o2v2AsBytes.count
        let o2v2TestArray = Array(results[o2v2StartIndex..<o2v2EndIndex])
        XCTAssert(o2v2AsBytes == o2v2TestArray)
        
        let o2k1StartIndex = o2v2EndIndex
        let o2k1AsBytes = ByteUtils.toEncodedString("foo")
        let o2k1EndIndex = o2k1StartIndex + o2k1AsBytes.count
        let o2k1TestArray = Array(results[o2k1StartIndex..<o2k1EndIndex])
        XCTAssert(o2k1AsBytes == o2k1TestArray)
        XCTAssert(results[o2k1EndIndex] == HBType.int64.rawValue)
        let o2v1StartIndex = o2k1EndIndex + 1
        let o2v1AsBytes = ByteUtils.toBytes(Int64(100))
        let o2v1EndIndex = o2v1StartIndex + o2v1AsBytes.count
        let o2v1TestArray = Array(results[o2v1StartIndex..<o2v1EndIndex])
        XCTAssert(o2v1AsBytes == o2v1TestArray)
    }
    
    func testEncodeWithMapping() {
        let mapping: [String: UInt8] = [
            "test": 1,
            "foo": 2,
            "bar": 99
        ]
        let encoder = HBEncoder(mapping: mapping)
        let testValue = UInt8(155)
        let testKey = "test"
        encoder.encode(testValue, forKey: testKey)
        let fooValue = 2016
        let fooKey = "foo"
        encoder.encode(fooValue, forKey: fooKey)
        let bazValue = "Hello"
        let bazKey = "baz"
        encoder.encode(bazValue, forKey: bazKey)
        
        let results = encoder.finalize()
        XCTAssert(results[0] == HBType.object.rawValue)
        XCTAssert(results[1] == 3) // 3 keys
        
        var index = 2
        for _ in 0..<3 {
            let keyType = results[index]
            if keyType == 0 {
                index += 1
                let shortKey = results[index]
                if shortKey == 1 {
                    XCTAssert(results[index + 1] == 1) // type byte
                    XCTAssert(results[index + 2] == testValue)
                    index += 3
                } else if shortKey == 2 {
                    XCTAssert(results[index + 1] == 6) // type byte
                    let fooArray = ByteUtils.toBytes(Int64(fooValue))
                    XCTAssert(Array(results[index + 2..<index + 10]) == fooArray)
                    index += 10
                } else {
                    XCTFail()
                }
            } else {
                let bazKey = ByteUtils.toEncodedString(bazKey)
                let bazKeyArray = Array(results[index..<index + 4])
                XCTAssert(bazKey == bazKeyArray)
                XCTAssert(results[index+4] == 10) // type string
                let bazValue = ByteUtils.toEncodedString(bazValue)
                let bazValueArray = Array(results[index + 5..<index+11])
                XCTAssert(bazValue == bazValueArray)
                index += 11
            }
        }
    }
    
    func testPerformanceExample() {

        self.measure {
            class TestObj {
                let foo = 100
                let bar = "Bar"
                let hello = [1, 2, 3, 4, 5]
            }
            for _ in 0..<10000 {
                let encoder = try! HBEncoder(object: TestObj())
                _ = encoder.finalize()
            }
        }
    }
    
}
