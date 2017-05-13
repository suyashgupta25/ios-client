//
//  EventTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class EventTests: XCTestCase {
    var event: Event!
    
    override func setUp() {
        super.setUp()
        event = Event(JSONString: "{\r\n \"id\": 2,\r\n \"name\": \"Christmas Chill\",\r\n \"venue\": {\r\n \"id\": 2,\r\n \"name\": \"Rudolfinum\",\r\n \"lat\": 50.0899,\r\n \"lon\": 14.4154\r\n },\r\n \"startDate\": \"2016-12-24 18:00\",\r\n \"endDate\": \"2016-12-24 21:00\",\r\n \"people\": [\r\n {\r\n \"id\": 3,\r\n \"firstName\": \"Gandalf\",\r\n \"lastName\": \"Grey\",\r\n \"email\": \"grey@gmail.com\",\r\n \"gender\": \"MALE\",\r\n \"location\": \"New York\",\r\n \"dateOfBirth\": \"1990-02-28\",\r\n \"skills\": [\r\n {\r\n \"id\": 4,\r\n \"instrument\": \"PIANO\",\r\n \"level\": \"PROFESSIONAL\"\r\n },\r\n {\r\n \"id\": 3,\r\n \"instrument\": \"DRUMS\",\r\n \"level\": \"BEGINNER\"\r\n }\r\n ]\r\n },\r\n {\r\n \"id\": 4,\r\n \"firstName\": \"Gandal\",\r\n \"lastName\": \"White\",\r\n \"email\": \"white@gmail.com\",\r\n \"gender\": \"MALE\",\r\n \"location\": \"Mordor\",\r\n \"dateOfBirth\": \"1978-06-05\",\r\n \"skills\": [\r\n {\r\n \"id\": 5,\r\n \"instrument\": \"GUITAR\",\r\n \"level\": \"ADVANCED\"\r\n },\r\n {\r\n \"id\": 6,\r\n \"instrument\": \"VIOLIN\",\r\n \"level\": \"BEGINNER\"\r\n }\r\n ]\r\n }\r\n ]\r\n }")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEventContents() {
        XCTAssertTrue(event.id == 2)
        XCTAssertTrue(event.name == "Christmas Chill")
        XCTAssertNotNil(event.venue)
        XCTAssertTrue(event.people.count == 2)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2016
        dateComponents.month = 12
        dateComponents.day = 24
        dateComponents.hour = 18
        dateComponents.minute = 00
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var date = calendar.date(from: dateComponents)
        XCTAssertTrue(event.startDate == date)
        
        dateComponents.hour = 21
        dateComponents.minute = 00
        date = calendar.date(from: dateComponents)
        XCTAssertTrue(event.endDate == date)
    }
}
