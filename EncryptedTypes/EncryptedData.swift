//
//  EncryptedData.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/1/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

open class EncryptedData: Encrypted {

    public let symmetric: Symmetric

    open var data: Data? {
        get { return decrypt(encrypted) }
        set { encrypted = encrypt(newValue) }
    }

    open func fromData(_ data: Data?) -> Data? {
        return data
    }

    open func toData(_ value: Data?) -> Data? {
        return value
    }

    // MARK: Memory lifecycle

    init(symmetric: Symmetric = .shared) {
        self.symmetric = symmetric
    }

    // MARK: Private properties

    private var encrypted: Data?

}
