//
//  UIColorExtension.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/**
 UIColor extension supporting Name declaration in order to prevent tedious RGB initialization.
 
 Inspired by article by @aligatr available at:
 http://alisoftware.github.io/swift/enum/constants/2015/07/19/enums-as-constants/
 */
extension UIColor {
    
    /**
     Enum values for additional colors.
     */
    enum Name: UInt32 {
        case DarkBlack = 0x2B2118ff
        case Cyan = 0x188FA7ff
        case AirBlue = 0x769FB6ff
        case GardBlue = 0x2B275Dff
        case GardYellow = 0xF1F1C2ff
    }
    
    /**
     Convenience initializer to initialize color with a given Name enum value.
     
     - parameter name: Enum Name value representing one of the additional colors.
     */
    convenience init(named name: Name) {
        let RGBAValue = name.rawValue
        let R = CGFloat((RGBAValue >> 24) & 0xff) / 255.0
        let G = CGFloat((RGBAValue >> 16) & 0xff) / 255.0
        let B = CGFloat((RGBAValue >> 8) & 0xff) / 255.0
        let alpha = CGFloat((RGBAValue) & 0xff) / 255.0
        
        self.init(red: R, green: G, blue: B, alpha: alpha)
    }
}
