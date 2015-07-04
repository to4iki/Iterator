//
//  Dictionary.swift
//  Iterator
//
//  Created by to4iki on 6/30/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

extension Dictionary {
    
    func map<T>(transform: (Key, Value) -> T) -> [T] {
        return Swift.map(self, transform)
    }
    
    func reduce<T>(initial: T, combine: (T, (Key, Value)) -> T) -> T {
        return Swift.reduce(self, initial, combine)
    }
}
