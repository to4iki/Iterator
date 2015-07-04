//
//  IteratorTests.swift
//  IteratorTests
//
//  Created by to4iki on 6/27/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import XCTest
import Iterator

class IteratorTests: XCTestCase {
    
    var it: Iterator<[Int]>!
    
    override func setUp() {
        super.setUp()
        it = Iterator([1,2,3])
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasNext() {
        it.next()
        it.next()
        XCTAssertTrue(it.hasNext)
        it.next()
        XCTAssertFalse(it.hasNext)
    }
    
    func testIsEmpty() {
        it.next()
        it.next()
        XCTAssertFalse(it.isEmpty)
        it.next()
        XCTAssertTrue(it.isEmpty)
    }
    
    func testSize() {
        XCTAssert(it.size == 3)
        XCTAssert(it.size == 0)
    }
    
    func testReverse() {
        var r = it.reverse()
        XCTAssertEqual(r.toArray(), [3,2,1])
    }
    
    func testToArray() {
        var r = it.toArray()
        XCTAssertEqual(r, [1,2,3])
    }
    
    func testEach() {
        var r = 0
        it.each { r += $0 }
        XCTAssert(r == 6)
        XCTAssert(it.size == 0)
    }
    
    func testEachWithIndex() {
        var (r1, r2) = (0, 0)
        it.eachWithIndex {
            r1 += $0
            r2 -= $1
        }
        XCTAssert(r1 == 6)
        XCTAssert(r2 == -6)
        XCTAssert(it.size == 0)
    }
    
    func testMap() {
        let r = it.map { $0 * 2 }
        XCTAssertEqual(r.toArray(), [2,4,6])
        XCTAssert(it.size == 0)
    }
    
    func testFlatMap() {
        let r = it.flatMap {
            [Int](count: $0, repeatedValue: $0)
        }
        XCTAssertEqual(r.toArray(), [1,2,2,3,3,3])
        XCTAssert(it.size == 0)
    }
    
    func testFind() {
        let r = it.find { $0 % 2 == 0 }
        XCTAssertEqual(r ?? 0, 2)
        XCTAssert(it.size == 1)
    }
    
    func testFilter() {
        let r = it.filter { $0 % 2 == 0 }
        XCTAssertEqual(r.toArray(), [2])
        XCTAssert(it.size == 0)
    }
    
    func testForAll() {
        let r = it.forall { $0 % 2 == 0 }
        XCTAssertFalse(r)
        XCTAssert(it.size == 0)
    }
    
    func testExists() {
        let r = it.exists { $0 % 2 == 0 }
        XCTAssertTrue(r)
        XCTAssert(it.size == 0)
    }
    
    func testCount() {
        let it = Iterator([1,2,3,4,5])
        let r = it.count { $0 % 2 == 0 }
        XCTAssertEqual(r, 2)
        XCTAssert(it.size == 0)
    }
}
