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

    func testSymmetric() {
        let symmetric = Symmetric()
        let text = "This is my test.  Will it work?"

        let encrypted = symmetric.encrypt(Data(text.utf8))
        let decrypted = symmetric.decrypt(encrypted)

        XCTAssertNotEqual(encrypted, Data(text.utf8))
        XCTAssertEqual(String(bytes: decrypted, encoding: .utf8), text)
    }

}
