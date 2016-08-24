//
//  TabViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/**
 Custom class for UITabBarController for customized transitions and appearance.
 */
class TabViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        // Style setting
        UITabBar.appearance().translucent = false
        UITabBar.appearance().barTintColor = ColorSchemes.activeColorScheme.getDominantColor()
        UITabBar.appearance().tintColor = ColorSchemes.activeColorScheme.getTintColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Called to allow the delegate to return a UIViewControllerAnimatedTransitioning delegate object for use during a noninteractive tab bar view controller transition.
     
     Implemented in a fashion to use the class TabBarTransition which slides the other controller either from the right or from the left.
     
     - parameter tabBarController: The tab bar controller whose view controller is transitioning.
     - parameter fromVC: The currently visible view controller.
     - parameter toVC: The view controller intended to be visible after the transition ends.
     */
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let viewControllers = tabBarController.viewControllers else {
            return nil
        }
        
        let fromIndex = viewControllers.indexOf(fromVC)
        let toIndex = viewControllers.indexOf(toVC)
        let animatedTransitioningObject = TabBarSlidingTransition(viewSize: fromVC.view.frame.size, isScrollingLeft: toIndex > fromIndex)
        
        return animatedTransitioningObject
    }

}
