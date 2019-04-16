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
        #if swift(>=5.0)
        return withUnsafeBytes { $0.baseAddress?.bindMemory(to: type, capacity: 1).pointee }
        #else
        guard count == MemoryLayout<Value>.size else { return nil }
        return withUnsafeBytes { $0.pointee }
        #endif
    }

    /**
     Map the memory from the given value of given type to a Data object.
     */
    init<Value>(memoryMapped value: Value, as type: Value.Type) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }

    /**
     Version safe access to `withUnsafeBytes(_:)`.
     */
    func withUnsafeBuffer<Result>(_ body: (UnsafeRawPointer?, Int) -> Result) -> Result {
        #if swift(>=5.0)
        return withUnsafeBytes { body($0.baseAddress, $0.count) }
        #else
        let count = self.count
        return withUnsafeBytes { body($0, count) }
        #endif
    }

    /**
     Version safe access to `withUnsafeMutableBytes(_:)`.
     */
    mutating func withUnsafeMutableBuffer<Result>(_ body: (UnsafeMutableRawPointer?, Int) -> Result) -> Result {
        #if swift(>=5.0)
        return withUnsafeMutableBytes { body($0.baseAddress, $0.count) }
        #else
        let count = self.count
        return withUnsafeMutableBytes { body($0, count) }
        #endif
    }

}
