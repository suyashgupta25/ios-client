//
//  ColorSchemes.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/**
 Decorator protocol for custom color schemes to allow easy usage.
 */
protocol ColorScheme {
    
    /**
     Returns the dominant color used for navigation and tab bars.
     */
    func getDominantColor() -> UIColor
    
    /**
     Returns the color that is complimentary to the dominant color.
     */
    func getRecessiveColor() -> UIColor
    
    /**
     Returns the color that stands out for little details to give the app in the combination with dominant and recessive colors a fresher feeling.
     */
    func getTintColor() -> UIColor
    
    /**
     Returns the font color used for most text parts in the whole application.
     */
    func getFontColor() -> UIColor
}

/**
 Dummy class to allow static ColorScheme declaration.
 */
class ColorSchemes {
    static let activeColorScheme = BetaScheme()
}

/**
 ColorScheme intended for prototyping and evaluating different color combinations.
 */
struct BetaScheme: ColorScheme {
    func getDominantColor() -> UIColor {
        return UIColor(named: .DarkBlack)
    }
    
    func getRecessiveColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    func getTintColor() -> UIColor {
        return UIColor(named: .Cyan)
    }
    
    func getFontColor() -> UIColor {
        return UIColor.whiteColor()
    }
}