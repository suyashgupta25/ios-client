//
//  Ensemble.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 21/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model class representing an ensemble.
class Ensemble: Mappable {
    var id: Int!
    var name: String!
    var ensembleType: String!
    var people: [Person]!
    
    required init?(map: Map) {
        //
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        ensembleType <- map["ensembleType"]
        people <- map["people"]
    }
}
