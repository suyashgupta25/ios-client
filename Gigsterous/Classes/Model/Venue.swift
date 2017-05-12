//
//  Venue.swift
//  Gigsterous
//
//  Created by Michal Svacha on 12.05.17.
//  Copyright © 2017 Svacha, Michal. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model class representing a venue.
class Venue: Mappable {
    var id: Int!
    var name: String!
    var latitude: Float!
    var longitude: Float!
    
    required init?(map: Map) {}
    
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        latitude <- map["lat"]
        longitude <- map["lon"]
    }
}
