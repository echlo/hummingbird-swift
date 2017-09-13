//
//  ByteParser.swift
//  Pulse
//
//  Created by Peter Turner on 7/8/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

enum ByteParserError: Error {
    case indexOutOfRange
}

class ByteParser {
    var offset = 0;
    var bytes : [UInt8]!
    
    init(bytes: [UInt8], offset: Int = 0) {
        self.bytes = bytes
        self.offset = offset
    }
    
    func getKey() throws -> HBKey {
        let peekInt = bytes[offset]
        if peekInt == 0 {            
            return HBKey(key: try getSubBytes(2)[1])
        } else {
            let string = try getString()
            return HBKey(key: string)
        }
    }
    
    func getGuid() throws -> String {
        let guidBytes = try getSubBytes(16)
        return ByteStringConverter.byteArrayToBase64(guidBytes)
    }
    
    func getString() throws -> String {
        return ByteStringConverter.bytesToString(try getVariableSubBytes())
    }
    
    func getUInt8() throws -> UInt8 {
        return try getSubBytes(1)[0]
    }
    
    func getBool() throws -> Bool {
        return try getSubBytes(1)[0] != 0
    }
    
    func getUInt16() throws -> UInt16 {
        return ByteUtils.toUInt16(try getSubBytes(2))
    }

    func getUInt32() throws -> UInt32 {
        return ByteUtils.toUInt32(try getSubBytes(4))
    }
    
    func getInt32() throws -> Int32 {
        return ByteUtils.toInt32(try getSubBytes(4))
    }
    
    func getDouble() throws -> Double {
        return ByteUtils.toDouble(try getSubBytes(8))
    }
    
    func getVariableLengthHeader() throws -> Int {
        let dataSizeAsByte = try getSubBytes(1)[0]
        
        if dataSizeAsByte == 255 {
            let dataSizeAsUInt16 = ByteUtils.toUInt16(try getSubBytes(2))
            
            if dataSizeAsUInt16 == 65535 {
                let dataSizeAsInt32 = ByteUtils.toInt32(try getSubBytes(4))
                return Int(dataSizeAsInt32)
            }
            else {
                return Int(dataSizeAsUInt16)
            }
        }
        else {
            return Int(dataSizeAsByte)
        }
    }
    
    func getSubBytes(_ length: Int) throws -> [UInt8] {
        if offset + length > bytes.count {
            throw ByteParserError.indexOutOfRange
        }
        let retVal = Array(bytes[offset..<offset+length])
        offset += length
        return retVal
    }
    
    func getVariableSubBytes() throws -> [UInt8] {
        //  read the command length as an unsigned 8-bit integer
        //  if the command length is 255
        //      read the command length as an unsigned 16-bit integer (2 bytes)
        //      if the command length is 65535
        //          read the message length as a *signed* 32-bit integer (4 bytes)
        //          parse message and return
        //      else
        //          parse message and return
        //  else
        //      parse message and return
        
        let dataSizeAsByte = try getSubBytes(1)[0]
        
        if dataSizeAsByte == 255 {
            let dataSizeAsUInt16 = ByteUtils.toUInt16(try getSubBytes(2))
            
            if dataSizeAsUInt16 == 65535 {
                let dataSizeAsInt32 = ByteUtils.toInt32(try getSubBytes(4))
                return try getSubBytes(Int(dataSizeAsInt32))
            }
            else {
                return try getSubBytes(Int(dataSizeAsUInt16))
            }
        }
        else {
            return try getSubBytes(Int(dataSizeAsByte))
        }
    }
}
