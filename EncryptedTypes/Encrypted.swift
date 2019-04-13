//
//  Encrypted.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/1/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

/**
  The base class for encrypted types that simplifies the implementation of the
  EncryptedType protocol. Subclasses only need to implement `fromData(_:)` and
  `toData(_:)`
 */
open class Encrypted<Value>: EncryptedType {

    public let symmetric: Symmetric

    /**
     Temporary access to the unencrypted value.
     */
    open var value: Value? {
        get { return decrypt(encrypted) }
        set { encrypted = encrypt(newValue) }
    }

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

    private var encrypted: Data?

}
