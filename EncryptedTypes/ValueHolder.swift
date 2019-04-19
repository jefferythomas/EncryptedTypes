//
//  ValueHolder.swift
//  EncryptedTypes
//
//  Created by Jeffery Thomas on 3/31/19.
//  Copyright © 2019 JLT Source. No rights reserved.
//

/**
 A type that exposes a value.
 */
public protocol ValueHolder {
    associatedtype Value

    /**
     Access the value contained by the `ValueHolder`.
     */
    var value: Value? { get set }
}
