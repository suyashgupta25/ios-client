//
//  ResponseObject.swift
//  Gigsterous
//
//  Created by Michal Švácha on 23/12/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseObject<T: Mappable>: Mappable {
    
    var content: [T]?
    var last: Bool?
    var totalElements: Int?
    var totalPages: Int?
    // sort: null
    var first: Bool?
    var numberOfElements: Int?
    var size: Int?
    var number: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        content <- map["content"]
        last <- map["last"]
        totalElements <- map["totalElements"]
        totalPages <- map["totalPages"]
        first <- map["first"]
        numberOfElements <- map["numberOfElements"]
        size <- map["size"]
        number <- map["number"]
    }
    
}
