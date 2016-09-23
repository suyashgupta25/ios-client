//
//  HomeViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 29/06/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/**
 Application's home screen - what the user sees when the app is turned on.
 */
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("BASEMENT", comment: "")
        self.view.backgroundColor = ColorSchemes.activeColorScheme.getRecessiveColor()
        
        ClientMock.sharedInstance.people({ (people: [Person]) in
            print(people)
        }) { (error:NSError) in
            print("doh")
        }
        
        ClientMock.sharedInstance.ensembles({ (ensembles: [Ensemble]) in
            print(ensembles)
        }) { (error:NSError) in
            print("doh")
        }
        
        ClientMock.sharedInstance.events({ (events: [Event]) in
            print(events)
        }) { (error:NSError) in
            print("doh")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
