//
//  EncryptedBool.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import Foundation

open class EncryptedBool: BaseEncrypted<Bool> {

    open override func fromData(_ data: Data?) -> Bool? {
        return data?.withUnsafeBytes { $0.baseAddress?.bindMemory(to: Bool.self, capacity: 1).pointee }
    }

    open override func toData(_ value: Bool?) -> Data? {
        return value.map { withUnsafeBytes(of: $0) { Data($0) } }
    }

}
