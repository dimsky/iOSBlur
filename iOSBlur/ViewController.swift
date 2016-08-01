//
//  ViewController.swift
//  iOSBlur
//
//  Created by dimsky on 16/7/16.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let blurTranstioning = BlurTranstioning()
    var secondController: UIViewController!

    let percentDriven = UIPercentDrivenInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        self.view.addGestureRecognizer(pan)

        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        secondController = storyboard.instantiateViewControllerWithIdentifier("SecondViewController")

        secondController.transitioningDelegate = blurTranstioning
        secondController.modalPresentationStyle = .Custom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var shouldComplete = false
    func panAction(gesture: UIPanGestureRecognizer) {

        let translation = gesture.translationInView(gesture.view?.superview)
        switch gesture.state {
        case .Possible:
            break
        case .Began:
            self.presentViewController(secondController, animated: true, completion: nil)

        case .Changed:
            let percent = translation.y  / 200
            print(percent)
            shouldComplete = (percent > 0.5);
            if percent > 0 && percent < 1 {
                percentDriven.updateInteractiveTransition(percent)
            }
        case .Ended:
            if shouldComplete {
                percentDriven.finishInteractiveTransition()
            } else {
                percentDriven.cancelInteractiveTransition()
            }
        case .Cancelled:
            if shouldComplete {
                percentDriven.finishInteractiveTransition()
            } else {
                percentDriven.cancelInteractiveTransition()
            }
        case .Failed:
            break
        }
    }

}

