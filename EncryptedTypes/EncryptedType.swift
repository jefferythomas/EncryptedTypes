//
//  EncryptedType.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

/**
 A wrapper for a type that provides in memory encryption its value. The value
 can be accessed via the value property.

 An EncryptedType can be held for the lifetime of a process without the risk of
 exposing the data to a malicious process
 */
public protocol EncryptedType {

    associatedtype Value

    /**
     Temporary access to the unencrypted value.
     */
    var value: Value? { get set }

    /**
     Return the value from a given data object.
     */
    func fromData(_ data: Data?) -> Value?

    /**
     Return a data object from the given value.
     */
    func toData(_ value: Value?) -> Data?

}

public extension EncryptedType {

    var symmetric: Symmetric { return .shared }

    /**
     Encrypt the given value to an encrypted data block.
     */
    func encrypt(_ value: Value?) -> Data? {
        return toData(value).map { symmetric.encrypt($0) }
    }

    /**
     Decrypt the value from a given encrypted data.
     */
    func decrypt(_ encrypted: Data?) -> Value? {
        return fromData(encrypted.map { symmetric.decrypt($0) })
    }

}
