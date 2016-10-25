//
//  Event.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 21/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model class representing an event.
class Event: Mappable {
    var id: Int!
    var name: String!
    var venue: String!
    var startDate: Date!
    var endDate: Date!
    var people: [Person]!
    
    required init?(map: Map) {}
    
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        venue <- map["venue"]
        startDate <- (map["startDate"], DateStringTransform())
        endDate <- (map["endDate"], DateStringTransform())
        people <- map["people"]
    }
    
    /// Indicates whether or not the object has all necessary data set in order to be sent to the server.
    ///
    /// - Returns: True if all necessary data has been set (name, venue and date).
    func isComplete() -> Bool {
        guard self.name != nil else {
            return false
        }
        
        guard self.venue != nil else {
            return false
        }
        
        guard self.startDate != nil else {
            return false
        }
        
        guard self.endDate != nil else {
            return false
        }
        
        return true
    }
}
