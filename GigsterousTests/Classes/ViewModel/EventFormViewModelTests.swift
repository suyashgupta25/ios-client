//
//  EventFormViewModelTests.swift
//  Gigsterous
//
//  Created by Michal Svacha on 13.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import XCTest
@testable import Gigsterous

class EventFormViewModelTests: XCTestCase {
    var viewModel: EventFormViewModel!
    
    override func setUp() {
        super.setUp()
        self.viewModel = EventFormViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCorrectTimeInit() {
        let startDate = viewModel.startDate.value
        let endDate = viewModel.endDate.value
        XCTAssertTrue(startDate.compare(endDate) == .orderedAscending)
    }
    
    func testAscendingCorrection() {
        // set the end date to five minutes ago
        viewModel.endDate.value = Date(timeIntervalSinceNow: -5 * 60)
        
        let startDate = viewModel.startDate.value
        let endDate = viewModel.endDate.value
        XCTAssertTrue(startDate.compare(endDate) == .orderedAscending)
    }
    
    func testDescendingCorrection() {
        // set the start end to two hours in the future
        viewModel.startDate.value = Date(timeIntervalSinceNow: 2 * 3600)
        
        let startDate = viewModel.startDate.value
        let endDate = viewModel.endDate.value
        XCTAssertTrue(startDate.compare(endDate) == .orderedAscending)
    }
    
    func testIsComplete() {
        viewModel.name.value = "Test Event"
        viewModel.venue.value = "Prague"
        XCTAssertTrue(viewModel.isComplete())
        
        viewModel.name.value = nil
        XCTAssertFalse(viewModel.isComplete())
        
        viewModel.name.value = "Test Event"
        viewModel.venue.value = nil
        XCTAssertFalse(viewModel.isComplete())
    }
    
    func testObjectGeneration() {
        viewModel.name.value = "Test Event"
        viewModel.venue.value = "Prague"
        let event = viewModel.generateEventObject()
        
        XCTAssertTrue(viewModel.name.value == event.name)
        XCTAssertTrue(viewModel.startDate.value == event.startDate)
        XCTAssertTrue(viewModel.endDate.value == event.endDate)
    }
}
