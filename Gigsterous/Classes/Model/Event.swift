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
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        venue <- map["venue"]
        date <- (map["date"], DateStringTransform())
        people <- map["people"]
    }
}
