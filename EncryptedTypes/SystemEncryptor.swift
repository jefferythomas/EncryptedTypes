//
//  SystemEncryptor.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 12/8/19.
//

import Foundation

// MARK: - System Encryptor

/// The default encryptor used by Encrypted.
public struct SystemEncryptor {
    /// Called once at app startup to specify which Encryptor is used by Encrypted.
    /// - Parameter factory: A factory method that produces an Encryptor.
    public static func bootstrap(_ factory: @escaping () -> Encryptor) {
        self.factory = factory
    }

    /// A factory to produce an Encryptor.
    public private(set) static var factory: () -> Encryptor = { Symmetric.shared }
}
