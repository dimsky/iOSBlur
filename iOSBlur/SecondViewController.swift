//
//  SecondViewController.swift
//  iOSBlur
//
//  Created by dimsky on 16/7/16.
//  Copyright © 2016年 dimsky. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var blurView: UIVisualEffectView!

    var percentDriven = UIPercentDrivenInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        blurView = UIVisualEffectView(frame: self.view.frame)
        let blurEffect = UIBlurEffect(style: .Dark)
        blurView.effect = blurEffect
        self.view.addSubview(blurView)
        self.view.sendSubviewToBack(blurView)

//        let vibrancyView = UIVisualEffectView(frame: self.view.frame)
//        vibrancyView.effect = UIVibrancyEffect(forBlurEffect: blurEffect)
//        blurView.contentView.addSubview(vibrancyView)
//        let label = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 100))
//        label.text = "Balabalabala "
//        label.font = UIFont.systemFontOfSize(30)
//        label.textAlignment = .Center
////        label.textColor = UIColor.blueColor() //颜色无效
//        vibrancyView.contentView.addSubview(label)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        self.view.addGestureRecognizer(pan)
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
            self.dismissViewControllerAnimated(true, completion: nil)

        case .Changed:
            let percent = translation.y  / 200
            print(percent)
            shouldComplete = (percent <  -0.5);
            if percent < 0 && percent > -1 {
                percentDriven.updateInteractiveTransition(fabs(percent))
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
