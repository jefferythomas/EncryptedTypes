//
//  EncryptedTypesTests.swift
//  EncryptedTypesTests
//
//  Created by Jeffery Thomas on 3/29/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

import EncryptedTypes
import XCTest

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
        let value = 123_456_789.987654321
        let encryptedDouble = EncryptedDouble()
        XCTAssertEqual(encryptedDouble.value, nil)

        encryptedDouble.value = value
        XCTAssertEqual(encryptedDouble.value, value)

        encryptedDouble.value = nil
        XCTAssertEqual(encryptedDouble.value, nil)
    }

    func testEncryptedInt() {
        let value = 123_456_789
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
}
