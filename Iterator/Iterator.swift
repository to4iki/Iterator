//
//  Iterator.swift
//  Iterator
//
//  Created by to4iki on 6/27/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

public protocol Iteratable {
    typealias Element
    
    func next() -> Element?
}

/**
*  Data structures that allow to iterate over a sequence of elements.
*/
public class Iterator<T: SequenceType>: Iteratable {
    
    private let sequence: T
    private var generate: T.Generator
    
    public var size: Int {
        var i = 0
        while let next = next() {
            i++
        }
        return i
    }
    
    public init(_ sequence: T) {
        self.sequence = sequence
        self.generate = sequence.generate()
    }
    
    /// MARK: protocol
    
    public func next() -> T.Generator.Element? {
        return generate.next()
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
    
    public func each(block: () -> Void) {
        while let next = next() {
            block()
        }
    }
    
    public func each(block: T.Generator.Element -> Void) {
        while let next = next() {
            block(next)
        }
    }
    
    public func eachWithIndex(block: (T.Generator.Element, Int) -> Void) {
        var i = 0
        while let next = next() {
            i++
            block(next, i)
        }
    }
    
    /// MARK: map
    
    public func map<U>(transform: T.Generator.Element -> U) -> Iterator<[U]> {
        var r: [U] = []
        while let next = next() {
            r.append(transform(next))
        }
        return Iterator<[U]>(r)
    }

    public func flatMap<U>(transform: T.Generator.Element -> [U]) -> Iterator<[U]> {
        return Iterator<[U]>(map(transform).toArray().reduce([], combine: +))
    }
    
    /// MARK: element get
    
    public func find(predicate: T.Generator.Element -> Bool) -> T.Generator.Element? {
        var found = false
        while let next = next() {
            if predicate(next) {
                found = true
                return next
            }
        }
        return nil
    }
    
    /// MARK: part iterator
    
    public func filter(includeElement: T.Generator.Element -> Bool) -> Iterator<[T.Generator.Element]> {
        var r: [T.Generator.Element] = []
        while let next = next() {
            if includeElement(next) {
                r.append(next)
            }
        }
        return Iterator<[T.Generator.Element]>(r)
    }
    
    /// MARK: predicate
    
    public func forall(predicate: T.Generator.Element -> Bool) -> Bool {
        var none = true
        while let next = next() {
            if !predicate(next) {
                none = false
            }
        }
        return none
    }
    
    public func exists(predicate: T.Generator.Element -> Bool) -> Bool {
        var done = false
        while let next = next() {
            if predicate(next) {
                done = true
            }
        }
        return done
    }
    
    public func count(predicate: T.Generator.Element -> Bool) -> Int {
        var i = 0
        while let next = next() {
            if predicate(next) {
                i++
            }
        }
        return i
    }
}
