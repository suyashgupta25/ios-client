//
//  DateExtension.swift
//  Gigsterous
//
//  Created by Michal Švácha on 30/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation

/// Custom date extension for handy tools needed across the application.
extension Date {
    
    /// Transforms the date into a concise String.
    ///
    /// - Returns: String with the date in format yyyy/MM/dd HH:mm
    func humanReadableString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
