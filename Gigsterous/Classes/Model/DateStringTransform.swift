//
//  DateStringTransform.swift
//  Gigsterous
//
//  Created by Michal Švácha on 03/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation
import ObjectMapper

/// Helper class for ObjectMapper framework. Transofroms String date received from the API server to a Date object.
open class DateStringTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Date? {
        if let dateString = value as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let date = dateFormatter.date(from: dateString)
            return date
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        
        return nil
    }
}
