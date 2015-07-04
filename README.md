Iterator
========

[![License][license-image]][license-url]

Data structures that allow to iterate over a sequence of elements.

## Description

implement `Iteratable` protocol.

```swift
public protocol Iteratable {

    typealias Element

    var hasNext: Bool { get }
    func next() -> Element?
}
```

## Requirements

- Built for Swift 1.2
- Runs on iOS 8 / OS X 10.10 and above

## Usage

## Methods

## Installation

## Author

[to4iki](https://github.com/to4iki)

## Licence

[MIT](http://to4iki.mit-license.org/)

[license-url]: http://to4iki.mit-license.org/
[license-image]: http://img.shields.io/badge/license-MIT-brightgreen.svg
