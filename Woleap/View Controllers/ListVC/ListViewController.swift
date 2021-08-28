//  ListViewController.swift
//  Woleap

//  Created by Devender Singh Shekhawat on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var emptyLbl = UILabel()
    var emtyBtn = UIButton()
//    Marks: IBOutlets
    
    @IBOutlet weak var HomeBtn: UIButton!
    @IBOutlet weak var SearchTxtFld: UITextField!
    @IBOutlet weak var txtListName: UITextField!
    
    @IBOutlet weak var RoundBtn: UIView!
    @IBOutlet weak var SwitchBTN: UISwitch!
    @IBOutlet weak var Stkview: UIView!
    @IBOutlet weak var curveLbl: UILabel!
    @IBOutlet weak var Superlist: UIButton!
    @IBOutlet weak var superlistBtn: UIButton!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var pending: UIButton!
    @IBOutlet weak var complete: UIButton!
    
    @IBOutlet weak var view_DatePickerContainer: UIView!
    
    @IBOutlet weak var starttime: UILabel!
    @IBOutlet weak var duetime: UILabel!
    @IBOutlet weak var starttimeBtn: UIButton!
    @IBOutlet weak var duetimeBtn: UIButton!
    @IBOutlet weak var scheduleBtn: UIButton!
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var reminderBtn: UIButton!
    @IBOutlet weak var reminderLbl: UILabel!
    
    @IBOutlet weak var btn_pending: UIButton!
    @IBOutlet weak var btn_complete: UIButton!
    
    @IBOutlet weak var viewSnooze: UIView!
    
    @IBOutlet weak var tblTaskList: UITableView!
    @IBOutlet weak var lblTaskList: UILabel!
    
    @IBOutlet weak var txt_search: UITextField!
    
    var is_startTime = false
    var str_status = ""
    var strListType = ""
    
    var arr_searched = [Model_CreateList]()
    var arr_for_search = [Model_CreateList]()
    var arrTaskLists = [Model_CreateList]()
    
    var isUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RoundBtn.layer.cornerRadius = RoundBtn.frame.width/2
        func_shadow(view: RoundBtn, color: UIColor.lightGray,CorRad: 0)
        SwitchBTN.set( width: 47, height: 27)
        
        func_btn(btn: Stkview, CR: 3, color: UIColor.lightGray, brwidth: 0.3, Shadow: 0.0, ShadowRadius: 0)
        hideView.backgroundColor = UIColor.init(red: 153.0/255.0, green: 190.0/255.0, blue: 206.0/255.0, alpha: 0.5)
        superlistBtn.curvecorner()
        curveLbl.curvecorner()
        curveLbl.clipsToBounds = true
        
        func_shadows(view_DatePickerContainer)
        func_shadows(view_pickerContainer)
        
        view_DatePickerContainer.isHidden = true
        
        viewSnooze.isHidden = true
        view_pickerContainer.isHidden = true
        hideView.isHidden = true
        
//        SwitchBTN.isUserInteractionEnabled = false
//        if Model_New_Achievement.shared.is_personal == "0" {
//            SwitchBTN.isOn = false
//        } else {
//            SwitchBTN.isOn = true
//        }
        
       // func_get_home_data()
    }
    
    
    @objc func func_get_home_data() {
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        funcReloadTaskFrom()
    }
    
    func func_shadows(_ view:UIView) {
        view.layer.shadowOpacity = 5.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 5.0
        view.layer.shadowColor = UIColor .lightGray.cgColor
    }
    
    
    // Marks:IBaction
    @IBAction func SwitchBtn(_ sender: Any) {
        
    }
    
    @IBAction func DateBtn(_ sender: Any) {
        
    }
    
    @IBAction func AddBtn(_ sender: Any) {
        hideView.isHidden = false
        isUpdate = false
    }
    
    @IBAction func SearchBtn(_ sender: Any) {
        
    }
    
    @IBAction func SuperlistBtn(_ sender: Any) {
        tagbtn(sender: Superlist, btn: pending, btn2: complete)
        
//        strListType = "super-list"
//
//        self.arrTaskLists = Model_CreateList.shared.arrSuperList
//        self.arr_for_search = self.arrTaskLists
//        if self.arrTaskLists.count == 0 {
//            self.tblTaskList.isHidden = true
//            self.lblTaskList.text = "Super List is not available"
//        } else {
//            self.tblTaskList.isHidden = false
//        }
//
        self.tblTaskList.reloadData()
    }
    
    @IBAction func PendingBtn(_ sender: Any) {
//
        tagbtn(sender: pending, btn: Superlist, btn2: complete)

//        strListType = "pending"
//        self.arrTaskLists = Model_CreateList.shared.arrPending
//        self.arr_for_search = self.arrTaskLists
//        if self.arrTaskLists.count == 0 {
//            self.tblTaskList.isHidden = true
//            self.lblTaskList.text = "Pending List is not available"
//        } else {
//            self.tblTaskList.isHidden = false
//        }
//
        self.tblTaskList.reloadData()
    }
    
    @IBAction func CompleteBtn(_ sender: Any) {
        tagbtn(sender: complete, btn: pending, btn2: Superlist)
//        strListType = "complete"
//
//        self.arrTaskLists = Model_CreateList.shared.arrComplete
//        self.arr_for_search = self.arrTaskLists
//        if self.arrTaskLists.count == 0 {
//            self.tblTaskList.isHidden = true
//            self.lblTaskList.text = "Completed List is not available"
//        } else {
//            self.tblTaskList.isHidden = false
//        }
//
        self.tblTaskList.reloadData()
    }
    
    @IBAction func HomeBtn(_ sender: Any) {
        pop_single()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//arrTaskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Listvc = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableViewCell
//        let model = arrTaskLists[indexPath.row]
        
        Listvc.targetBtn.tag = indexPath.row
        Listvc.targetBtn.addTarget(self, action: #selector(btnSelectTaskList(_:)), for:.touchUpInside)
        
//        Listvc.TempLbl.text = model.name
//        Listvc.DateLbl.text = model.end_date
        
//        if model.status == "" || model.status == "pending" {
//            Listvc.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
//        } else {
//            if model.status == "super-list" {
//                Listvc.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
//            } else {
//                Listvc.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
//            }
//        }
//
        Listvc.ImgView.image = UIImage(named: "target")
        
        func_btn(btn: Listvc.ListView, CR: 5,color: UIColor.lightGray, brwidth: 0, Shadow: 1, ShadowRadius: 1.0)
        
        return Listvc
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    
    
    @IBAction func btnSelectTaskList(_ sender: UIButton) {
        isUpdate = true
//        if self.strListType == "super-list" {
//            Model_CreateList.shared.id = Model_CreateList.shared.arrSuperList[sender.tag].id
//        } else if self.strListType == "pending" {
//            Model_CreateList.shared.id = Model_CreateList.shared.arrPending[sender.tag].id
//        } else {
//            Model_CreateList.shared.id = Model_CreateList.shared.arrComplete[sender.tag].id
//        }
//
//        func_get_task_by_id()
    }
    
    
    
    func func_get_task_by_id() {
       
    }
    
    func funcReload_Task_For_Update() {
       
        
    }
    
    @IBAction func superlistBtn(_ sender: Any) {
        hideView.isHidden = true
    }
    
    @IBAction func Datepicker(_ sender: UIDatePicker) {
        if is_startTime {
            starttime.text = func_DatePickerDate(sender.date)
        } else {
            duetime.text = func_DatePickerDate(sender.date)
        }
    }
    
    @IBAction func btn_cancel_DP(_ sender: Any) {
        view_DatePickerContainer.isHidden = true
    }
    
    @IBAction func btn_done_DP(_ sender: UIDatePicker) {
        view_DatePickerContainer.isHidden = true
    }
    
    @IBAction func strttimeBtn(_ sender: Any) {
        view_DatePickerContainer.isHidden = false
        is_startTime = true
    }
    
    @IBAction func duetimebtn(_ sender: Any) {
        view_DatePickerContainer.isHidden = false
        is_startTime = false
    }
    
    @IBAction func reminderBtn(_ sender: Any) {
        btn(button: reminderBtn, button2: emtyBtn, label: reminderLbl, label2: emptyLbl)
    }
    
    @IBAction func ScheduleBTn(_ sender: Any) {
        btn(button: scheduleBtn, button2: emtyBtn, label: scheduleLbl, label2: emptyLbl)
    }
    
    @IBAction func btn_super_list(_ sender:UIButton) {
        btn_pending.isSelected = false
        btn_complete.isSelected = false
        superlistBtn.isSelected = true
        
        str_status = "super-list"
    }
    
    @IBAction func btn_pending(_ sender:UIButton) {
        btn_pending.isSelected = true
        btn_complete.isSelected = false
        superlistBtn.isSelected = false
        
        str_status = "complete"
    }
    
    @IBAction func btn_complete(_ sender:UIButton) {
        btn_pending.isSelected = false
        btn_complete.isSelected = true
        superlistBtn.isSelected = false
        
        str_status = "pending"
    }
    
    var is_schedule = ""
    var is_remind = ""
    
    var is_snooze = ""
    var snooze_count = ""
    
    @IBAction func btn_schedule(_ sender:UIButton) {
        scheduleBtn.isSelected = !scheduleBtn.isSelected
        if scheduleBtn.isSelected {
            is_schedule = "1"
        } else {
            is_schedule = "0"
        }
        
    }
    
    @IBAction func btn_reminder(_ sender:UIButton) {
        reminderBtn.isSelected = !reminderBtn.isSelected
        
        if reminderBtn.isSelected {
            viewSnooze.isHidden = false
            is_remind = "1"
        } else {
            viewSnooze.isHidden = true
            lbl_snoozeCount.isHidden = true
            btn_snoozeCount.isHidden = true
            btn_snoozeAction.isHidden = true
            is_remind = "0"
        }
        
    }
    
    @IBOutlet weak var lbl_snoozeCount : UILabel!
    @IBOutlet weak var btn_snoozeCount : UIButton!
    @IBOutlet weak var btn_snoozeAction : UIButton!
    @IBOutlet weak var btnSnooze : UIButton!
    
    @IBOutlet weak var view_pickerContainer : UIView!
    
    var arrSnoozeCount : [String] {
        var arr_SnoozeCount = [String]()
        for i in 1...10 {
            arr_SnoozeCount.append("\(i)")
        }
        return arr_SnoozeCount
    }
    
    @IBAction func btnSnooze(_ sender:UIButton) {
        btnSnooze.isSelected = !btnSnooze.isSelected
        
        if btnSnooze.isSelected {
            lbl_snoozeCount.isHidden = false
            btn_snoozeCount.isHidden = false
            btn_snoozeAction.isHidden = false
            is_snooze = "1"
        } else {
            lbl_snoozeCount.isHidden = true
            btn_snoozeCount.isHidden = true
            btn_snoozeAction.isHidden = true
            is_snooze = "0"
        }
    }
    
    @IBAction func btn_snoozeAction(_ sender:UIButton) {
        view_pickerContainer.isHidden = false
    }
    
    @IBAction func btn_done_pickerContainer(_ sender:UIButton) {
        view_pickerContainer.isHidden = true
    }
    
    @IBAction func btn_cancel_pickerContainer(_ sender:UIButton) {
        view_pickerContainer.isHidden = true
    }
    
    @IBAction func btn_hide_AddTaskList(_ sender:UIButton) {
        hideView.isHidden = true
    }
    
    
    
    @IBAction func btn_Add(_ sender:UIButton) {
//
//        funcReloadTaskFrom()
        if !funcValidation() {
            return
        }
        
        hideView.isHidden = true
        
//        func_ShowHud()
//
//        Model_CreateList.shared.name = txtListName.text!
//        Model_CreateList.shared.start_date = starttime.text!
//        Model_CreateList.shared.end_date = duetime.text!
//        Model_CreateList.shared.is_schedule = is_schedule
//        Model_CreateList.shared.is_remind = is_remind
//
//        Model_CreateList.shared.status = str_status
//        Model_CreateList.shared.is_snooze = is_snooze
//        Model_CreateList.shared.snooze_count = btn_snoozeCount.currentTitle!
//
////        Model_CreateList.shared.archievement_data = ""
////        Model_CreateList.shared.is_complete = ""
////        Model_CreateList.shared.is_super_list = ""
//
//        if isUpdate {
//            Model_CreateList.shared.func_update_task { (status) in
//                DispatchQueue.main.async {
//                    if status == "1" {
//                        self.func_ShowHud_Success(with: Model_CreateList.shared.message)
//                    } else {
//                        self.func_ShowHud_Error(with: Model_CreateList.shared.message)
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline:.now()+1.5, execute: {
//                        self.func_HideHud()
//                        if status == "1" {
//                            self.hideView.isHidden = true
//                            self.func_get_home_data()
//                        }
//                    })
//                }
//            }
//        } else {
//            Model_CreateList.shared.func_create_task { (status) in
//                DispatchQueue.main.async {
//                    if status == "1" {
//                        self.func_ShowHud_Success(with: Model_CreateList.shared.message)
//                    } else {
//                        self.func_ShowHud_Error(with: Model_CreateList.shared.message)
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline:.now()+1.5, execute: {
//                        self.func_HideHud()
//                        if status == "1" {
//                            self.hideView.isHidden = true
//                        }
//                    })
//                }
//            }
//        }

    }
    
    func funcReloadTaskFrom() {
        txtListName.text = ""
        
        btn_pending.isSelected = false
        btn_complete.isSelected = false
        superlistBtn.isSelected = false
        
        scheduleBtn.isSelected = false
        
        starttime.text = "YYYY-DD-MM"
        duetime.text = "YYYY-DD-MM"
        
        reminderBtn.isSelected = false
        btnSnooze.isSelected = false
        btn_snoozeCount.setTitle("", for: .normal)
        
        viewSnooze.isHidden = true
    }
    
    func funcValidation() -> Bool {
        var is_valid = false
        
        if txtListName.text!.isEmpty {
            func_ShowHud_Error(with: "Enter your list name")
            is_valid = false
        } else if str_status.isEmpty {
            func_ShowHud_Error(with: "Select Status")
            is_valid = false
        } else if starttime.text == "YYYY-DD-MM" {
            func_ShowHud_Error(with: "Select Start Date")
            is_valid = false
        } else if duetime.text == "YYYY-DD-MM" {
            func_ShowHud_Error(with: "Select Due Date")
            is_valid = false
        } else {
            is_valid = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_HideHud()
        }
        
        return is_valid
    }
    
    @IBAction func txt_Search(_ sender: UITextField) {
      
    }
    
}



extension ListViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrSnoozeCount.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrSnoozeCount[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        btn_snoozeCount.setTitle("\(arrSnoozeCount[row])", for: .normal)
    }
    
}



extension ListViewController {
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction.init(style: .destructive, title: "") { (action, view, nil) in
            print("delete")
            
//            if self.strListType == "super-list" {
//                Model_CreateList.shared.id = Model_CreateList.shared.arrSuperList[indexPath.row].id
//            } else if self.strListType == "pending" {
//                Model_CreateList.shared.id = Model_CreateList.shared.arrPending[indexPath.row].id
//            } else {
//                Model_CreateList.shared.id = Model_CreateList.shared.arrComplete[indexPath.row].id
//            }
//            self.func_remove_task()
        }
        
        delete.image = UIImage(named: "delete")
        delete.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.2196078431, blue: 0.2, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self.tblTaskList.subviews.forEach { subview in
            print("YourTableViewController: \(String(describing: type(of: subview)))")
            if (String(describing: type(of: subview)) == "UISwipeActionPullView") {
                if (String(describing: type(of: subview.subviews[0])) == "UISwipeActionStandardButton") {
                    var deleteBtnFrame = subview.subviews[0].frame
                    deleteBtnFrame.origin.y = 0
                    deleteBtnFrame.size.height = 82
                    
                    // Subview in this case is the whole edit View
                    subview.frame.origin.y =  subview.frame.origin.y + 5
                    subview.frame.size.height = 82
                    subview.subviews[0].frame = deleteBtnFrame
                    subview.backgroundColor = UIColor.clear
                }
            }
        }
    }
    
    
    
    @objc func func_remove_task() {
       
    }
    
    
    
}
