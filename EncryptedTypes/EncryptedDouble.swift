//
//  EncryptedDouble.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

/**
 An encrypted wrapper for a Double. The `value` property is used to access a
 temporary unencrypted value.
 */
open class EncryptedDouble: Encrypted<Double> {
    open override func fromData(_ data: Data?) -> Double? {
        return data?.memoryMapped(as: Double.self)
    }

    open override func toData(_ value: Double?) -> Data? {
        return value.map { Data(memoryMapped: $0, as: Double.self) }
    }
}
