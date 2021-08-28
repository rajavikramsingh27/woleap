//
//  CurveFunc.swift
//  Woleap
//
//  Created by  Devender Singh Shekhawat on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func roundedimage() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
}

extension UIView {
    
    
    func curvecorner()  {
        self.layer.cornerRadius = 3.0
//        self.clipsToBounds = true
    }
    
    
}

