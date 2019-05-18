//
//  EncryptedTests.swift
//  EncryptedTypesTests
//
//  Created by Jeffery Thomas on 3/29/19.
//

@testable import EncryptedTypes
import XCTest

class EncryptedTests: XCTestCase {
    func testEncryptedBool() {
        let value = true
        var encryptedBool = Encrypted<Bool>()
        XCTAssertEqual(encryptedBool.value, nil)

        encryptedBool.value = value
        XCTAssertEqual(encryptedBool.value, value)

        encryptedBool.value = nil
        XCTAssertEqual(encryptedBool.value, nil)
    }

    func testEncryptedData() {
        let value = Data("This is my test.  Will it work?".utf8)
        var encryptedData = Encrypted<Data>()
        XCTAssertEqual(encryptedData.value, nil)

        encryptedData.value = value
        XCTAssertEqual(encryptedData.value, value)

        encryptedData.value = nil
        XCTAssertEqual(encryptedData.value, nil)
    }

    func testEncryptedDouble() {
        let value = 123_456_789.987654321
        var encryptedDouble = Encrypted<Double>()
        XCTAssertEqual(encryptedDouble.value, nil)

        encryptedDouble.value = value
        XCTAssertEqual(encryptedDouble.value, value)

        encryptedDouble.value = nil
        XCTAssertEqual(encryptedDouble.value, nil)
    }

    func testEncryptedInt() {
        let value = 123_456_789
        var encryptedInt = Encrypted<Int>()
        XCTAssertEqual(encryptedInt.value, nil)

        encryptedInt.value = value
        XCTAssertEqual(encryptedInt.value, value)

        encryptedInt.value = nil
        XCTAssertEqual(encryptedInt.value, nil)
    }

    func testEncryptedString() {
        let value = "This is my test.  Will it work?"
        var encryptedString = Encrypted<String>()
        XCTAssertEqual(encryptedString.value, nil)

        encryptedString.value = value
        XCTAssertEqual(encryptedString.value, value)

        encryptedString.value = nil
        XCTAssertEqual(encryptedString.value, nil)
    }

    func testEncryptedStringInitValue() {
        let encryptedString = Encrypted<String>(value: "This is my test.  Will it work?")
        XCTAssertEqual(encryptedString.value, "This is my test.  Will it work?")
    }

    func testCodeable() {
        let encryptedTest = TestCodable(string: "test", double: 123, bool: true).encrypted()
        XCTAssertEqual(encryptedTest.value?.string, "test")
        XCTAssertEqual(encryptedTest.value?.double, 123)
        XCTAssertEqual(encryptedTest.value?.bool, true)
    }

    func testCodeableWrapper() throws {
        let original = TestStructContainingEncrypted(encrypted: "wrapper test".encrypted())
        let data = try JSONEncoder().encode(original)
        let jsonified = try JSONDecoder().decode(TestStructContainingEncrypted.self, from: data)

        XCTAssertEqual(original.encrypted.value, "wrapper test")
        XCTAssertEqual(String(data: data, encoding: .utf8), #"{"encrypted":"wrapper test"}"#)
        XCTAssertEqual(jsonified.encrypted.value, "wrapper test")
    }

    func testCodeableWrapperWithNil() throws {
        let original = TestStructContainingEncrypted(encrypted: Encrypted(value: nil))
        let data = try JSONEncoder().encode(original)
        let jsonified = try JSONDecoder().decode(TestStructContainingEncrypted.self, from: data)

        XCTAssertNil(original.encrypted.value)
        XCTAssertEqual(String(data: data, encoding: .utf8), #"{"encrypted":null}"#)
        XCTAssertNil(jsonified.encrypted.value)
    }

    struct TestCodable: Codable, Encryptable {
        let string: String
        let double: Double
        let bool: Bool
    }

    struct TestStructContainingEncrypted: Codable {
        let encrypted: Encrypted<String>
    }
}
