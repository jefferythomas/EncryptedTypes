//
//  EncryptedTypesInternalTests.swift
//  EncryptedTypesTests
//
//  Created by Jeffery Thomas on 4/11/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

@testable import EncryptedTypes
import XCTest

class EncryptedTypesInternalTests: XCTestCase {
    func testCast() {
        let value = Data(memoryMapped: 1, as: Int.self)
        XCTAssertEqual(value.memoryMapped(as: Int.self), 1)
    }

    func testInvalidCastAs() {
        let invalidValue = Data()
        XCTAssertEqual(invalidValue.memoryMapped(as: Int.self), nil)
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
