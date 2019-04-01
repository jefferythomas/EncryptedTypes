//
//  EncryptedString.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

open class EncryptedString: Encrypted {

    public let symmetric: Symmetric

    open var string: String? {
        get { return decrypt(encrypted) }
        set { encrypted = encrypt(newValue) }
    }

    open func fromData(_ data: Data?) -> String? {
        return data.flatMap { String(bytes: $0, encoding: .utf8) }
    }

    open func toData(_ value: String?) -> Data? {
        return value?.data(using: .utf8)
     }

    // MARK: Memory lifecycle

    init(symmetric: Symmetric = .shared) {
        self.symmetric = symmetric
    }

    // MARK: Private properties

    private var encrypted: Data?

}
