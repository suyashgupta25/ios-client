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
    var venue: Venue!
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
}
