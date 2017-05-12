//
//  EventsTableViewModel.swift
//  Gigsterous
//
//  Created by Michal Svacha on 12.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import Foundation
import Bond

/// ViewModel for events' table.
class EventsTableViewModel {
    let events = MutableObservableArray<Event>([])
    
    /// Downloads the latest data, saves it and calls the optional closure.
    ///
    /// - Parameter reload: Flag indication whether current data should be overriden or appended.
    /// - Parameter success: Optional closure performed after loading has been performed.
    func refreshData(reload: Bool, success: (() -> Void)?) {
        _ = ReactiveClient().eventsSignal().observeNext { evnts in
            if reload {
                self.events.removeAll()
            }
            
            self.events.insert(contentsOf: evnts, at: self.events.count)
            success?()
        }
    }
}
