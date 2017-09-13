//
//  HBDecodableTests.swift
//  Pulse
//
//  Created by Chong Han on 7/20/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import XCTest
@testable import Hummingbird

class HBDecodableTests: XCTestCase {
    
    func testSimpleStruct() {
        struct TestObj: HBDecodable {
            var message: String?
            var id: Int?
            
            init() {}
            init(decoder: HBDecoder) {
                message = try? decoder.decode("message")
                id = try? decoder.decode("id")
            }
        }
        
        do {
            var testObj = TestObj()
            testObj.message = "Hello, world"
            testObj.id = 1991
            
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj: TestObj = try HummingBird.deserialize(bytes)
            XCTAssert(testObj.message == newTestObj.message)
            XCTAssert(testObj.id == newTestObj.id)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testSimpleObject() {
        
        class TestObj: HBDecodable {
            var message: String?
            var id: Int?
            
            init() {}
            required init(decoder: HBDecoder) {
                message = try? decoder.decode("message")
                id = try? decoder.decode("id")
            }
        }
        
        do {
            let testObj = TestObj()
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj: TestObj = try HummingBird.deserialize(bytes)
            XCTAssert(testObj.message == newTestObj.message)
            XCTAssert(testObj.id == newTestObj.id)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testIntDoubleFloatStringBool() {
        
        struct TestObj: HBDecodable {
            var id: Int?
            var location: Double?
            var accuracy: Float?
            var name: String?
            var required: Bool = false
            
            init() {}
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
                location = try? decoder.decode("location")
                accuracy = try? decoder.decode("accuracy")
                name = try? decoder.decode("name")
                required = (try? decoder.decode("required")) ?? false
            }
        }
        
        var testObj = TestObj()
        testObj.id = 1235
        testObj.location = 123.15211
        testObj.accuracy = 1.25
        testObj.name = "Smoked Salmon"
        testObj.required = true
        
        do {
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj = try HummingBird.deserialize(bytes, type: TestObj.self)
            XCTAssert(testObj.id == newTestObj.id)
            XCTAssert(testObj.location == newTestObj.location)
            XCTAssert(testObj.accuracy == newTestObj.accuracy)
            XCTAssert(testObj.name == newTestObj.name)
            XCTAssert(testObj.required == newTestObj.required)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testAllIntegerTypes() {
        struct TestObj: HBDecodable {
            var byte: UInt8?
            var int16: Int16?
            var uInt16: UInt16?
            var int32: Int32?
            var uInt32: UInt32?
            var int64: Int64?
            var uInt64: UInt64?
            var int: Int?
            
            init() {}
            init(decoder: HBDecoder) {
                byte = try? decoder.decode("byte")
                int16 = try? decoder.decode("int16")
                uInt16 = try? decoder.decode("uInt16")
                int32 = try? decoder.decode("int32")
                uInt32 = try? decoder.decode("uInt32")
                int64 = try? decoder.decode("int64")
                uInt64 = try? decoder.decode("uInt64")
                int = try? decoder.decode("int")
            }
        }
        
        var testObj = TestObj()
        testObj.byte = 1
        testObj.int16 = 2
        testObj.uInt16 = 3
        testObj.int32 = 4
        testObj.uInt32 = 5
        testObj.int64 = 6
        testObj.uInt64 = 7
        testObj.int = 8
        
        do {
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj: TestObj = try HummingBird.deserialize(bytes)
            XCTAssert(newTestObj.byte == testObj.byte)
            XCTAssert(newTestObj.int16 == testObj.int16)
            XCTAssert(newTestObj.uInt16 == testObj.uInt16)
            XCTAssert(newTestObj.int32 == testObj.int32)
            XCTAssert(newTestObj.uInt32 == testObj.uInt32)
            XCTAssert(newTestObj.int64 == testObj.int64)
            XCTAssert(newTestObj.uInt64 == testObj.uInt64)
            XCTAssert(newTestObj.int == testObj.int)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testNullIntDoubleFloatStringBool() {
        
        struct TestObj: HBDecodable {
            var id: Int?
            var location: Double?
            var accuracy: Float?
            var name: String?
            var required: Bool = false
            
            init() {}
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
                location = try? decoder.decode("location")
                accuracy = try? decoder.decode("accuracy")
                name = try? decoder.decode("name")
                required = (try? decoder.decode("required")) ?? false
            }
        }
        
        do {
            let testObj = TestObj()
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj = try HummingBird.deserialize(bytes, type: TestObj.self)
            XCTAssert(newTestObj.id == nil)
            XCTAssert(newTestObj.location == nil)
            XCTAssert(newTestObj.accuracy == nil)
            XCTAssert(newTestObj.name == nil)
            XCTAssert(newTestObj.required == false)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testSimpleIntArrays() {
        struct TestObj: HBDecodable {
            var members: [Int16] = []
            init() {}
            init(decoder: HBDecoder) {
                members = (try? decoder.decode("members")) ?? []
            }
        }
        
        do {
            var testObj = TestObj()
            testObj.members = [1, 2, 3, 4, 5]
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj: TestObj = try HummingBird.deserialize(bytes)
            XCTAssert(newTestObj.members.count == testObj.members.count)
            XCTAssert(newTestObj.members == testObj.members)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testSimpleIntArraysAsRoot() {
        do {
            let array = ["Foo", "Bar"]
            let bytes = try HummingBird.serializeAsRoot(array)
            let result: [String] = try HummingBird.deserializeAsRoot(bytes)
            XCTAssert(array.count == result.count)
            XCTAssert(array == result)
        } catch {
            XCTFail("HummingBird should not throw error \(error)")
        }
    }
    
    func testSimpleStringArrays() {
        struct TestObj: HBDecodable {
            var members: [String] = []
            init() {}
            init(decoder: HBDecoder) {
                members = (try? decoder.decode("members")) ?? []
            }
        }
        
        do {
            var testObj = TestObj()
            testObj.members = ["one", "two", "three", "four", "five"]
            let bytes = try HummingBird.serialize(testObj)
            let newTestObj: TestObj = try HummingBird.deserialize(bytes)
            XCTAssert(newTestObj.members.count == testObj.members.count)
            XCTAssert(newTestObj.members == testObj.members)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testMalformedDecoding() {
        class TestObj: HBDecodable {
            var message: String?
            var id: Int?
            
            init() {}
            required init(decoder: HBDecoder) {
                message = try? decoder.decode("message")
                id = try? decoder.decode("id")
            }
        }
        
        let bytes: [UInt8] = [13]
        XCTAssertThrowsError(try HummingBird.deserialize(bytes, type: TestObj.self))
    }
    
    func testNestedObjectsWithOptional () {
        
        struct TestInnerObj: HBDecodable {
            var id: Int?
            
            init(id: Int) { self.id = id }
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
            }
        }
        
        struct TestOuterObj: HBDecodable {
            var id: Int?
            var member: TestInnerObj?
            
            init() {}
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
                member = try? decoder.decode("member")
            }
        }
        
        let testInner1 = TestInnerObj(id: 1)
        var testOuter = TestOuterObj()
        testOuter.id = 999
        testOuter.member = testInner1
        
        do {
            let bytes = try HummingBird.serialize(testOuter)
            let newTestOuter = try HummingBird.deserialize(bytes, type: TestOuterObj.self)
            
            XCTAssert(newTestOuter.id == testOuter.id)
            if let member = newTestOuter.member {
                XCTAssert(member.id == testInner1.id)
            } else {
                XCTFail("member is nil")
            }
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testNestedArrayOfObjects () {
        
        struct TestInnerObj: HBDecodable {
            var id: Int?
            
            init(id: Int) { self.id = id }
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
            }
        }
        
        struct TestOuterObj: HBDecodable {
            var id: Int?
            var members: [TestInnerObj] = []
            
            init() {}
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
                members = (try? decoder.decode("members")) ?? []
            }
        }
        
        let testInner1 = TestInnerObj(id: 1)
        let testInner2 = TestInnerObj(id: 2)
        var testOuter = TestOuterObj()
        testOuter.id = 999
        testOuter.members = [testInner1, testInner2]
        
        do {
            let bytes = try HummingBird.serialize(testOuter)
            let newTestOuter = try HummingBird.deserialize(bytes, type: TestOuterObj.self)
        
            XCTAssert(newTestOuter.id == testOuter.id)
            XCTAssert(newTestOuter.members.count == testOuter.members.count)
            XCTAssert(newTestOuter.members[0].id == testOuter.members[0].id)
            XCTAssert(newTestOuter.members[1].id == testOuter.members[1].id)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testOptionalNestedArrayOfObjects () {
        
        struct TestInnerObj: HBDecodable {
            var id: Int?
            
            init(id: Int) { self.id = id }
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
            }
        }
        
        struct TestOuterObj: HBDecodable {
            var id: Int?
            var members: [TestInnerObj]?
            
            init() {}
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
                members = try? decoder.decode("members")
            }
        }
        
        let testInner1 = TestInnerObj(id: 1)
        let testInner2 = TestInnerObj(id: 2)
        var testOuter = TestOuterObj()
        testOuter.id = 999
        testOuter.members = [testInner1, testInner2]
        
        do {
            let bytes = try HummingBird.serialize(testOuter)
            let newTestOuter = try HummingBird.deserialize(bytes, type: TestOuterObj.self)
            
            XCTAssert(newTestOuter.id == testOuter.id)
            if let testMembers = newTestOuter.members, let members = testOuter.members {
                XCTAssert(testMembers.count == members.count)
                XCTAssert(testMembers[0].id == members[0].id)
                XCTAssert(testMembers[1].id == members[1].id)
            } else {
                XCTFail("Let cast should not fail")
            }
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    
    func testMapping() {
        
        let mapping: [String: UInt8] = [
            "id": 0,
            "location": 1,
            "accuracy": 2,
            "name": 3,
            "required": 4
        ]
        
        struct TestObj: HBDecodable {
            var id: Int?
            var location: Double?
            var accuracy: Float?
            var name: String?
            var required: Bool = false
            
            init() {}
            init(decoder: HBDecoder) {
                id = try? decoder.decode("id")
                location = try? decoder.decode("location")
                accuracy = try? decoder.decode("accuracy")
                name = try? decoder.decode("name")
                required = (try? decoder.decode("required")) ?? false
            }
        }
        
        var testObj = TestObj()
        testObj.id = 1235
        testObj.location = 123.15211
        testObj.accuracy = 1.25
        testObj.name = "Smoked Salmon"
        testObj.required = true
        
        do {
            let bytes = try HummingBird.serialize(testObj, mapping: mapping)
            let newTestObj = try HummingBird.deserialize(bytes, type: TestObj.self, mapping: mapping)
            XCTAssert(testObj.id == newTestObj.id)
            XCTAssert(testObj.location == newTestObj.location)
            XCTAssert(testObj.accuracy == newTestObj.accuracy)
            XCTAssert(testObj.name == newTestObj.name)
            XCTAssert(testObj.required == newTestObj.required)
        } catch {
            XCTFail("HummingBird should not throw error")
        }
    }
    

    func testPerformanceSimpleStruct() {
        
        struct TestObj: HBDecodable {
            var message: String?
            var id: Int?
            
            init() {}
            init(decoder: HBDecoder) {
                message = try? decoder.decode("message")
                id = try? decoder.decode("id")
            }
        }
        
        var testObj = TestObj()
        testObj.message = "Hello, world"
        testObj.id = 1991
        
        let bytes = try! HummingBird.serialize(testObj)
        
        self.measure {
            for _ in 0..<100000 {
                _ = try! HummingBird.deserialize(bytes, type: TestObj.self)
            }
        }
    }
    
    func testSerializeLocation() {
        
        struct TestObj: HBDecodable {
            var latitude: Double?
            var longitude: Double?
            var accuracy: Double?
            var timestamp: Double?
            
            init() {}
            init(decoder: HBDecoder) {
                latitude = try? decoder.decode("latitude")
                longitude = try? decoder.decode("longitude")
                accuracy = try? decoder.decode("accuracy")
                timestamp = try? decoder.decode("timestamp")
            }
        }
        
        var testObj = TestObj()
        testObj.latitude = -123.123123154
        testObj.longitude = -21.2141241241
        testObj.accuracy = 10.0
        testObj.timestamp = Date().timeIntervalSince1970
        
        self.measure {
            for _ in 0..<100000 {
                _ = try! HummingBird.serialize(testObj)
            }
        }

    }
    
    func testDeserializeLocation() {
        struct TestObj: HBDecodable {
            var latitude: Double?
            var longitude: Double?
            var accuracy: Double?
            var timestamp: Double?
            
            init() {}
            init(decoder: HBDecoder) {
                latitude = try? decoder.decode("latitude")
                longitude = try? decoder.decode("longitude")
                accuracy = try? decoder.decode("accuracy")
                timestamp = try? decoder.decode("timestamp")
            }
        }
        
        var testObj = TestObj()
        testObj.latitude = -123.123123154
        testObj.longitude = -21.2141241241
        testObj.accuracy = 10.0
        testObj.timestamp = Date().timeIntervalSince1970
        
        let bytes = try! HummingBird.serialize(testObj)

        self.measure {
            for _ in 0..<10000 {
                _ = try! HummingBird.deserialize(bytes, type: TestObj.self)
            }
        }
    }

}
