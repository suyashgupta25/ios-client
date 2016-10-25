//
//  IndexPathExtension.swift
//  Gigsterous
//
//  Created by Michal Švácha on 18/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import Foundation

/// Extension of IndexPath providing helper functions used throughout the application.
extension IndexPath {
    
    /// Comparator function for two IndexPath objects.
    /// - Warning: This method is only usable for comparing IndexPath objects according to row and section.
    /// - Parameter other: IndexPath object this object is supposed to be compared to.
    /// - Returns: Boolean value indicating similarity.
    func isEqual(other: IndexPath) -> Bool {
        return (self.section == other.section && self.row == other.row)
    }
}
