//  New_Achiv_PopUp_ViewController.swift
//  Woleap

//  Created by ayush pathak on 19/07/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

var type_add = 0

class New_Achiv_PopUp_ViewController: UIViewController {
    @IBOutlet weak var txt_add_tite:UITextField!
    @IBOutlet weak var view_container:UIView!
    
    @IBOutlet weak var set_date_lbl:UILabel!
    
    @IBOutlet weak var header_lbl:UILabel!
    @IBOutlet weak var date_header_lbl:UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_add_tite.setLeftPaddingPoints(10)
        txt_add_tite.setLeftPaddingPoints(10)
        
        view_container.layer.shadowOpacity = 5.0
        view_container.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view_container.layer.shadowRadius = 5.0
        view_container.layer.shadowColor = UIColor .lightGray.cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_selected_date), name: NSNotification.Name (rawValue: "selected_date"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if type_add == 0 {
            header_lbl.text = "New Achievement"
            date_header_lbl.text = "Achievement Date"
        } else if type_add == 1 {
            header_lbl.text = "New Goal"
            date_header_lbl.text = "Goal Date"
        } else {
            header_lbl.text = "New List"
            date_header_lbl.text = "List Date"
        }
        
        let datee = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        set_date_lbl.text = dateFormatter.string(from: datee)
    }
    
    @objc func func_selected_date (_ sender:Notification) {
        set_date_lbl.text = "\(sender.userInfo!["selected_date"]!)"
        
    }
    
    @IBAction func btn_set_date(_ sender:UIButton) {
        
        let maxDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
//        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "show_date_picker"), object: nil)
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", maximumDate: maxDate, datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.set_date_lbl.text = formatter.string(from: dt)
            }
        }
    }
    
    @IBAction func btn_cancel(_ sender:UIButton) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func AddBtn(_ sender: Any) {

        if !func_validation() {
            return
        }
        
        if type_add == 0 {
            add_any_event(event_type: .achivement)
        } else if type_add == 1 {
            add_any_event(event_type: .goals)
        } else {
           add_any_event(event_type: .lists)
        }
    }
    
    func func_validation() -> Bool {
        var is_valid = false
        
        if txt_add_tite.text!.isEmpty && txt_add_tite.text!.remove_white_string() != ""{
            func_ShowHud_Error(with: "Add your title")
            is_valid = false
        } else {
            is_valid = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_HideHud()
        }
        
        return is_valid
    }
}



extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}


extension New_Achiv_PopUp_ViewController{
    //    MARK: API
    
    func add_any_event(event_type:event_type) {
        func_ShowHud()
        self.view.endEditing(true)
        var param = [String:Any]()
        var url_str = ""
        
        switch event_type {
        case .achivement:
            url_str = "create_archievement"
            param = [
                "user_id":model_login.shared.id,
                "title":txt_add_tite.text!,
                "date":set_date_lbl.text!,
                "is_personal":"\(is_work_or_personal)",
                "operating_level":"",
                "archievement_skills":"[]",
                "archievement_business_benefits":"[]"
            ]
        case .goals:
            url_str = "create_goal"
            if model_home.shared.get_archievements_title.contains(txt_add_tite.text!){
                param = [
                    "user_id":model_login.shared.id,
                    "title":txt_add_tite.text!,
                    "date":set_date_lbl.text!,
                    "is_personal":"\(is_work_or_personal)",
                    "is_achievment":"1",
                    "archievement_data":"[]",
                    "task_data":"[]"
                ]
            }else{
                param = [
                    "user_id":model_login.shared.id,
                    "title":txt_add_tite.text!,
                    "date":set_date_lbl.text!,
                    "is_personal":"\(is_work_or_personal)",
                    "is_achievment":"0",
                    "archievement_data":"[]",
                    "task_data":"[]"
                ]
            }
        case .lists:
            url_str = "create_task"
            param = [
                "user_id":model_login.shared.id,
                "name":txt_add_tite.text!,
                "start_date":set_date_lbl.text!,
                "is_personal":"\(is_work_or_personal)",
                "end_date":set_date_lbl.text!,
                "archievement_data":"[]"
            ]
        }
    
        APIFunc.postAPI(url: k_base_url+url_str, parameters: param) { (resp) in
            let status = return_status(resp)
            switch status{
            case .success:
                self.func_HideHud()
                self.view.removeFromSuperview()
                NotificationCenter.default.post(name: NSNotification.Name (rawValue: "refresh_get_home"), object: nil)
            case .fail:
                self.func_HideHud()
                self.func_ShowHud_Error(with: "\(resp["message"]!)")
            case .error_from_api:
                self.func_HideHud()
                self.func_ShowHud_Error(with: resp["error_message"] as! String)
            }
        }
        
        
    }
    
    enum event_type{
        case achivement
        case goals
        case lists
    }
}
