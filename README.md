# EncryptedTypes
In memory encryption for data

## Installing

### Carthage

    github "jefferythomas/EncryptedTypes" ~> 2.0

## Usage

### Basic Types

Lets say you have data objects that contain personally identifiable information

```swift
struct Employee {
    var name: String?
    var age: Int?
    var salary: Double?
}
```

To protect the PII in memory encrypted types can be used.

```swift
struct Employee {
    var name: Encrypted<String>
    var age: Encrypted<Int>
    var salary: Encrypted<Double>
}
```

### Codable types

If member level protection is to granular, instances of `Codable` types can be
encrypted in their entirety.

```swift
struct Employee: Codable {
    var name: String?
    var age: Int?
    var salary: Double?
}
```

First, extend the type to conform to `Encryptable`.

```swift
extension Employee: Encryptable { }
```

After that, encrypted instances can be created.

```swift
let employee = Employee(name: "Bob Bobson", age: 37, salary: 80_000).encrypted()
```
