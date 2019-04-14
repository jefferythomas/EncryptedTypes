//
//  EncryptedData.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 4/1/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

/**
 An encrypted wrapper for Data. The `value` property is used to access a
 temporary unencrypted value.
 */
open class EncryptedData: Encrypted<Data> {

    open override func fromData(_ data: Data?) -> Data? {
        return data
    }

    open override func toData(_ value: Data?) -> Data? {
        return value
    }

}
