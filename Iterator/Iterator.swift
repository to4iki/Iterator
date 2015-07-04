//
//  Iterator.swift
//  Iterator
//
//  Created by to4iki on 6/27/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

public protocol Iteratable {
    
    typealias Element
    
    var hasNext: Bool { get }
    mutating func next() -> Element?
}

/**
*  Mutable Data structures that allow to iterate over a sequence of elements.
*/
public struct Iterator<T: SequenceType>: Iteratable {
    
    private let sequence: T
    private lazy var generate: T.Generator = self.sequence.generate()
    private var index: Int = 0
    
    public init(_ sequence: T) {
        self.sequence = sequence
    }
    
    /// MARK: protocol
    
    public var hasNext: Bool {
        return index < toArray().count
    }
    
    public mutating func next() -> T.Generator.Element? {
        index++
        return generate.next()
    }
    
    /// MARK: size
    
    public var isEmpty: Bool {
        return !hasNext
    }
    
    public mutating func size() -> Int {
        var i = 0
        while let next = next() {
            i++
        }
        return i
    }
    
    /// MARK: other iterator
    
    public func reverse() -> Iterator<[T.Generator.Element]> {
        return Iterator<[T.Generator.Element]>(toArray().reverse())
    }
    
    /// MARK: convert
    
    public func toArray() -> Array<T.Generator.Element> {
        return Array(sequence)
    }
    
    /// MARK: each
    
    public mutating func each(block: () -> Void) {
        while let next = next() {
            block()
        }
    }
    
    public mutating func each(block: T.Generator.Element -> Void) {
        while let next = next() {
            block(next)
        }
    }
    
    public mutating func eachWithIndex(block: (T.Generator.Element, Int) -> Void) {
        while let next = next() {
            block(next, index)
        }
    }
    
    /// MARK: map
    
    public mutating func map<U>(transform: T.Generator.Element -> U) -> Iterator<[U]> {
        var r: [U] = []
        while let next = next() {
            r.append(transform(next))
        }
        return Iterator<[U]>(r)
    }

    public mutating func flatMap<U>(transform: T.Generator.Element -> [U]) -> Iterator<[U]> {
        return Iterator<[U]>(map(transform).toArray().reduce([], combine: +))
    }
    
    /// MARK: element get
    
    public mutating func find(predicate: T.Generator.Element -> Bool) -> T.Generator.Element? {
        var found = false
        while let next = next() {
            if predicate(next) {
                found = true
                return next
            }
        }
        return nil
    }
    
    /// MARK: partial iterator
    
    private func withPartialWhile<U>(block: (T.Generator.Element, Int) -> U) {
        var tmp = self
        var i = 0
        while let next = tmp.next() {
            i++
            block(next, i)
        }
    }
    
    public func take(num: Int) -> Iterator<[T.Generator.Element]> {
        var r: [T.Generator.Element] = []
        withPartialWhile { next, i -> Void in
            if i <= num {
                r.append(next)
            }
        }
        return Iterator<[T.Generator.Element]>(r)
    }
    
    public func drop(num: Int) -> Iterator<[T.Generator.Element]> {
        var r: [T.Generator.Element] = []
        withPartialWhile { next, i -> Void in
            if i > num {
                r.append(next)
            }
        }
        return Iterator<[T.Generator.Element]>(r)
    }
    
    public func takeWhile(predicate: T.Generator.Element -> Bool) -> Iterator<[T.Generator.Element]> {
        var r: [T.Generator.Element] = []
        withPartialWhile { next, _ -> Void in
            if predicate(next) {
                r.append(next)
            }
        }
        return Iterator<[T.Generator.Element]>(r)
    }
    
    public func dropWhile(predicate: T.Generator.Element -> Bool) -> Iterator<[T.Generator.Element]> {
        var r: [T.Generator.Element] = []
        withPartialWhile { next, _ -> Void in
            if !predicate(next) {
                r.append(next)
            }
        }
        return Iterator<[T.Generator.Element]>(r)
    }
    
    public func filter(includeElement: T.Generator.Element -> Bool) -> Iterator<[T.Generator.Element]> {
        var r: [T.Generator.Element] = []
        withPartialWhile { next, i -> Void in
            if includeElement(next) {
                r.append(next)
            }
        }
        return Iterator<[T.Generator.Element]>(r)
    }
    
    /// MARK: predicate
    
    public mutating func forall(predicate: T.Generator.Element -> Bool) -> Bool {
        var none = true
        while let next = next() {
            if !predicate(next) {
                none = false
            }
        }
        return none
    }
    
    public mutating func exists(predicate: T.Generator.Element -> Bool) -> Bool {
        var done = false
        while let next = next() {
            if predicate(next) {
                done = true
            }
        }
        return done
    }
    
    public mutating func count(predicate: T.Generator.Element -> Bool) -> Int {
        var i = 0
        while let next = next() {
            if predicate(next) {
                i++
            }
        }
        return i
    }
}

