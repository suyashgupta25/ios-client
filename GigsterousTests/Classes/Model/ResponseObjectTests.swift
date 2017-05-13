//
//  ResponseObjectTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class ResponseObjectTests: XCTestCase {
    var responseObject: ResponseObject<Person>!
    
    override func setUp() {
        super.setUp()
        responseObject = ResponseObject(JSONString: "{\r\n \"content\": [],\r\n \"last\": true,\r\n \"totalPages\": 1,\r\n \"totalElements\": 0,\r\n \"sort\": null,\r\n \"first\": true,\r\n \"numberOfElements\": 0,\r\n \"size\": 20,\r\n \"number\": 0\r\n}")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        XCTAssertTrue(responseObject.content?.count == 0)
        XCTAssertTrue(responseObject.last == true)
        XCTAssertTrue(responseObject.totalPages == 1)
        XCTAssertTrue(responseObject.totalElements == 0)
        XCTAssertTrue(responseObject.first == true)
        XCTAssertTrue(responseObject.numberOfElements == 0)
        XCTAssertTrue(responseObject.size == 20)
        XCTAssertTrue(responseObject.number == 0)
    }
}
