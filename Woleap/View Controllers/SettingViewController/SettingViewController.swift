//
//  SettingViewController.swift
//  Woleap
//
//  Created by ayush pathak on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit


class SettingViewController: UIViewController {
    
    //  Marks:  IBOutlets
    
    @IBOutlet weak var NameTxtFld: UITextField!
    @IBOutlet weak var EmailTxtFld: UITextField!
    
    @IBOutlet weak var NumberTxtFld: UITextField!
    
//    @IBOutlet weak var OldPassTxtFld: UITextField!
//    @IBOutlet weak var NewTxtfld: UITextField!
    
    @IBOutlet weak var CalendarEmailTxtFld: UITextField!
    
    @IBOutlet weak var SyncEmailTxtFld: UITextField!
    
    @IBOutlet weak var StartdateLbl: UILabel!
    
    @IBOutlet weak var duedateLbl: UILabel!
//    @IBOutlet weak var pickerView: UIView!
//    @IBOutlet weak var doneBtn: UIButton!
//
//    @IBOutlet weak var btn_signout:UIButton!
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_mobile_no: UITextField!
    
    var is_StartTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func_set_layout()
    }
    
    func func_set_layout() {
//        SwitchBTN.set( width: 47, height: 27)
        func_txtfield(txt: EmailTxtFld, color: UIColor.lightGray, brwidth: 0)
        func_txtfield(txt: NameTxtFld, color: UIColor.lightGray, brwidth: 0)
        func_txtfield(txt: NumberTxtFld, color: UIColor.lightGray, brwidth: 0)
//        func_txtfield(txt: OldPassTxtFld, color: UIColor.lightGray, brwidth: 0)
//        func_txtfield(txt: NewTxtfld, color: UIColor.lightGray, brwidth: 0)
        func_txtfield(txt: SyncEmailTxtFld, color: UIColor.lightGray, brwidth: 0)
        func_txtfield(txt: CalendarEmailTxtFld, color: UIColor.lightGray, brwidth: 0)
        NameTxtFld.padding()
        EmailTxtFld.padding()
        NumberTxtFld.padding()
//        OldPassTxtFld.padding()
//        NewTxtfld.padding()
        CalendarEmailTxtFld.padding()
        SyncEmailTxtFld.padding()
//        btn_signout.layer.cornerRadius = btn_signout.bounds.height/2
//        btn_signout.clipsToBounds = true
    }
    
    //    Marks: IBAction
    @IBAction func btn_signout(_ sender: UIButton) {
        let alert = UIAlertController (title: "", message: "Are you sure ?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (yes) in
            CD_Manger.shared.delete_all_from_database(.login, completion: { (_) in
                self.push_VC("LoginViewController", storyboard: "Main")
            })
        }
        let no = UIAlertAction(title: "No", style: .default) { (yes) in
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        
        alert.view.tintColor = UIColor .black
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SettingBtn(_ sender: Any) {
    }
    
    @IBAction func ProductUpadateSwtichBTn(_ sender: Any) {
    }
    
    @IBAction func OfferSwitchBTn(_ sender: Any) {
    }
    
    @IBAction func NotifiSwitchBtn(_ sender: Any) {
    }
    
    @IBAction func UpdateBtn(_ sender: Any) {
        push_VC("ReportsViewController", storyboard: "Main")
    }
    
    @IBAction func Back(_ sender: Any) {
        pop_single()
    }
    
    @IBAction func doneBTn(_ sender: Any) {
//        pickerView.isHidden = true
    }
    
    @IBAction func btn_StartTime(_ sender: UIButton) {
        is_StartTime = true
//        pickerView.isHidden = false
    }
    
    @IBAction func btn_DueTo(_ sender: UIButton) {
        is_StartTime = false
//        pickerView.isHidden = false
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        if is_StartTime {
            StartdateLbl.text = dateFormatter.string(from:sender.date)
        } else {
            duedateLbl.text = dateFormatter.string(from:sender.date)
        }
        
    }
    
    @IBAction func btn_update(_ sender: Any) {
        if !func_validation() {
            return
        }
        
      //  func_update_profile()
        
    }
    
    func func_validation() -> Bool {
        let is_email = isValidEmail(testStr: txt_email.text!)
        
        var is_valid = false
        if txt_name.text!.isEmpty {
            func_ShowHud_Error(with: "Enter name")
            is_valid = false
        } else if txt_email.text!.isEmpty {
            func_ShowHud_Error(with: "Enter email")
            is_valid = false
        } else if !is_email {
            func_ShowHud_Error(with: "Enter valid email")
            is_valid = false
        } else if txt_mobile_no.text!.isEmpty {
            func_ShowHud_Error(with: "Enter mobile number")
            is_valid = false
        }
//        else if StartdateLbl.text! == "--:--" {
//            func_ShowHud_Error(with: "Select Start Date")
//            is_valid = false
//        }  else if duedateLbl.text! == "--:--" {
//            func_ShowHud_Error(with: "Select Due Date")
//            is_valid = false
//        }
        else {
            is_valid = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_HideHud()
        }
        
        return is_valid
    }
    
    func func_update_profile() {
        pop_single()
    }
    
}



extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
}

