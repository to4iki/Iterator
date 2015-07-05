Iterator
========

[![Carthage compatible][carthage-image]][carthage-url]
[![License][license-image]][license-url]

Mutable data structures that allow to iterate over a sequence of elements.  
like [scala.collection.Iterator](http://www.scala-lang.org/api/current/index.html#scala.collection.Iterator)

## Description

implement `Iterable` protocol.

```swift
public protocol Iterable {

    typealias Element

    var hasNext: Bool { get }
    mutating func next() -> Element?
}
```

## Requirements

- Built for Swift 1.2
- Runs on iOS 8 / OS X 10.10 and above

## Usage

```swift
var it = Iterator([1,2,3,4,5])

while it.hasNext {
    it.next()
}
```

## Documentation
- The [tests](IteratorTests) contain (trivial) usage examples for every feature

## Installation

### [Carthage](https://github.com/Carthage/Carthage)
Add the following to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
github "to4iki/Iterator"
```

Run `carthage update` and follow the steps as described in Carthage's [README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).


## Author

[to4iki](https://github.com/to4iki)

## Licence

[MIT](http://to4iki.mit-license.org/)

[carthage-url]: https://github.com/Carthage/Carthage
[carthage-image]: https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat

[license-url]: http://to4iki.mit-license.org/
[license-image]: http://img.shields.io/badge/license-MIT-brightgreen.svg
