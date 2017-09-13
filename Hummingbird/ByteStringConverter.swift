//
//  ByteStringConverter.swift
//  KrumIphoneClient
//
//  Created by Peter Turner on 7/29/15.
//  Copyright (c) 2015 Krum. All rights reserved.
//

import Foundation

class ByteStringConverter{
    /*  For Swift 2.0
    func byteArrayToBase64(bytes: [UInt8]) -> String {
    let nsdata = NSData(bytes: bytes, length: bytes.count)
    let base64Encoded = nsdata.base64EncodedStringWithOptions([]);
    return base64Encoded;
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
    if let nsdata = NSData(base64EncodedString: base64String, options: []) {
    var bytes = [UInt8](count: nsdata.length, repeatedValue: 0)
    nsdata.getBytes(&bytes, length: bytes.count)
    return bytes
    }
    return nil // Invalid input
    }
    */

    static func byteArrayToBase64(_ bytes: [UInt8]) -> String {
        let nsdata = Data(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
        let base64Encoded = nsdata.base64EncodedString(options: []);

        if base64Encoded == "" {
            fatalError("problem during base64 encode")
        }

        return base64Encoded;
    }
    
    static func base64ToByteArray(_ base64String: String) -> [UInt8]? {
        if base64String == "" {
            return nil
        }
        
        if let nsdata = Data(base64Encoded: base64String, options: []) {
            var bytes = [UInt8](repeating: 0, count: nsdata.count)
            (nsdata as NSData).getBytes(&bytes, length: nsdata.count)
            return bytes
        }
        return nil // Invalid input
    }

    static func bytesToString(_ bytes: [UInt8]) -> String {
        if bytes.count == 0 {
            return ""
        }
        
        var encodedString = ""
        var decoder = UTF8()
        var generator = bytes.makeIterator()
        var finished: Bool = false
        repeat {
            let decodingResult = decoder.decode(&generator)
            switch decodingResult {
            case .scalarValue(let char):
                encodedString.append(String(char))
            case .emptyInput:
                finished = true
                    /* ignore errors and unexpected values */
            case .error:
                finished = true
//            default:
//                finished = true
            }
        } while (!finished)
        return encodedString
    }

    static func stringToBytes(_ str: String) -> [UInt8] {
        var decodedBytes : [UInt8] = []
        for b in str.utf8 {
            decodedBytes.append(b)
        }
        return decodedBytes
    }
}
