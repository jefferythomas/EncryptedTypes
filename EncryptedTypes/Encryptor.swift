//
//  Encryptor.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/12/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

/**
 An encryptor that can encrypt and decrypt a value.
 */
public protocol Encryptor {
    associatedtype Value

    /**
     Decrypt a value from a given encrypted data.
     */
    nonmutating func decrypt() -> Value?

    /**
     Encrypt a given value to an encrypted data block.
     */
    mutating func encrypt(_ value: Value?)
}
