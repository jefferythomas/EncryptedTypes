//
//  EncryptedInt.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

/// An encrypted wrapper for an Int. The `value` property is used to access a
/// temporary unencrypted value.
open class EncryptedInt: Encrypted<Int> {

    open override func fromData(_ data: Data?) -> Int? {
        return data?.cast(to: Int.self)
    }

    open override func toData(_ value: Int?) -> Data? {
        return Data(castFrom: value)
    }

}
