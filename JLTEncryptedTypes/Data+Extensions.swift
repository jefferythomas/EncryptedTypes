//
//  Data+Extensions.swift
//  JLTEncryptedTypes
//
//  Created by Jeffery Thomas on 3/30/19.
//  Copyright © 2019 JLT Source. All rights reserved.
//

import Foundation

internal extension Data {

    static func randomBytes(count: Int) -> Data {
        return Data((0 ..< count).map { _ in .random(in: .min ... .max) })
    }

}
