//
//  EncryptedBool.swift
//  JLTEncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. All rights reserved.
//

import Foundation

open class EncryptedBool: Encrypted {

    public let symmetric: Symmetric

    open var bool: Bool? {
        get { return decrypt(encrypted) }
        set { encrypted = encrypt(newValue) }
    }

    open func fromData(_ data: Data?) -> Bool? {
        return data?.withUnsafeBytes { $0.baseAddress?.bindMemory(to: Bool.self, capacity: 1).pointee }
    }

    open func toData(_ value: Bool?) -> Data? {
        return value.map { withUnsafeBytes(of: $0) { Data($0) } }
    }

    // MARK: Memory lifecycle

    init(symmetric: Symmetric = .shared) {
        self.symmetric = symmetric
    }

    // MARK: Private properties

    private var encrypted: Data?

}
