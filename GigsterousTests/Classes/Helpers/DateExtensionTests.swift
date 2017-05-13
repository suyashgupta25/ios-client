//
//  DateExtensionTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest

class DateExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHumanReadableDate() {
        var dateComponents = DateComponents()
        dateComponents.year = 1990
        dateComponents.month = 11
        dateComponents.day = 16
        dateComponents.hour = 12
        dateComponents.minute = 45
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var date = calendar.date(from: dateComponents)
        XCTAssertTrue(date?.humanReadableString() == "1990/11/16 12:45")
        
        dateComponents.month = 2
        date = calendar.date(from: dateComponents)
        XCTAssertTrue(date?.humanReadableString() == "1990/02/16 12:45")
        
        dateComponents.day = 3
        date = calendar.date(from: dateComponents)
        XCTAssertTrue(date?.humanReadableString() == "1990/02/03 12:45")
        
        dateComponents.hour = 4
        date = calendar.date(from: dateComponents)
        XCTAssertTrue(date?.humanReadableString() == "1990/02/03 04:45")
        
        dateComponents.minute = 5
        date = calendar.date(from: dateComponents)
        XCTAssertTrue(date?.humanReadableString() == "1990/02/03 04:05")
    }
}
