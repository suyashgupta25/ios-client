//
//  RouterTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class RouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEvents() {
        let request = try! Router.events([:]).asURLRequest()
        XCTAssertNotNil(request)
        XCTAssertTrue(request.url?.absoluteString == "https://api.gigsterous.com/events")
        XCTAssertTrue(request.httpMethod == "GET")
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
    }
    
    func testEnsembles() {
        let request = try! Router.ensembles([:]).asURLRequest()
        XCTAssertNotNil(request)
        XCTAssertTrue(request.url?.absoluteString == "https://api.gigsterous.com/ensembles")
        XCTAssertTrue(request.httpMethod == "GET")
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
    }
    
    func testPeople() {
        let request = try! Router.people([:]).asURLRequest()
        XCTAssertNotNil(request)
        XCTAssertTrue(request.url?.absoluteString == "https://api.gigsterous.com/people")
        XCTAssertTrue(request.httpMethod == "GET")
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
    }
    
    func testVenues() {
        let request = try! Router.venues([:]).asURLRequest()
        XCTAssertNotNil(request)
        XCTAssertTrue(request.url?.absoluteString == "https://api.gigsterous.com/venues")
        XCTAssertTrue(request.httpMethod == "GET")
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
    }
}
