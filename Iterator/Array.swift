//
//  Array.swift
//  Iterator
//
//  Created by to4iki on 6/30/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

internal extension Array {
    
    func each(block: T -> Void) {
        for item in self {
            block(item)
        }
    }
    
    func each<U>(block: U -> Void) {
        for item in self {
            block(item as! U)
        }
    }
    
    func eachWithIndex(block: (T, Int) -> Void) {
        for (i, item) in enumerate(self) {
            block(item, i)
        }
    }
    
    func eachWithIndex<U>(block: (U, Int) -> Void) {
        for (i, item) in enumerate(self) {
            block(item as! U, i)
        }
    }
    
    func toIterator() -> Iterator<Array> {
        return Iterator(self)
    }
}
