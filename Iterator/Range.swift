//
//  Range.swift
//  Iterator
//
//  Created by to4iki on 7/5/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

internal extension Range {
    
    func toArray() -> [T] {
        var result: [T] = []
        for i in self {
            result.append(i)
        }
        return result
    }
    
    func toIterator() -> Iterator<[T]> {
        return Iterator(toArray())
    }
}