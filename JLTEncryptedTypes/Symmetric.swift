//
//  Symmetric.swift
//  JLTEncryptedTypes
//
//  Created by Jeffery Thomas on 3/29/19.
//  Copyright © 2019 JLT Source. All rights reserved.
//
// swiftlint:disable identifier_name
//

import Foundation
import CommonCrypto

internal class Symmetric {

    static let shared = Symmetric()

    func encrypt(_ data: Data) -> Data {
        return crypt(.encrypt, data)
    }

    func decrypt(_ data: Data) -> Data {
        return crypt(.decrypt, data)
    }

    // MARK: Memory lifecycle

    init(key: Data = .randomBytes(count: .keySizeAES128), iv: Data = .randomBytes(count: .blockSizeAES128)) {
        self.key = key
        self.iv = iv
    }

    let key: Data
    let iv: Data

    private func crypt(_ operation: CCOperation, _ data: Data) -> Data {
        var result = Data(count: data.count + .blockSizeAES128)
        var resultCount = 0

        let status = result.withUnsafeMutableBytes { resultBuffer in
            key.withUnsafeBytes { keyBuffer in
                iv.withUnsafeBytes { ivBuffer in
                    data.withUnsafeBytes { dataBuffer in
                        CCCrypt(operation, .aes, .pkcs7Padding,
                                keyBuffer.baseAddress, keyBuffer.count,
                                ivBuffer.baseAddress,
                                dataBuffer.baseAddress, dataBuffer.count,
                                resultBuffer.baseAddress, resultBuffer.count,
                                &resultCount)
                    }
                }
            }
        }

        guard status == 0 else { return Data() }
        result.count = resultCount
        return result
    }

}

fileprivate extension CCOperation {
    static let encrypt = CCOperation(kCCEncrypt)
    static let decrypt = CCOperation(kCCDecrypt)
}

fileprivate extension CCAlgorithm {
    static let aes = CCAlgorithm(kCCAlgorithmAES)
}

fileprivate extension CCOptions {
    static let pkcs7Padding = CCOptions(kCCOptionPKCS7Padding)
}

fileprivate extension Int {
    static let blockSizeAES128 = kCCBlockSizeAES128
    static let keySizeAES128 = kCCKeySizeAES128
}
