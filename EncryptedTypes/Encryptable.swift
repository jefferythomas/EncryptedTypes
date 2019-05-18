//
//  Encryptable.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 5/16/19.
//

import Foundation

// MARK: - Encryptable

/// A type that can be encrypted and decrypted.
public protocol Encryptable {
    /// Create an instance from an encryptable data object.
    ///
    /// - Parameter data: A data object that can be encrypted.
    init(fromEncryptableData data: Data) throws

    /// Convert the instance into a data object that can be encrypted.
    func makeEncryptableData() throws -> Data
}

// MARK: - Encryptable Error

/// Errors the might occur while handling encryptables.
public enum EncryptableError: Error {
    /// The encryptable data could not be decoded.
    case decodingFailed
}

// MARK: - Encryptable Bool

extension Bool: Encryptable {
    public init(fromEncryptableData data: Data) throws {
        self = try data.makeInstance(of: Bool.self)
    }

    public func makeEncryptableData() throws -> Data {
        return Data(mappingMemoryOf: self)
    }
}

// MARK: - Encryptable Data

extension Data: Encryptable {
    public init(fromEncryptableData data: Data) throws {
        self.init(data)
    }

    public func makeEncryptableData() throws -> Data {
        return self
    }
}

// MARK: - Encryptable Double

extension Double: Encryptable {
    public init(fromEncryptableData data: Data) throws {
        self = try data.makeInstance(of: Double.self)
    }

    public func makeEncryptableData() throws -> Data {
        return Data(mappingMemoryOf: self)
    }
}

// MARK: - Encryptable Int

extension Int: Encryptable {
    public init(fromEncryptableData data: Data) throws {
        self = try data.makeInstance(of: Int.self)
    }

    public func makeEncryptableData() throws -> Data {
        return Data(mappingMemoryOf: self)
    }
}

// MARK: - Encryptable String

extension String: Encryptable {
    public init(fromEncryptableData data: Data) throws {
        guard let string = String(data: data, encoding: .utf8) else { throw EncryptableError.decodingFailed }
        self = string
    }

    public func makeEncryptableData() throws -> Data {
        return Data(utf8)
    }
}

// MARK: - Encryptable Codable

extension Encryptable where Self: Codable {
    public init(fromEncryptableData data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }

    public func makeEncryptableData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
