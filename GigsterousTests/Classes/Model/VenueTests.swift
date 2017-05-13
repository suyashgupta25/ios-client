//
//  VenueTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class VenueTests: XCTestCase {
    var venue: Venue!
    
    override func setUp() {
        super.setUp()
        venue = Venue(JSONString: "{\r\n \"id\": 1,\r\n \"name\": \"Vagon Klub\",\r\n \"lat\": 50.0822,\r\n \"lon\": 14.418\r\n }")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testVenueContents() {
        XCTAssertTrue(venue.id == 1)
        XCTAssertTrue(venue.name == "Vagon Klub")
        XCTAssertTrue(venue.latitude == 50.0822)
        XCTAssertTrue(venue.longitude == 14.418)
    }
}
