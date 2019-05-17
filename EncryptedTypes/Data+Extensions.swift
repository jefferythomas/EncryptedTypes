//
//  Data+Extensions.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/30/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

internal extension Data {
    /**
     Create a data object of count bytes filled with random data.
     */
    static func randomBytes(count: Int) -> Data {
        return Data((0 ..< count).map { _ in .random(in: .min ... .max) })
    }

    /**
     Map the memory in data to the specified type.
     */
    func memoryMapped<Value>(as type: Value.Type) -> Value? {
        guard count == MemoryLayout<Value>.size else { return nil }
        return withUnsafeBytes { $0.baseAddress?.assumingMemoryBound(to: Value.self).pointee }
    }

    /**
     Map the memory from the given value of given type to a Data object.
     */
    init<Value>(memoryMapped value: Value, as _: Value.Type) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
}
