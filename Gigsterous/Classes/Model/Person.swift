//
//  Person.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 21/09/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import ObjectMapper

/// Model class representing a person.
class Person: Mappable {
    var id: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var gender: String!
    var location: String!
    var dateOfBirth: String!
    var skills: [Skill]!
    
    required init?(map: Map) {
        //
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        gender <- map["gender"]
        location <- map["location"]
        dateOfBirth <- map["dateOfBirth"]
        skills <- map["skills"]
    }
}
