# Hummingbird-Swift

This is an implementation of the Hummingbird parser and serializer for Swift.

## Synopsis

Hummingbird is a binary serialization format. See the [spec](https://github.com/echlo/hummingbird) 
for details and format specification.

## Version history

2.0.0 - A straightforward upgrade to Swift 4.0

1.0.0 - Initial release

## Installing

### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. 
You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Hummingbird into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Hummingbird', :git => 'https://github.com/echlo/hummingbird-swift'
end
```

Then, run the following command:

```bash
$ pod install
```

Import Hummingbird at the top of any file that needs to call the framework

```swift
import Hummingbird
```

## Demo

Here's an [online converter](https://echlo.github.io/hummingbird-js/)

## Usage

Hummingbird can be used to serialize Swift classes or structs into HBON. This
works best if the class or struct extends `HBEncodable` and `HBDecodable` and
provide custom implementations for serializing or rehydrating the object.

```swift
struct Event: HBEncodable, HBDecodable {
    let timestamp: Double
    let level: Double
    
    init(timestamp: Double, level: Double) {
        self.timestamp = timestamp
        self.level = level
    }
    
    init(decoder: HBDecoder) throws {
        timestamp = (try? decoder.decode("timestamp")) ?? -1
        level = (try? decoder.decode("level")) ?? 0.0
    }
    
    func encode(_ encoder: HBEncoder) {
        encoder.encode(timestamp, forKey: "timestamp")
        encoder.encode(level, forKey: "level")
    }
}
```

Then simple call the `serialize` and `deserialize` methods

```swift
do {
    let eventBytes = try HummingBird.serialize(event)    
} catch {
    // handle serialization error
}

do {
    response: Event = try HummingBird.deserialize(eventBytes)
} catch {
    // handle deserialization error
}
        

```


### Non-object serialization and deserialization

This library provides simple methods to serialize and deserialize variables that
are not classes or structs.

```swift
do {
    let data: [UInt8] = try HummingBird.serializeAsRoot(stringVariable)            
} catch {
    // handle serialization error
}

do {
    let stringVar: string = try HummingBird.deserializeAsRoot(data)    
} catch {
    // handle deserialization error
}
```

(More comprehensive documentation TBD)

## Tests

This project includes XCTestCases

## Contributors

Current maintainer
- [Chong Han Chua](https://github.com/johncch)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details