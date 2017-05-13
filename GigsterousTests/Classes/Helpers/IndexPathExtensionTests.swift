//
//  IndexPathExtensionTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class IndexPathExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIndexPathEquality() {
        let indexPath = IndexPath(row: 2, section: 3)
        let indexPathSame = IndexPath(row: 2, section: 3)
        let indexPathDifferentRow = IndexPath(row: 1, section: 3)
        let indexPathDifferentSection = IndexPath(row: 2, section: 4)
        let indexPathCompletelyDifferent = IndexPath(row: 1, section: 4)
        
        XCTAssertTrue(indexPath.isEqual(other: indexPathSame))
        XCTAssertFalse(indexPath.isEqual(other: indexPathDifferentRow))
        XCTAssertFalse(indexPath.isEqual(other: indexPathDifferentSection))
        XCTAssertFalse(indexPath.isEqual(other: indexPathCompletelyDifferent))
    }
}
