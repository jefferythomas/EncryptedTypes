//
//  Symmetric.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/29/19.
//

import CommonCrypto
import Foundation

// MARK: - Symmetric

/// Symmetric encryption wrapping CCCrypt
public final class Symmetric: Encryptor {
    /// A common instance of Symmetric.
    public static let shared = Symmetric()

    // MARK: Encryptor

    /// Encrypt data
    ///
    /// - Parameter data: The data to encrypt.
    /// - Returns: The encrypted data.
    public func encrypt(_ data: Data) throws -> Ciphertext {
        try crypt(CCOperation(kCCEncrypt), data)
    }

    /// Decrypt an encrypted piece of data.
    ///
    /// - Parameter ciphertext: The ecrypted data to decrypt.
    /// - Returns: The decrypted data.
    public func decrypt(_ ciphertext: Ciphertext) throws -> Data {
        try crypt(CCOperation(kCCDecrypt), ciphertext)
    }

    // MARK: Memory lifecycle

    /// Creates symmetric encryptor.
    ///
    /// - Parameters:
    ///   - key: The key for the symmetric encryption.
    ///   - iv: The iv for the symmetric encryption.
    public init(key: Data = makeRandomKey(),
                iv: Data = makeRandomIv(),
                algorithm: CCAlgorithm = CCAlgorithm(kCCAlgorithmAES),
                options: CCOptions = CCOptions(kCCOptionPKCS7Padding)) {
        self.key = key
        self.iv = iv
        self.algorithm = algorithm
        self.options = options
    }

    /// Create a random cryptography key.
    public static func makeRandomKey(count: Int = kCCKeySizeAES128) -> Data {
        .random(count: count)
    }

    /// Create a random cryptography iv.
    public static func makeRandomIv(count: Int = kCCBlockSizeAES128) -> Data {
        .random(count: count)
    }

    // MARK: Internals

    internal let key: Data
    internal let iv: Data
    internal let algorithm: CCAlgorithm
    internal let options: CCOptions

    private func crypt(_ operation: CCOperation, _ data: Data) throws -> Data {
        var result = Data(count: data.count + iv.count)
        var resultCount = 0

        let status = result.withUnsafeMutableBytes { resultBytes in
            key.withUnsafeBytes { keyBytes in
                iv.withUnsafeBytes { ivBytes in
                    data.withUnsafeBytes { dataBytes in
                        CCCrypt(operation, algorithm, options,
                                keyBytes.baseAddress, keyBytes.count,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress, dataBytes.count,
                                resultBytes.baseAddress, resultBytes.count,
                                &resultCount)
                    }
                }
            }
        }

        guard status == kCCSuccess else { throw SymmetricError.cryptorStatus(status) }
        result.count = resultCount
        return result
    }
}

// MARK: - Symmetric Error

/// Errors the might occur while doing symmetric cryptography.
enum SymmetricError: Error {
    /// A CCCryptorStatus error occurred.
    case cryptorStatus(CCCryptorStatus)
}
