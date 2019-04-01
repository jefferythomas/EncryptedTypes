//
//  JLTEncryptedTypesTests.swift
//  JLTEncryptedTypesTests
//
//  Created by Jeffery Thomas on 3/29/19.
//  Copyright © 2019 JLT Source. All rights reserved.
//

import XCTest
@testable import JLTEncryptedTypes

class JLTEncryptedTypesTests: XCTestCase {

    func testEncryptedBool() {
        let value = true
        let encryptedBool = EncryptedBool()

        encryptedBool.bool = value

        XCTAssertEqual(encryptedBool.bool, value)
    }

    func testEncryptedData() {
        let value = Data("This is my test.  Will it work?".utf8)
        let encryptedBool = EncryptedData()

        encryptedBool.data = value

        XCTAssertEqual(encryptedBool.data, value)
    }

    func testEncryptedDouble() {
        let value = 123456789.987654321
        let encryptedDouble = EncryptedDouble()

        encryptedDouble.double = value

        XCTAssertEqual(encryptedDouble.double, value)
    }

    func testEncryptedInt() {
        let value = 123456789
        let encryptedInt = EncryptedInt()

        encryptedInt.int = value

        XCTAssertEqual(encryptedInt.int, value)
    }

    func testEncryptedString() {
        let value = "This is my test.  Will it work?"
        let encryptedString = EncryptedString()

        encryptedString.string = value

        XCTAssertEqual(encryptedString.string, value)
    }

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
