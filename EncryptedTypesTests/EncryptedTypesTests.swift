//
//  EncryptedTypesTests.swift
//  EncryptedTypesTests
//
//  Created by Jeffery Thomas on 3/29/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import XCTest
@testable import EncryptedTypes

class EncryptedTypesTests: XCTestCase {

    func testEncryptedBool() {
        let value = true
        let encryptedBool = EncryptedBool()
        XCTAssertEqual(encryptedBool.value, nil)

        encryptedBool.value = value
        XCTAssertEqual(encryptedBool.value, value)

        encryptedBool.value = nil
        XCTAssertEqual(encryptedBool.value, nil)
    }

    func testEncryptedData() {
        let value = Data("This is my test.  Will it work?".utf8)
        let encryptedData = EncryptedData()
        XCTAssertEqual(encryptedData.value, nil)

        encryptedData.value = value
        XCTAssertEqual(encryptedData.value, value)

        encryptedData.value = nil
        XCTAssertEqual(encryptedData.value, nil)
    }

    func testEncryptedDouble() {
        let value = 123456789.987654321
        let encryptedDouble = EncryptedDouble()
        XCTAssertEqual(encryptedDouble.value, nil)

        encryptedDouble.value = value
        XCTAssertEqual(encryptedDouble.value, value)

        encryptedDouble.value = nil
        XCTAssertEqual(encryptedDouble.value, nil)
    }

    func testEncryptedInt() {
        let value = 123456789
        let encryptedInt = EncryptedInt()
        XCTAssertEqual(encryptedInt.value, nil)

        encryptedInt.value = value
        XCTAssertEqual(encryptedInt.value, value)

        encryptedInt.value = nil
        XCTAssertEqual(encryptedInt.value, nil)
    }

    func testEncryptedString() {
        let value = "This is my test.  Will it work?"
        let encryptedString = EncryptedString()
        XCTAssertEqual(encryptedString.value, nil)

        encryptedString.value = value
        XCTAssertEqual(encryptedString.value, value)

        encryptedString.value = nil
        XCTAssertEqual(encryptedString.value, nil)
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
