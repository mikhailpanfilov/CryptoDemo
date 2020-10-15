//
//  ConvertPresentAnimationController.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/4/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import UIKit

class ConvertPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = transitionDuration(using: transitionContext)
        
        let convertViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ConvertViewController
        let convertView = convertViewController.view
        
        let containerView = transitionContext.containerView
        
        convertView!.frame = transitionContext.finalFrame(for: convertViewController)
        containerView.addSubview(convertView!)
        
        convertViewController.convertContainerView.alpha = 0
        convertViewController.convertContainerView.transform = CGAffineTransform(translationX: 0, y: 30)
        convertViewController.swapCurrencyLabel.alpha = 0
        convertViewController.swapCurrencyLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        convertViewController.swapCurrencyButton.alpha = 0
        convertViewController.swapCurrencyButton.transform = CGAffineTransform(translationX: 0, y: 30)
        convertViewController.resultContainerView.alpha = 0
        convertViewController.resultContainerView.transform = CGAffineTransform(translationX: 0, y: 30)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            convertViewController.convertContainerView.alpha = 1
            convertViewController.convertContainerView.transform = CGAffineTransform.identity
            transitionContext.completeTransition(true)
        })
        UIView.animate(withDuration: duration, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            convertViewController.swapCurrencyLabel.alpha = 1
            convertViewController.swapCurrencyLabel.transform = CGAffineTransform.identity
            convertViewController.swapCurrencyButton.alpha = 1
            convertViewController.swapCurrencyButton.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: duration, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            convertViewController.resultContainerView.alpha = 1
            convertViewController.resultContainerView.transform = CGAffineTransform.identity
        })
    }
}
