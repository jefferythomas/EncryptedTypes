//
//  EncryptedInt.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

open class EncryptedInt: Encrypted {

    public let symmetric: Symmetric

    open var int: Int? {
        get { return decrypt(encrypted) }
        set { encrypted = encrypt(newValue) }
    }

    open func fromData(_ data: Data?) -> Int? {
        return data?.withUnsafeBytes { $0.baseAddress?.bindMemory(to: Int.self, capacity: 1).pointee }
    }

    open func toData(_ value: Int?) -> Data? {
        return value.map { withUnsafeBytes(of: $0) { Data($0) } }
    }

    // MARK: Memory lifecycle

    init(symmetric: Symmetric = .shared) {
        self.symmetric = symmetric
    }

    // MARK: Private properties

    private var encrypted: Data?

}
