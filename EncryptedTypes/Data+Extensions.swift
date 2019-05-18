//
//  Data+Extensions.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/30/19.
//

import Foundation

// MARK: - Memory Mapping

public extension Data {
    /// Create a new instance of value based on memory mapped data.
    /// - Parameter type: The type of the instance to be created.
    /// - Throws: MemoryMappingError.typeInconsistency
    func makeInstance<Value>(of type: Value.Type) throws -> Value {
        try withUnsafeBytes { bytes in
            guard count == MemoryLayout<Value>.size, let address = bytes.baseAddress else {
                throw MemoryMappingError.typeInconsistency
            }

            return address.assumingMemoryBound(to: Value.self).pointee
        }
    }

    /// Create a map of the memory used in value.
    /// - Parameter value: The value to memory map
    init<Value>(mappingMemoryOf value: Value) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
}

// MARK: - Memory Mapping Error

/// Errors the might occur while handling memory maps of other data types.
public enum MemoryMappingError: Error {
    /// The data in the memory map does not match the specified type.
    case typeInconsistency
}

// MARK: - Random Data

internal extension Data {
    /// Create a data object of count bytes filled with random data.
    /// - Parameter count: The number of bytes of random data
    static func random(count: Int) -> Data {
        Data((0 ..< count).map { _ in .random(in: .min ... .max) })
    }
}
