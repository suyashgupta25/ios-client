//
//  EventFormViewModel.swift
//  Gigsterous
//
//  Created by Michal Švácha on 28/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import Bond

/// ViewModel for event form.
class EventFormViewModel {
    let name = Observable<String?>(NSLocalizedString("NEW_EVENT", comment: ""))
    let venue = Observable<String?>("")
    let startDate = Observable<Date>(Date())
    let endDate = Observable<Date>(Date().addingTimeInterval(3600))
    
    /// Hooks up logic between dates.
    /// - startDate should never be later than endDate. If such situation is presented on the input (= user enters a date that is later than the endDate), endDate should be automatically adjusted. 
    /// Currently set to automatically adjust the endDate an hour after the startDate.
    /// - endDate should never be earlier than startDate. If such situation is presented on the input (= user enters a date that is earlier than the startDate), startDate should be automatically adjusted.
    /// Currently set to automatically adjust the startDate an hour before the endDate. In case such option is earlier than NOW, current date is selected instead.
    init() {
        _ = self.startDate.observeNext { date in
            if date.compare(self.endDate.value) != .orderedAscending {
                self.endDate.value = date.addingTimeInterval(3600)
            }
        }
        
        _ = self.endDate.observeNext { date in
            if self.startDate.value.compare(date) != .orderedAscending {
                var dateCandidate = self.endDate.value.addingTimeInterval(-3600)
                if dateCandidate.compare(Date()) == .orderedAscending {
                    dateCandidate = Date()
                }
                
                self.startDate.value = dateCandidate
            }
        }
    }
    
    /// Indicates whether or not the object has all necessary data set in order to be sent to the server.
    ///
    /// - Returns: True if all necessary data has been set (name, venue and date).
    func isComplete() -> Bool {
        guard self.name.value != nil && self.name.value != "" else {
            return false
        }
        
        guard self.venue.value != nil && self.venue.value != "" else {
            return false
        }
        
        guard self.startDate.value.compare(self.endDate.value) == .orderedAscending else {
            return false
        }
        
        return true
    }
    
    /// Generates Event object pre-filled with data collected by the viewModel.
    ///
    /// - Returns: Event object filled with viewModel data
    func generateEventObject() -> Event {
        let event = Event()
        event.name = self.name.value
        //event.venue = self.venue.value
        event.startDate = self.startDate.value
        event.endDate = self.endDate.value
        return event
    }
}
