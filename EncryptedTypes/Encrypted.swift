//
//  Encrypted.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/1/19.
//

// MARK: - Encrypted

/// A wrapper that encrypts a value in memory.
///
/// The encrypted value can be set and retrieved.
public struct Encrypted<Value: Encryptable> {
    /// Temporary access to the unencrypted value.
    public var value: Value? {
        get { try? fetch() }
        set { try? save(newValue) }
    }

    /// Decrypt the value.
    public func fetch() throws -> Value? {
        guard let ciphertext = ciphertext else { return nil }
        let encryptableData = try encryptor.decrypt(ciphertext)

        return try Value(fromEncryptableData: encryptableData)
    }

    /// Save an encrypted copy of the value.
    /// - Parameter value: The new value to encrypt.
    public mutating func save(_ value: Value?) throws {
        if let encryptableData = try value?.makeEncryptableData() {
            ciphertext = try encryptor.encrypt(encryptableData)
        } else {
            ciphertext = nil
        }
    }

    /// Creates a new encrypted value.
    ///
    /// The default encryptor is used.
    ///
    ///   - value: *optional* The initial value. Defaults to nil.
    public init(value: Value? = nil) {
        self = Encrypted(value: value, encryptor: SystemEncryptor.factory())
    }

    /// Creates a new encrypted value.
    ///
    /// - Parameters:
    ///   - value: *optional* The initial value. Defaults to nil.
    ///   - encryptor: The encryptor that encrypts and decrypts the value.
    public init(value: Value? = nil, encryptor: Encryptor) {
        self.encryptor = encryptor
        try? save(value)
    }

    private let encryptor: Encryptor
    private var ciphertext: Encryptor.Ciphertext?
}

// MARK: - Encryptable Encrypted

extension Encryptable {
    /// Return an encrypted instance.
    func encrypted() -> Encrypted<Self> {
        Encrypted(value: self)
    }
}

// MARK: - Encrypted Codable

extension Encrypted: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self.init(value: nil)
        } else {
            let value = try container.decode(Value.self)
            self.init(value: value)
        }
    }
}

extension Encrypted: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        if let value = value {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
}
