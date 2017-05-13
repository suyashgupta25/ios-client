//
//  PersonTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class PersonTests: XCTestCase {
    var person: Person!
    
    override func setUp() {
        super.setUp()
        person = Person(JSONString: "{\r\n \"id\": 1,\r\n \"firstName\": \"Peter\",\r\n \"lastName\": \"Smith\",\r\n \"email\": \"peter@hotmail.com\",\r\n \"gender\": \"MALE\",\r\n \"location\": \"London\",\r\n \"dateOfBirth\": \"1980-04-07\",\r\n \"skills\": [\r\n {\r\n \"id\": 1,\r\n \"instrument\": \"GUITAR\",\r\n \"level\": \"BEGINNER\"\r\n }\r\n ]\r\n }")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPersonContents() {
        XCTAssertTrue(person.id == 1)
        XCTAssertTrue(person.firstName == "Peter")
        XCTAssertTrue(person.lastName == "Smith")
        XCTAssertTrue(person.email == "peter@hotmail.com")
        XCTAssertTrue(person.gender == "MALE")
        XCTAssertTrue(person.location == "London")
        XCTAssertTrue(person.dateOfBirth == "1980-04-07")
        XCTAssertTrue(person.skills.count == 1)
    }
}
