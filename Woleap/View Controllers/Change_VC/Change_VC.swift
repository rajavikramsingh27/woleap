//
//  Change_VC.swift
//  Woleap
//
//  Created by appentus technologies pvt. ltd. on 8/26/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Change_VC: UIViewController {
    @IBOutlet weak var txt_old_PWD:UITextField!
    @IBOutlet weak var txt_new_PWD:UITextField!
    @IBOutlet weak var txt_confirm_PWD:UITextField!

    @IBOutlet weak var btn_submit:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_submit.layer.cornerRadius = 2
        btn_submit.clipsToBounds = true
    }
    
    @IBAction func btn_submit(_ sender:UIButton) {
        if txt_old_PWD.text!.isEmpty {
            func_ShowHud_Error(with: "Enter old password")
        } else if txt_new_PWD.text!.isEmpty {
            func_ShowHud_Error(with: "Enter New password")
        } else if txt_confirm_PWD.text!.isEmpty {
            func_ShowHud_Error(with: "Confirm password is not matching")
        } else {
          //  func_update_password()
        }
        pop_single()
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
           self.func_HideHud()
        })
        
    }
    
    
    
    func func_update_password() {
       
    }
    
    
 
}
