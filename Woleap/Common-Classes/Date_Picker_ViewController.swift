//
//  Date_Picker_ViewController.swift
//  Woleap
//
//  Created by ayush pathak on 19/07/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit

class Date_Picker_ViewController: UIViewController {
    @IBOutlet weak var view_container:UIView!
    @IBOutlet weak var date_picker:UIDatePicker!
    
    var selected_date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_container.layer.shadowOpacity = 1.0
        view_container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_container.layer.shadowRadius = 2.0
        view_container.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        date_picker.setDate(Date(), animated: true)
        selected_date = func_DatePickerDate(date_picker.date)
    }
    
    @IBAction func date_picker(_ sender:UIDatePicker) {
        selected_date = func_DatePickerDate(sender.date)
    }
    
    @IBAction func btn_cancel(_ sender:UIButton) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func btn_done(_ sender:UIButton) {
        self.view.removeFromSuperview()
        let dict_selected_date = ["selected_date": selected_date]
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selected_date"), object: nil, userInfo: dict_selected_date)
    }
    
    
    
}
