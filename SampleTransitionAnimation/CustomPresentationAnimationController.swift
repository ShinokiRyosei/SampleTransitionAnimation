//
//  CustomPresentationAnimationController.swift
//  SampleTransitionAnimation
//
//  Created by ShinokiRyosei on 2016/07/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class CustomPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    let duration: NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return  self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting  {
            
        }else {
            
        }
    }
    
    
    func animatePresentionWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewKey), let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView = transitionContext.containerView() else { return }
        
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.center.y -= containerView.bounds.size.height
        
        UIView.animateWithDuration(self.duration, animations: { 
            presentedControllerView.center.y += containerView.bounds.size.height
        }) { (completed: Bool) in
                transitionContext.completeTransition(completed)
        }
    }
    
    func animateDismissWithTransitionContext(transitionContext: UIViewControllerContextTransitioning)  {
        guard let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            let containerView = transitionContext.containerView() else { return }
        
        UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: { 
            presentedControllerView.center.y += containerView.bounds.size.height
        }) { (completed: Bool) in
            transitionContext.completeTransition(completed)
        }
    }
}
