//
//  ConvertDismissAnimationController.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/4/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import UIKit

class ConvertDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        
        let convertViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ConvertViewController
        if let fromView = convertViewController.view {
            
            UIView.animate(withDuration: duration, animations: {
                fromView.alpha = 0
            }, completion: { (success) in
                transitionContext.completeTransition(success)
            })
        }
    }
}
