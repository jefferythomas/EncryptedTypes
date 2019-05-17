//
//  Symmetric.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/29/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import CommonCrypto

public final class Symmetric {
    public static let shared = Symmetric()

    public func encrypt(_ data: Data) -> Data {
        return crypt(CCOperation(kCCEncrypt), data)
    }

    public func decrypt(_ data: Data) -> Data {
        return crypt(CCOperation(kCCDecrypt), data)
    }

    // MARK: Memory lifecycle

    public init(key: Data = createKey(), iv: Data = createIv()) { // swiftlint:disable:this identifier_name
        self.key = key
        self.iv = iv
    }

    public static func createKey() -> Data {
        return .randomBytes(count: kCCKeySizeAES128)
    }

    public static func createIv() -> Data {
        return .randomBytes(count: kCCBlockSizeAES128)
    }

    // MARK: Internal data

    internal let key: Data
    internal let iv: Data // swiftlint:disable:this identifier_name

    // MARK: Private methods

    private func crypt(_ operation: CCOperation, _ data: Data) -> Data {
        var result = Data(count: data.count + kCCBlockSizeAES128)
        var resultCount = 0

        let status = result.withUnsafeMutableBytes { resultBytes in
            key.withUnsafeBytes { keyBytes in
                iv.withUnsafeBytes { ivBytes in
                    data.withUnsafeBytes { dataBytes in
                        CCCrypt(operation, CCAlgorithm(kCCAlgorithmAES), CCOptions(kCCOptionPKCS7Padding),
                                keyBytes.baseAddress, keyBytes.count,
                                ivBytes.baseAddress,
                                dataBytes.baseAddress, dataBytes.count,
                                resultBytes.baseAddress, resultBytes.count,
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
