//
//  Skill.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 23/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

/// Model class representing a skill.
import Foundation
import ObjectMapper

class Skill: Mappable {
    var id: String!
    var instrument: String!
    var level: String!
    
    required init?(map: Map) {
        //
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        instrument <- map["instrument"]
        level <- map["level"]
    }
}
