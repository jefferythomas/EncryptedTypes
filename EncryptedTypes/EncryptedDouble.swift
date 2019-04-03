//
//  EncryptedDouble.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

/// An encrypted wrapper for a Double. The `value` property is used to access a
/// temporary unencrypted value.
open class EncryptedDouble: Encrypted<Double> {

    open override func fromData(_ data: Data?) -> Double? {
        return data?.withUnsafeBytes { $0.baseAddress?.bindMemory(to: Double.self, capacity: 1).pointee }
    }

    open override func toData(_ value: Double?) -> Data? {
        return value.map { withUnsafeBytes(of: $0) { Data($0) } }
    }

}
