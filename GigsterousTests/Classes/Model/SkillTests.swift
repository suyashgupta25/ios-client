//
//  SkillTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class SkillTests: XCTestCase {
    var skill: Skill!
    
    override func setUp() {
        super.setUp()
        skill = Skill(JSONString: "{\r\n \"id\": 1,\r\n \"instrument\": \"GUITAR\",\r\n \"level\": \"BEGINNER\"\r\n }")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSkillContents() {
        XCTAssertTrue(skill.id == 1)
        XCTAssertTrue(skill.instrument == "GUITAR")
        XCTAssertTrue(skill.level == "BEGINNER")
    }
}
