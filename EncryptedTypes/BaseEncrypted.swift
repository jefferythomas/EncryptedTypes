//
//  BaseEncrypted.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/1/19.
//  Copyright © 2019 JLT Source. All rights reserved.
//

import Foundation

open class BaseEncrypted<Value>: Encrypted {

    public let symmetric: Symmetric

    open var value: Value? {
        get { return decrypt(encrypted) }
        set { encrypted = encrypt(newValue) }
    }

    open func fromData(_ data: Data?) -> Value? {
        fatalError("fromData(_:) must be overloaded in a subclass")
    }

    open func toData(_ value: Value?) -> Data? {
        fatalError("toData(_:) must be overloaded in a subclass")
    }

    // MARK: Memory lifecycle

    init(symmetric: Symmetric = .shared) {
        self.symmetric = symmetric
    }

    // MARK: Private properties

    private var encrypted: Data?

}
