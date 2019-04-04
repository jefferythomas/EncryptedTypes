//
//  EncryptedBool.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

/// An encrypted wrapper for a Bool. The `value` property is used to access a
/// temporary unencrypted value.
open class EncryptedBool: Encrypted<Bool> {

    open override func fromData(_ data: Data?) -> Bool? {
        return data?.cast(to: Bool.self)
    }

    open override func toData(_ value: Bool?) -> Data? {
        return Data(castFrom: value)
    }

}
