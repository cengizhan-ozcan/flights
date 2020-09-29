//
//  KeyboardFeature.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

protocol KeyboardFeature: class {
    func registerKeyboardNotification()
    func deRegisterKeyboardNotification()
    func keyboardNotification(notification: Notification)
    func keyboardWillOpen(height: CGFloat)
    func keyboardWillClose()
}

extension KeyboardFeature where Self: UIViewController {
    
    func registerKeyboardNotification() {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil, using: { [weak self] (notification) in
            self?.keyboardNotification(notification: notification)
        })
    }
    
    func deRegisterKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func keyboardNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            let isClosing = (endFrame?.origin.y)! >= UIScreen.main.bounds.height
            
            UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: { [weak self] in
                guard let self = self else {return}
                if isClosing {
                    self.keyboardWillClose()
                } else {
                    let height = (endFrame?.size.height ?? 0)
                    self.keyboardWillOpen(height: height)
                }
            }, completion: nil)
        }
    }
}

