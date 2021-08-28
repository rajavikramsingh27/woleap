//
//  File.swift
//  Woleap
//
//  Created by  Devender Singh Shekhawaton 21/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
import UIKit


func func_shadow(view:UIView,color:UIColor, CorRad: CGFloat) {
    view.layer.shadowOpacity = 3
    view.layer.shadowOffset = CGSize(width: 1, height:1)
    view.layer.shadowRadius = 1.0
    view.layer.shadowColor = color.cgColor

}

func func_txtfield(txt:UIView, color:UIColor, brwidth: CGFloat ){
    txt.layer.cornerRadius = 5.0
    txt.layer.borderWidth = brwidth
    txt.layer.borderColor = color.cgColor
}

func func_btn(btn: UIView,CR:CGFloat ,color:UIColor, brwidth: CGFloat, Shadow: Float, ShadowRadius: CGFloat){
    btn.layer.cornerRadius = CR
    btn.layer.borderWidth = brwidth
    btn.layer.borderColor = color.cgColor
    btn.layer.shadowOpacity = Shadow
    btn.layer.shadowOffset = CGSize(width: 1, height:1)
    btn.layer.shadowRadius = ShadowRadius
    btn.layer.shadowColor = color.cgColor
    
}

extension UITextField{
    func padding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
}

extension UIView {
    
    func fadeIn(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
