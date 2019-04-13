//
//  EncryptedTypesInternalTests.swift
//  EncryptedTypesTests
//
//  Created by Thomas, Jeffery on 4/11/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import XCTest
@testable import EncryptedTypes

class EncryptedTypesInternalTests: XCTestCase {

    func testSymmetric() {
        let symmetric = Symmetric()
        let text = "This is my test.  Will it work?"

        let encrypted = symmetric.encrypt(Data(text.utf8))
        let decrypted = symmetric.decrypt(encrypted)

        XCTAssertNotEqual(encrypted, Data(text.utf8))
        XCTAssertEqual(String(bytes: decrypted, encoding: .utf8), text)
    }

    func testSymmetricInitKeyIv() {
        let testKey = "This is my test key."
        let testIv = "This is my test iv."

        let symmetric = Symmetric(key: Data(testKey.utf8), iv: Data(testIv.utf8))

        XCTAssertEqual(String(bytes: symmetric.key, encoding: .utf8), testKey)
        XCTAssertEqual(String(bytes: symmetric.iv, encoding: .utf8), testIv)
    }

    func testSymmetricReuseability() {
        let symmetric1 = Symmetric()
        let symmetric2 = Symmetric(key: symmetric1.key, iv: symmetric1.iv)
        let text = "This is my test.  Will it work?"

        let encrypted = symmetric1.encrypt(Data(text.utf8))
        let decrypted = symmetric2.decrypt(encrypted)

        XCTAssertNotEqual(encrypted, Data(text.utf8))
        XCTAssertEqual(String(bytes: decrypted, encoding: .utf8), text)
    }

}