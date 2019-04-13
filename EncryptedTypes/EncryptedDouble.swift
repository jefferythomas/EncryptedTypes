//
//  EncryptedDouble.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

/**
 An encrypted wrapper for a Double. The `value` property is used to access a
 temporary unencrypted value.
 */
open class EncryptedDouble: Encrypted<Double> {

    open override func fromData(_ data: Data?) -> Double? {
        return data?.cast(as: Double.self)
    }

    open override func toData(_ value: Double?) -> Data? {
        return value.map { Data(cast: $0, as: Double.self) }
    }

}
