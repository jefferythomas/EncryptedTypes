//
//  Encrypted.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

public protocol Encrypted {

    associatedtype Value

    var symmetric: Symmetric { get }

    func encrypt(_ value: Value?) -> Data?
    func decrypt(_ encrypted: Data?) -> Value?

    func fromData(_ data: Data?) -> Value?
    func toData(_ value: Value?) -> Data?

}

public extension Encrypted {

    var symmetric: Symmetric { return .shared }

    func encrypt(_ value: Value?) -> Data? {
        return toData(value).map { symmetric.encrypt($0) }
    }

    func decrypt(_ encrypted: Data?) -> Value? {
        return fromData(encrypted.map { symmetric.decrypt($0) })
    }

}
