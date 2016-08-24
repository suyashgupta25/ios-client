//
//  NavigationViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/**
 Custom class for UINavigationController to make styling easier.
 */
class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style setting
        self.navigationBar.barStyle = .Black
        self.navigationBar.translucent = false
        self.navigationBar.barTintColor = ColorSchemes.activeColorScheme.getDominantColor()
        self.navigationBar.tintColor = ColorSchemes.activeColorScheme.getFontColor()
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : ColorSchemes.activeColorScheme.getFontColor()
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
