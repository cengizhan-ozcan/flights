//
//  MockFilterVC.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit
@testable import Flights

class MockFilterVC: PVFilterProtocol, KeyboardFeature {
    
    func registerKeyboardNotification() {
            
    }
    
    func deRegisterKeyboardNotification() {
        
    }
    
    func keyboardNotification(notification: Notification) {
        
    }
    
    func keyboardWillOpen(height: CGFloat) {
        
    }
    
    func keyboardWillClose() {
        
    }
}
