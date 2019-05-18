//
//  SystemEncryptorTests.swift
//  EncryptedTypesTests
//
//  Created by Jeffery Thomas on 12/8/19.
//

@testable import EncryptedTypes
import XCTest

class SystemEncryptorTests: XCTestCase {
    func testBootstrap() {
        let defaultFactory = SystemEncryptor.factory
        defer { SystemEncryptor.bootstrap(defaultFactory) }

        // Given
        let testEncryptor = Symmetric()

        // When
        SystemEncryptor.bootstrap { testEncryptor }

        // Then
        XCTAssert(SystemEncryptor.factory() as? Symmetric === testEncryptor)
    }
}
