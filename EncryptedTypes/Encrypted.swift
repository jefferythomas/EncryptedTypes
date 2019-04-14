//
//  Encrypted.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/1/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

/**
 The base class for encrypted types that simplifies the implementation of the
 ValueHolder and Encryptor protocols. Subclasses only need to implement
 `fromData(_:)` and `toData(_:)`
 */
open class Encrypted<Value>: ValueHolder, Encryptor {

    // MARK: ValueHolder

    /**
     Temporary access to the unencrypted value.
     */
    open var value: Value? {
        get { return decrypt() }
        set { encrypt(newValue) }
    }

    // MARK: Encryptor

    /**
     Decrypt the value from a given encrypted data.
     */
    open func decrypt() -> Value? {
        return fromData(encrypted.map { symmetric.decrypt($0) })
    }

    /**
     Encrypt the given value to an encrypted data block.
     */
    open func encrypt(_ value: Value?) {
        encrypted = toData(value).map { symmetric.encrypt($0) }
    }

    // MARK: Required overrides

    /**
     Return the value from a given data object.
     */
    open func fromData(_ data: Data?) -> Value? {
        fatalError("fromData(_:) must be overloaded in a subclass")
    }

    /**
     Return a data object from the given value.
     */
    open func toData(_ value: Value?) -> Data? {
        fatalError("toData(_:) must be overloaded in a subclass")
    }

    // MARK: Memory lifecycle

    public init(symmetric: Symmetric = .shared) {
        self.symmetric = symmetric
    }

    // MARK: Private properties

    private let symmetric: Symmetric
    private var encrypted: Data?

}
