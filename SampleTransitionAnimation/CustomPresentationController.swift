//
//  CustomPresentationController.swift
//  SampleTransitionAnimation
//
//  Created by ShinokiRyosei on 2016/07/19.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    lazy var dimingView: UIView = {
        let view: UIView = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        view.alpha = 0.0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let presentedView = presentedView() else { return }
        dimingView.frame = containerView.bounds
        containerView.addSubview(dimingView)
        containerView.addSubview(presentedView)
        
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) in
                self.dimingView.alpha = 1.0
                }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        if !completed {
            self.dimingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
                self.dimingView.alpha = 0.0
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.dimingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        guard let containerView = containerView else { return CGRect() }
        var frame = containerView.bounds
        frame = CGRectInset(frame, 50.0, 50.0)
        return frame
    }
    
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        guard let containerView = containerView else { return }
        coordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext) in
            self.dimingView.frame = containerView.bounds
            }, completion: nil)
    }
}
