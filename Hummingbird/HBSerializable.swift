//
//  HBSerializable.swift
//  Pulse
//
//  Created by Chong Han on 7/18/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

protocol HBSerializable {
    func toBytes() -> [UInt8]
    func toTypedBytes() -> [UInt8]
    var type: HBType { get }
}
