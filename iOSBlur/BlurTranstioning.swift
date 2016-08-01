//
//  BlurTranstioning.swift
//  iOSBlur
//
//  Created by dimsky on 16/7/16.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import UIKit


class BlurTranstioning: NSObject, UIViewControllerTransitioningDelegate {

    let blurAnimator = BlurAnimator()

    var sourceVC: ViewController!
    var targetVC: SecondViewController!


    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        sourceVC = source as! ViewController
        targetVC = presented as! SecondViewController
        return blurAnimator
    }


    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return blurAnimator
    }

    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return sourceVC.percentDriven

    }

    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return targetVC.percentDriven
    }

}


class BlurAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!

        let isPresenting = toVC.presentingViewController == fromVC

        if isPresenting {
            presentTransitioning(transitionContext)
        } else {
            dismissTransitioning(transitionContext)
        }
    }


    func presentTransitioning(transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as! SecondViewController
        let containerView = transitionContext.containerView()!

        toVC.blurView.effect = nil
        containerView.addSubview(toVC.view)

        UIView.animateWithDuration(duration, animations: { 
            toVC.blurView.effect = UIBlurEffect(style: .Dark)
        }) { (success) in
            if transitionContext.transitionWasCancelled() {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }

    func dismissTransitioning(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as! SecondViewController
        let visibleFrame = transitionContext.initialFrameForViewController(fromVC)
        fromVC.view.frame = visibleFrame
        fromVC.blurView.effect = UIBlurEffect(style: .Dark)

        UIView.animateWithDuration(duration, animations: { 
            fromVC.blurView.effect = nil
            fromVC.view.frame = visibleFrame
        }) { (success) in
            if transitionContext.transitionWasCancelled() {
                fromVC.blurView.effect = UIBlurEffect(style: .Dark)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }

    }

}


