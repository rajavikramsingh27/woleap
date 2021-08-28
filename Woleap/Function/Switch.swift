//
//  Switch.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 27/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
import UIKit



extension UISwitch {
    
    func set( width: CGFloat, height: CGFloat) {
        
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth
        
    transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}


    
func btn(button: UIButton,button2: UIButton, label: UILabel, label2: UILabel) {
        button.isSelected = !button.isSelected
    
//        if button.isSelected {
            button.setImage(UIImage(named: "tick-2"), for: .normal)
            button.backgroundColor = UIColor (red: 74.0/255.0, green: 119.0/255.0, blue: 246.0/255.0, alpha: 1.0)
            label.textColor = UIColor.black
            button2.setImage(UIImage(named: ""), for: .normal)
            button2.backgroundColor = UIColor.lightGray
            label2.textColor = UIColor.lightGray
//        } else {
//            button.setImage(UIImage(named: ""), for: .normal)
//            button.backgroundColor = UIColor.lightGray
//            label.textColor = UIColor.lightGray
//        }
    }

func btn2(button: UIButton,button2: UIButton,button3: UIButton, button4: UIButton, label: UILabel, label2: UILabel, label3: UILabel, label4: UILabel) {
    button.isSelected = true
//    button.isSelected = !button.isSelected
//    button.isSelected = !button.isSelected
    
//    if button.isSelected {
        button.setImage(UIImage(named: "tick-2"), for: .normal)
        button.backgroundColor = UIColor (red: 74.0/255.0, green: 119.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        label.textColor = UIColor.black
    
        button2.setImage(UIImage(named: ""), for: .normal)
        button2.backgroundColor = UIColor.lightGray
        label2.textColor = UIColor.lightGray
    
        button3.setImage(UIImage(named: ""), for: .normal)
        button3.backgroundColor = UIColor.lightGray
        label3.textColor = UIColor.lightGray
    
        button4.setImage(UIImage(named: ""), for: .normal)
        button4.backgroundColor = UIColor.lightGray
        label4.textColor = UIColor.lightGray
//    } else {
//        button.setImage(UIImage(named: ""), for: .normal)
//        button.backgroundColor = UIColor.lightGray
//        label.textColor = UIColor.lightGray
//    }
    
    
    
}



func checkbox(sender : UIButton , change_img_btn : UIButton){
    sender.isSelected = !sender.isSelected
    if sender.isSelected{
        change_img_btn.setImage(UIImage(named: "tick-2"), for: .normal)
        change_img_btn.backgroundColor = UIColor (red: 74.0/255.0, green: 119.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        
    }else{
        change_img_btn.setImage(UIImage(named: ""), for: .normal)
        change_img_btn.backgroundColor = UIColor.lightGray
    }
}


func tagbtn(sender : UIButton, btn: UIButton, btn2: UIButton)  {
    sender.isSelected = !sender.isSelected
    
//    if sender.tag == 1 && sender.isSelected == true {
//        sender.backgroundColor =  UIColor.init(red: 243.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
//        sender.setTitleColor(UIColor.init(red: 74.0/255.0, green: 118.0/255.0, blue: 246.0/255.0, alpha: 1.0), for: .normal)
//        btn.backgroundColor = UIColor.white
//        btn.setTitleColor(UIColor.black, for: .normal)
//        btn2.backgroundColor = UIColor.white
//        btn2.setTitleColor(UIColor.black, for: .normal)
//
//    } else if sender.tag == 2  && sender.isSelected == true {
//        sender.backgroundColor =  UIColor.init(red: 243.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
//        sender.setTitleColor(UIColor.init(red: 74.0/255.0, green: 118.0/255.0, blue: 246.0/255.0, alpha: 1.0), for: .normal)
//        btn.backgroundColor = UIColor.white
//        btn.setTitleColor(UIColor.init(red: 38.0/255.0, green: 38.0/255.0, blue: 50.0/255.0, alpha: 1.0), for: .normal)
//        btn2.backgroundColor = UIColor.white
//        btn2.setTitleColor(UIColor.init(red: 38.0/255.0, green: 38.0/255.0, blue: 50.0/255.0, alpha: 1.0), for: .normal)
//        
//    }else if sender.tag==3  && sender.isSelected == true {
        sender.backgroundColor =  UIColor.init(red: 243.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        sender.setTitleColor(UIColor.init(red: 74.0/255.0, green: 118.0/255.0, blue: 246.0/255.0, alpha: 1.0), for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor.init(red: 38.0/255.0, green: 38.0/255.0, blue: 50.0/255.0, alpha: 1.0), for: .normal)
        btn2.isSelected = false
        btn2.backgroundColor = UIColor.white
        btn2.setTitleColor(UIColor.init(red: 38.0/255.0, green: 38.0/255.0, blue: 50.0/255.0, alpha: 1.0), for: .normal)
        
//    }
 
    
    
}


