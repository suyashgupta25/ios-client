//
//  Client.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 21/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation


/// Protocol for decorating implementations of server-client communication. Provides all basic entities retrieved from the server.
protocol Client {
    
    /// Downloads list of people.
    ///
    /// - Parameter handler: Closure that is called after a successful download.
    /// - Parameter people: List of parsed Person objects.
    /// - Parameter failure: Closure that is called after a failed download.
    /// - Parameter error: Error containing information what went wrong.
    func people(handler: (_ people: [Person]) -> Void, failure: (_ error: NSError) -> Void)
    
    /// Downloads list of ensembles.
    ///
    /// - Parameter handler: Closure that is called after a successful download.
    /// - Parameter ensembles: List of parsed Ensemble objects.
    /// - Parameter failure: Closure that is called after a failed download.
    /// - Parameter error: Error containing information what went wrong.
    func ensembles(handler: (_ ensembles: [Ensemble]) -> Void, failure: (_ error: NSError) -> Void)
    
    /// Downloads list of events.
    ///
    /// - Parameter handler: Closure that is called after a successful download.
    /// - Parameter events: List of parsed Event objects.
    /// - Parameter failure: Closure that is called after a failed download.
    /// - Parameter error: Error containing information what went wrong.
    func events(handler: (_ events: [Event]) -> Void, failure: (_ error: NSError) -> Void)
}
