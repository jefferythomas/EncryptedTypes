//
//  Encryptor.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 5/22/19.
//

import Foundation

// MARK: - Encryptor

/// A protocol to handle encrypting data into ciphertext and decrypting ciphertext back to data.
public protocol Encryptor {
    /// Ciphertext is the enctyped data.
    typealias Ciphertext = Data

    /// Convert data into ciphertext (enctyped data).
    /// - Parameter data: The data to encrypt.
    /// - Returns: The ciphertext of the data.
    func encrypt(_ data: Data) throws -> Ciphertext

    /// Convert ciphertext (encrypted data) into the plaintext data.
    /// - Parameter ciphertext: The ciphertext to decrypt.
    /// - Returns: The plaintext data.
    func decrypt(_ ciphertext: Ciphertext) throws -> Data
}
