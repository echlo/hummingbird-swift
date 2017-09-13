//
//  HBDecodable.swift
//  Pulse
//
//  Created by Chong Han on 7/20/16.
//  Copyright © 2016 Echlo, Inc. All rights reserved.
//

import Foundation

public protocol HBDecodable {
    init(decoder: HBDecoder) throws
}

public protocol HBEncodable {
    func encode(_ encoder: HBEncoder)
}
