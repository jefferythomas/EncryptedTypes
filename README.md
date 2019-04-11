# EncryptedTypes
In memory encryption for data

## Installing

### Carthage

    github "jefferythomas/EncryptedTypes" ~> 1.0

## Usage

Lets say you have data objects that contain personally identifiable information

    struct Employee {
        var name: String?
        var age: Int?
        var salary: Double?
    }

To protect the PII in memory encrypted types can be used.

    struct Employee {
        var name: EncryptedString
        var age: EncryptedInt
        var salary: EncryptedDouble
    }
