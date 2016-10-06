//
//  HomeViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 29/06/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/// Application's home screen - what the user sees when the app is turned on.
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("BASEMENT", comment: "")
        self.view.backgroundColor = ColorSchemes.activeColorScheme.getRecessiveColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
