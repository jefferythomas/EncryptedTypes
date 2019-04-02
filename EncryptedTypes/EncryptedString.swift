//
//  EncryptedString.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

open class EncryptedString: Encrypted<String> {

    open override func fromData(_ data: Data?) -> String? {
        return data.flatMap { String(bytes: $0, encoding: .utf8) }
    }

    open override func toData(_ value: String?) -> Data? {
        return value?.data(using: .utf8)
     }

}