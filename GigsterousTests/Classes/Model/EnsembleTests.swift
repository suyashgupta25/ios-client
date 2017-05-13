//
//  EnsembleTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class EnsembleTests: XCTestCase {
    var ensemble: Ensemble!
    
    override func setUp() {
        super.setUp()
        ensemble = Ensemble(JSONString: "{\r\n \"id\": 3,\r\n \"name\": \"Lalas\",\r\n \"ensembleType\": \"BAND\",\r\n \"people\": [\r\n {\r\n \"id\": 6,\r\n \"firstName\": \"Samuel\",\r\n \"lastName\": \"Jaxon\",\r\n \"email\": \"jaxon@hotmail.com\",\r\n \"gender\": \"MALE\",\r\n \"location\": \"Prague\",\r\n \"dateOfBirth\": \"1987-11-24\",\r\n \"skills\": [\r\n {\r\n \"id\": 8,\r\n \"instrument\": \"BASS\",\r\n \"level\": \"ADVANCED\"\r\n }\r\n ]\r\n },\r\n {\r\n \"id\": 4,\r\n \"firstName\": \"Gandal\",\r\n \"lastName\": \"White\",\r\n \"email\": \"white@gmail.com\",\r\n \"gender\": \"MALE\",\r\n \"location\": \"Mordor\",\r\n \"dateOfBirth\": \"1978-06-05\",\r\n \"skills\": [\r\n {\r\n \"id\": 5,\r\n \"instrument\": \"GUITAR\",\r\n \"level\": \"ADVANCED\"\r\n },\r\n {\r\n \"id\": 6,\r\n \"instrument\": \"VIOLIN\",\r\n \"level\": \"BEGINNER\"\r\n }\r\n ]\r\n }\r\n ]\r\n }")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEnsembleContents() {
        XCTAssertTrue(ensemble.id == 3)
        XCTAssertTrue(ensemble.name == "Lalas")
        XCTAssertTrue(ensemble.ensembleType == "BAND")
        XCTAssertTrue(ensemble.people.count == 2)
    }
}
