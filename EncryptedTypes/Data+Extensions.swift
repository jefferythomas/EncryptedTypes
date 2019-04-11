//
//  Data+Extensions.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/30/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

internal extension Data {

    /// Create a data object of count bytes filled with random data.
    static func randomBytes(count: Int) -> Data {
        return Data((0 ..< count).map { _ in .random(in: .min ... .max) })
    }

    func cast<Value>(as type: Value.Type) -> Value? {
        #if swift(>=5.0)
        return withUnsafeBytes { $0.baseAddress?.bindMemory(to: type, capacity: 1).pointee }
        #else
        guard count == MemoryLayout<Value>.size else { return nil }
        return withUnsafeBytes { $0.pointee }
        #endif
    }

    init<Value>(cast value: Value, as type: Value.Type) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }

    func withUnsafeBuffer<ResultType>(_ body: (UnsafeRawPointer?, Int) -> ResultType) -> ResultType {
        #if swift(>=5.0)
        return withUnsafeBytes { body($0.baseAddress, $0.count) }
        #else
        let count = self.count
        return withUnsafeBytes { body($0, count) }
        #endif
    }

    mutating func withUnsafeMutableBuffer<Result>(_ body: (UnsafeMutableRawPointer?, Int) -> Result) -> Result {
        #if swift(>=5.0)
        return withUnsafeMutableBytes { body($0.baseAddress, $0.count) }
        #else
        let count = self.count
        return withUnsafeMutableBytes { body($0, count) }
        #endif
    }

}
