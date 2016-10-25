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
    var date: Date!
    var people: [Person]!
    
    required init?(map: Map) {}
    
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        venue <- map["venue"]
        date <- (map["date"], DateStringTransform())
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
        
        guard self.date != nil else {
            return false
        }
        
        return true
    }
}
