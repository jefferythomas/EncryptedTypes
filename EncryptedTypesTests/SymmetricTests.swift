//
//  SymmetricTests.swift
//  EncryptedTypesTests
//
//  Created by Jeffery Thomas on 4/11/19.
//

@testable import EncryptedTypes
import XCTest

class SymmetricTests: XCTestCase {
    func testSymmetric() throws {
        let symmetric = Symmetric()
        let text = "This is my test.  Will it work?"

        let encrypted = try symmetric.encrypt(Data(text.utf8))
        let decrypted = try symmetric.decrypt(encrypted)

        XCTAssertNotEqual(encrypted, Data(text.utf8))
        XCTAssertEqual(String(data: decrypted, encoding: .utf8), text)
    }

    func testSymmetricInitKeyIv() {
        let testKey = "This is my test key."
        let testIv = "This is my test iv."

        let symmetric = Symmetric(key: Data(testKey.utf8), iv: Data(testIv.utf8))

        XCTAssertEqual(String(data: symmetric.key, encoding: .utf8), testKey)
        XCTAssertEqual(String(data: symmetric.iv, encoding: .utf8), testIv)
    }

    func testSymmetricReuseability() throws {
        let symmetric1 = Symmetric()
        let symmetric2 = Symmetric(key: symmetric1.key, iv: symmetric1.iv)
        let text = "This is my test.  Will it work?"

        let encrypted = try symmetric1.encrypt(Data(text.utf8))
        let decrypted = try symmetric2.decrypt(encrypted)

        XCTAssertNotEqual(encrypted, Data(text.utf8))
        XCTAssertEqual(String(data: decrypted, encoding: .utf8), text)
    }
}
