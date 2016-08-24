//
//  TabBarSlidingTransition.swift
//  Gigsterous
//
//  Created by Michal Švácha on 17/08/16.
//  Copyright (c) 2015 Michal Švácha. All rights reserved.
//

import UIKit

/**
 Custom class for transition between view controllers used in TabBarViewController.
 */
class TabBarSlidingTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var viewSize: CGSize = UIScreen.mainScreen().bounds.size
    var isScrollingLeft = true
    
    /**
     Convenience initializer for the transition.
     
     - parameter viewSize: Size of the views we are dealing with.
     - parameter isScrollingLeft: Boolean flag determining whether the sliding animation should be to the left or to the right.
     */
    convenience init(viewSize: CGSize, isScrollingLeft: Bool) {
        self.init()
        
        self.viewSize = viewSize
        self.isScrollingLeft = isScrollingLeft
    }
    
    /**
     Performs the sliding animation. If destination is a higher index, the sliding effect is to the left. If the destination is a lower index, the sliding effect is to the right.
     
     - parameter transitionContext: The context object containing information about the transition.
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let origin = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let destination = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        transitionContext.containerView()!.addSubview(origin)
        transitionContext.containerView()!.addSubview(destination)
        
        var multiplier: CGFloat = self.isScrollingLeft ? 1.0 : -1.0
        destination.frame = CGRectMake(multiplier * destination.frame.width, 0, destination.frame.width, destination.frame.height)
        
        multiplier = -multiplier
        let originNewFrame = CGRectMake(multiplier * origin.frame.width, 0, origin.frame.width, origin.frame.height)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            destination.frame = CGRectMake(0, 0, self.viewSize.width, self.viewSize.height)
            origin.frame = originNewFrame
        }, completion: { (_) -> Void in
            transitionContext.completeTransition(true)
        })
    }
    
    /**
     Determines the length of the transition.
     
     - parameter transitionContext: The context object containing information to use during the transition.
     - returns: The duration, in seconds, of your custom transition animation.
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
}
