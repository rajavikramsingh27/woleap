//
//  NewViewController.swift
//  Woleap
//
//  Created by ayush pathak on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices



class CreateGoal_ViewController: UIViewController {
    var emptylbl = UILabel()
    var emptybutton = UIButton()
    
//     Marks: IBOutlets
    @IBOutlet weak var TitleTxtFld: UITextField!
    @IBOutlet weak var SetdateTxtfld: UILabel!
    @IBOutlet weak var SwitchBTN: UISwitch!
    @IBOutlet weak var SetDateView: UIView!
    @IBOutlet weak var Critical: UIView!
    @IBOutlet weak var txt_comment: UITextView!
    
    @IBOutlet weak var JobRltView: UIView!
    @IBOutlet weak var PersonView: UIView!
    @IBOutlet weak var NOView: UIView!
    @IBOutlet weak var YEsView: UIView!
    @IBOutlet weak var Yes2View: UIView!
    @IBOutlet weak var No2View: UIView!
    @IBOutlet weak var UPLOADView: UIView!

//    @IBOutlet weak var TaskView: UIView!

    @IBOutlet weak var notstrtBtn: UIButton!
    @IBOutlet weak var inprogBtn: UIButton!
    @IBOutlet weak var ComplitionBtn: UIButton!
    @IBOutlet weak var PAstBtn: UIButton!
    @IBOutlet weak var JobBtn: UIButton!
    @IBOutlet weak var Persobtn: UIButton!
    @IBOutlet weak var carrerbtn: UIButton!
    @IBOutlet weak var carreryesBTn: UIButton!
    @IBOutlet weak var Achivenobtn: UIButton!
    @IBOutlet weak var achivyesBtn: UIButton!

//    @IBOutlet weak var taskfivebtn: UIButton!

    @IBOutlet weak var NotStrtlbl: UILabel!
    @IBOutlet weak var progresslbl: UILabel!
    @IBOutlet weak var completeLbl: UILabel!
    @IBOutlet weak var pastduelbl: UILabel!

    @IBOutlet weak var Jobrltdlbl: UILabel!
    @IBOutlet weak var personalbtn: UILabel!
    @IBOutlet weak var carrernolbl: UILabel!
    @IBOutlet weak var carreryeslbl: UILabel!
    @IBOutlet weak var achivyeslbl: UILabel!
    @IBOutlet weak var achivnolbl: UILabel!

//    @IBOutlet weak var tasklbl: UILabel!
    
    @IBOutlet weak var lbl_attached_file_name: UILabel!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var criticalbtn: UIButton!
    
    @IBOutlet weak var progress_status: UIProgressView!
    
    @IBOutlet weak var crirticallbl: UILabel!
    
    @IBOutlet weak var tbl_goal_tasks:UITableView!
    @IBOutlet weak var view_goal_tasks:UIView!
    @IBOutlet weak var lbl_goal_tasks_title:UILabel!
    
    var str_critical = "0"
    var str_status = ""
    var str_category = ""
    var str_NextLevel = ""
    var str_WasAchievement = ""
    
    var arr_task_data = [Model_CreateGoal]()
    var arr_archievement_data = [Model_CreateGoal]()
    
    @IBOutlet weak var height_task: NSLayoutConstraint!
    @IBOutlet weak var height_goals: NSLayoutConstraint!
    @IBOutlet weak var height_container_view: NSLayoutConstraint!
    
    @IBOutlet weak var tbl_tasks:UITableView!
    @IBOutlet weak var tbl_goals_achievment:UITableView!
    
    @IBOutlet weak var lbl_select_task:UILabel!
    @IBOutlet weak var lbl_select_achievement:UILabel!
    
    var arr_added_achievement = [Model_Calendar]()
    var arr_added_tasks = [Model_Calendar]()
    var arr_add_more = [Model_Calendar]()
    
    var arr_selected_achievement = [Bool]()
    var arr_selected_tasks = [Bool]()
    
    var is_achievement = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_goal_tasks.isHidden = true
        
        TitleTxtFld.curvecorner()
        SetDateView.curvecorner()
        Critical.curvecorner()
        txt_comment.curvecorner()
        JobRltView.curvecorner()
        PersonView.curvecorner()
        NOView.curvecorner()
        YEsView.curvecorner()
        Yes2View.curvecorner()
        No2View.curvecorner()
        UPLOADView.curvecorner()
        
        TitleTxtFld.padding()
        txt_comment.contentInset = UIEdgeInsets (top: 5, left: 10, bottom: 5, right: 10)
        
        txt_comment.layer.cornerRadius = 4
        txt_comment.clipsToBounds = true
        
        SwitchBTN.set(width: 47, height: 27)
        
        func_shadow_1(view: pickerView)
        
//        for _ in Model_Calendar.shared.arr_get_list {
//            arr_selected_tasks.append(false)
//        }
//
//        for _ in Model_Calendar.shared.arr_get_archievements {
//            arr_selected_achievement.append(false)
//        }
//
//        if !is_from_long_gesture {
//            if Model_CreateGoal.shared.is_personal == "0" {
//                SwitchBTN.isOn = false
//            } else {
//                SwitchBTN.isOn = true
//            }
//
//            SwitchBTN.isUserInteractionEnabled = false
//            func_get_goal_by_id()
//        } else {
//            if Model_Calendar.shared.arr_get_list.count == 0 {
//                self.height_task.constant = 0
//                lbl_select_task.text = "No task created"
//            } else {
                self.height_task.constant = 60
//            }
//
//            if Model_Calendar.shared.arr_get_goals.count == 0 {
//                self.height_goals.constant = 0
//                lbl_select_achievement.text = "No achievement created"
//            } else {
                self.height_goals.constant = 60
//            }
//
            self.height_container_view.constant = 700+height_task.constant+self.height_goals.constant+400
//
//            UIView.animate(withDuration: 0.2) {
//                self.view.layoutIfNeeded()
//            }
//        }
        
    }
    
    func func_set_UI_ForUpdate() {
        
     
    }
    
//   Marks : IBAction
    @IBAction func HomeBtn(_ sender: Any) {
        pop_single()
    }
    
    @IBAction func SwitchBTn(_ sender: UISwitch) {
        
    }
    
    
    
    @IBAction func NotstrtBtn(_ sender: Any) {
        str_status = "Not Started"
        
        btn2(button: notstrtBtn, button2: ComplitionBtn, button3: PAstBtn, button4: inprogBtn, label: NotStrtlbl, label2: progresslbl, label3: completeLbl, label4: pastduelbl)
        
        let full_width = self.view.bounds.width-40
        let one_width = full_width/4
        progress_status.progress = Float(one_width/full_width)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func InprogressBtn(_ sender: Any) {
    str_status = "In Progress"
        
       btn2(button: inprogBtn, button2: ComplitionBtn, button3: PAstBtn, button4: notstrtBtn, label: progresslbl, label2: NotStrtlbl, label3: completeLbl, label4: pastduelbl)
        self.view.endEditing(true)
        pickerView.isHidden = true
        
        let full_width = self.view.bounds.width-40
        let one_width = full_width/4*2
        progress_status.progress = Float(one_width/full_width)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    @IBAction func CompleteBtn(_ sender: Any) {
        str_status = "Complete"
        
       btn2(button: ComplitionBtn, button2: notstrtBtn, button3: PAstBtn, button4: inprogBtn, label: completeLbl, label2: progresslbl, label3: NotStrtlbl, label4: pastduelbl)
        self.view.endEditing(true)
        pickerView.isHidden = true
        
        let full_width = self.view.bounds.width-40
        let one_width = full_width/4*3
        progress_status.progress = Float(one_width/full_width)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func PastdateBTn(_ sender: Any) {
        str_status = "Past Due"
        
          btn2(button: PAstBtn, button2: notstrtBtn, button3: ComplitionBtn, button4: inprogBtn, label: pastduelbl, label2: completeLbl, label3: NotStrtlbl, label4: progresslbl)
        self.view.endEditing(true)
        pickerView.isHidden = true
        
        let full_width = self.view.bounds.width-40
        let one_width = full_width/4*4
        progress_status.progress = Float(one_width/full_width)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func JobRltBtn(_ sender: Any) {
        str_category = "Job Related"
        
        btn(button: JobBtn, button2: Persobtn ,label: Jobrltdlbl, label2: personalbtn)
        self.view.endEditing(true)
        pickerView.isHidden = true
        
    }


    @IBAction func PersonalBtn(_ sender: Any) {
        str_category = "Personal Ambition/Growth"
        
        btn(button: Persobtn, button2: JobBtn ,label: personalbtn, label2: Jobrltdlbl)

        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    

    @IBAction func CareerNOBtn(_ sender: Any) {
        str_NextLevel = "No"

        btn(button: carrerbtn, button2: carreryesBTn ,label: carrernolbl, label2: carreryeslbl)

        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
    @IBAction func CarrerYesBtn(_ sender: Any) {
        str_NextLevel = "Yes"
        
        btn(button: carreryesBTn, button2: carrerbtn ,label: carreryeslbl, label2: carrernolbl)
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
    
    @IBAction func AchivYEsBTn(_ sender: Any) {
        str_WasAchievement = "Yes"
        
        btn(button: achivyesBtn ,button2: Achivenobtn, label: achivyeslbl, label2: achivnolbl)
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
    @IBAction func AchivNoBtn(_ sender: Any) {
        str_WasAchievement = "No"

        btn(button: Achivenobtn ,button2: achivyesBtn, label: achivnolbl, label2: achivyeslbl)
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
    @IBAction func AttchAddBtn(_ sender: Any) {
        
    }
    
//    @IBAction func FiveTskBtn(_ sender: Any) {
//        btn(button: taskfivebtn, button2: addmorebtn,label: tasklbl, label2: addmorelbl)
//        self.view.endEditing(true)
//        pickerView.isHidden = true
//    }
//
//    @IBAction func AddMoreBTn(_ sender: Any) {
//        btn(button: addmorebtn, button2: taskfivebtn,label: addmorelbl, label2: tasklbl)
//        self.view.endEditing(true)
//        pickerView.isHidden = true
//    }
//
//    @IBAction func CreateBtn(_ sender: Any) {
//        btn(button: createBtn, button2: addmore2 ,label: createplnlbl, label2: Addmorelbbl)
//        self.view.endEditing(true)
//        pickerView.isHidden = true
//    }
    
    
    
//    @IBAction func AddBTn2(_ sender: Any) {
//        btn(button: addmore2, button2: createBtn ,label: Addmorelbbl, label2: createplnlbl)
//
//        self.view.endEditing(true)
//        pickerView.isHidden = true
//
//    }
    
    
    @IBAction func SaveBtn(_ sender: Any) {
//        if is_from_long_gesture {
            if !func_validation() {
                return
            }
//        }
        
        pop_single()
    
//        Model_CreateGoal.shared.comment = txt_comment.text!
//        if txt_comment.text == "Add additional details..." {
//            Model_CreateGoal.shared.comment = ""
//        }
//
//        Model_CreateGoal.shared.archievement_data.removeAll()
//        for model in arr_archievement_data {
//            let dict_archievement = ["archievement_id":model.id,"date":model.date]
//            Model_CreateGoal.shared.archievement_data.append(dict_archievement)
//        }
//
//        Model_CreateGoal.shared.task_data.removeAll()
//        for model in arr_task_data {
//            let dict_task = ["task_id":model.id,"date":model.date]
//            Model_CreateGoal.shared.task_data.append(dict_task)
//        }
//
//        if !is_from_long_gesture {
//            func_update_goal()
//        } else {
//            func_create_goal()
//        }
        
        
        
    }
    
    
    
    func func_validation() -> Bool {
        var is_valid = false
        
        if TitleTxtFld.text!.isEmpty {
            func_ShowHud_Error(with: "Add your title")
            is_valid = false
        } else if SetdateTxtfld.text == "SET DATE" {
            func_ShowHud_Error(with: "Set your date")
            is_valid = false
        } else if str_status.isEmpty {
            func_ShowHud_Error(with: "Select your status")
            is_valid = false
        } else if str_category.isEmpty {
            func_ShowHud_Error(with: "Select your category")
            is_valid = false
        } else if str_NextLevel.isEmpty {
            func_ShowHud_Error(with: "Select your next level")
            is_valid = false
        } else if str_WasAchievement.isEmpty {
            func_ShowHud_Error(with: "Was your achievement")
            is_valid = false
        } else {
            is_valid = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_HideHud()
        }
        
        return is_valid
    }
    
    @IBAction func criticalBTn(_ sender: Any) {
        criticalbtn.isSelected = !criticalbtn.isSelected
        
        if criticalbtn.isSelected {
            str_critical = "1"
            
            criticalbtn.setImage(UIImage(named: "tick-2"), for: .normal)
            criticalbtn.backgroundColor = UIColor (red: 74.0/255.0, green: 119.0/255.0, blue: 246.0/255.0, alpha: 1.0)
            
            crirticallbl.textColor = UIColor.black
        } else {
            str_critical = "0"
            
            criticalbtn.setImage(UIImage(named: ""), for: .normal)
            criticalbtn.backgroundColor = UIColor.lightGray
            crirticallbl.textColor = UIColor.lightGray
        }
        
    }
    

    
    @IBAction func calenderBtn(_ sender: Any) {
        pickerView.isHidden = false
        
        self.view.endEditing(true)
    }
    
    @IBAction func pickethiddenBtn(_ sender: Any) {
        pickerView.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func datepicker(_ sender: UIDatePicker) {
        SetdateTxtfld.text = func_DatePickerDate(sender.date)
        self.view.endEditing(true)
    }
    
}



extension CreateGoal_ViewController :UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add additional details..." {
            textView.text = ""
            textView.textColor = UIColor .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Add additional details..."
            textView.textColor = UIColor .darkGray
        }
    }
    
}



extension CreateGoal_ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func btn_upload_attachment(_ sender:UIButton) {
        func_ChooseImage()
    }
    
    func func_camera_permission(completion:@escaping (Bool)->()) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if !granted {
                DispatchQueue.main.async {
                    let alert = UIAlertController (title: "Woleap would like to access the camera", message: "Woleap needs Camera and PhotoLibrary to complete achievement,goals and list", preferredStyle: .alert)
                    let yes = UIAlertAction(title: "Don't allow", style: .default) { (yes) in
                        
                    }
                    
                    let no = UIAlertAction(title: "Allow", style: .default) { (yes) in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }
                    }
                    
                    alert.addAction(yes)
                    alert.addAction(no)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            completion(granted)
        }
    }
    
    func func_ChooseImage() {
        let alert = UIAlertController(title: "", message: "Please select!", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenCamera()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.func_OpenGallary()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Documents", style: .default , handler:{ (UIAlertAction)in
            DispatchQueue.main.async {
                self.clickFunction()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func clickFunction() {
        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }

    
    func func_OpenCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera))
        {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate=self
            
//            func_camera_permission { (is_permission) in
//                if is_permission {
//                    DispatchQueue.main.async {
//                        self.present(imagePicker, animated: true, completion: nil)
//                    }
//                }
//            }
        }
        else
        {
            let alert  = UIAlertController(title: "Warning!", message: "You don't have camera in simulator", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func func_OpenGallary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate=self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if #available(iOS 11.0, *) {
                lbl_attached_file_name.text = "Your attachment \(info[UIImagePickerController.InfoKey.referenceURL] ?? "URL is nil")"
            } else {
                lbl_attached_file_name.text = "Version Problem"
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}



extension CreateGoal_ViewController {
    func func_create_goal() {
        func_ShowHud()
//        Model_CreateGoal.shared.func_create_goal { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                
//                if status == "1" {
//                    self.func_ShowHud_Success(with: Model_CreateGoal.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_CreateGoal.shared.message)
//                }
//                
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    if status == "1" {
//                        self.dismiss_ViewControllers()
//                    }
//                })
//            }
//        }
        
    }
    
    @objc func func_get_goal_by_id() {
        func_ShowHud()
//        Model_CreateGoal.shared.func_get_goal_by_id { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//
//                self.func_set_UI_ForUpdate()
//            }
//        }
    }
    
    func func_update_goal() {
        func_ShowHud()
//        Model_CreateGoal.shared.func_update_goal { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//
//                if status == "1" {
//                    self.func_ShowHud_Success(with: Model_CreateGoal.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_CreateGoal.shared.message)
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    if status == "1" {
//                        self.dismiss_ViewControllers()
//                    }
//                })
//            }
//        }
        
    }
    
}



extension CreateGoal_ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl_goals_achievment {
            return arr_archievement_data.count+1
//            return arr_added_goals.count+1
        } else if tableView == tbl_tasks {
                return arr_task_data.count+1
//            return arr_added_tasks.count+1
        } else {
            return arr_add_more.count
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl_goals_achievment {
            if indexPath.row == arr_archievement_data.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell-2", for: indexPath) as! Add_More_TableViewCell
                
                cell.btn_add_more.tag = 1
                cell.btn_add_more.addTarget(self, action: #selector(btn_add_more(_:)), for: .touchUpInside)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell-1", for: indexPath) as! Add_Goal_TableViewCell
                let model = arr_archievement_data[indexPath.row]
//
//                cell.lbl_title.text = model.title
//                cell.lbl_date.text = model.date
                
                cell.btn_delete.tag = indexPath.row
                cell.btn_delete.addTarget(self, action: #selector(btn_remove_goal_archievement(_:)), for: .touchUpInside)
                
                return cell
            }
        } else if tableView == tbl_tasks {
            if indexPath.row == arr_task_data.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell-2", for: indexPath) as! Add_More_TableViewCell
                
                cell.btn_add_more.tag = 11
                cell.btn_add_more.addTarget(self, action: #selector(btn_add_more(_:)), for: .touchUpInside)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell-1", for: indexPath) as! Add_Task_TableViewCell
                let model = arr_task_data[indexPath.row]
                
//                cell.lbl_title.text = model.name
//                cell.lbl_date.text = model.date
                
                cell.btn_delete.tag = indexPath.row
                cell.btn_delete.addTarget(self, action: #selector(btn_remove_goal_task(_:)), for: .touchUpInside)
                
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TechPopupTableViewCell
            
            let model = arr_add_more[indexPath.row]
            
            cell.AddBtn.tag = indexPath.row
            cell.AddBtn.addTarget(self, action: #selector(btn_DoAdd(_:)), for: .touchUpInside)
            
            if is_achievement {
//                cell.DemoLbl.text = model.title
                
                if arr_selected_achievement[indexPath.row] {
                    cell.AddBtn.isSelected = true
                    cell.ImgView.isHidden = false
                } else {
                    cell.AddBtn.isSelected = false
                    cell.ImgView.isHidden = true
                }
            } else {
//                cell.DemoLbl.text = model.name
                
                if arr_selected_tasks[indexPath.row] {
                    cell.AddBtn.isSelected = true
                    cell.ImgView.isHidden = false
                } else {
                    cell.AddBtn.isSelected = false
                    cell.ImgView.isHidden = true
                }
            }
            
            return cell
        }
    }
    
    @IBAction func btn_remove_goal_archievement(_ sender: UIButton) {
//        Model_CreateGoal.shared.id = arr_archievement_data[sender.tag].id
//        func_ShowHud()
        
//        Model_CreateGoal.shared.func_remove_goal_archievement { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                if status == "success" {
//                    self.func_ShowHud_Success(with: Model_CreateGoal.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_CreateGoal.shared.message)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    self.func_get_goal_by_id()
//                })
//            }
//        }
    }
    
    @IBAction func btn_remove_goal_task(_ sender: UIButton) {
//        Model_CreateGoal.shared.id = arr_task_data[sender.tag].id
//        func_ShowHud()
//        Model_CreateGoal.shared.func_remove_goal_task { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                if status == "success" {
//                    self.func_ShowHud_Success(with: Model_CreateGoal.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_CreateGoal.shared.message)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    self.func_get_goal_by_id()
//                })
//            }
//        }
    }
    
    
    
    @IBAction func btn_DoAdd(_ sender:UIButton) {
//        if is_achievement {
//            for i in 0..<arr_selected_achievement.count {
//                if i == sender.tag {
//                    if arr_selected_achievement[i] {
//                        arr_selected_achievement[i] = false
//                    } else {
//                        arr_selected_achievement[i] = true
//                    }
//                }
//            }
//        } else {
//            for i in 0..<arr_selected_tasks.count {
//                if i == sender.tag {
//                    if arr_selected_tasks[i] {
//                        arr_selected_tasks[i] = false
//                    } else {
//                        arr_selected_tasks[i] = true
//                    }
//                }
//            }
//        }
//        tbl_goal_tasks.reloadData()
    }
    
    @IBAction func btn_add_more(_ sender:UIButton) {
        view_goal_tasks.isHidden = false
        
        if sender.tag == 1 {
            is_achievement = true
            lbl_goal_tasks_title.text = "Select your achievements"
//            arr_add_more = Model_Calendar.shared.arr_get_archievements
        } else {
            is_achievement = false
            lbl_goal_tasks_title.text = "Select your tasks"
//            arr_add_more = Model_Calendar.shared.arr_get_list
        }
        tbl_goal_tasks.reloadData()
    }
    
    @IBAction func btn_cancel_goals_task(_ sender:UIButton) {
        view_goal_tasks.isHidden = true
    }

    
    @IBAction func btn_done_goals_task(_ sender:UIButton) {
        view_goal_tasks.isHidden = true
        
//        if is_achievement {
////            arr_added_goals.removeAll()
//            arr_archievement_data.removeAll()
//            for i in 0..<arr_selected_achievement.count {
//                if i == sender.tag {
//                    if arr_selected_achievement[i] {
//                        let model_more = arr_add_more[i]
//
//                        var dic = [String:Any]()
//
//                        dic["title"] = model_more.title
//                        dic["archievement_id"] = model_more.id
//                        dic["id"] = model_more.id
//                        dic["goal_id"] = model_more.id
//
//                        dic["created"] = model_more.date
//                        dic["date"] = model_more.date
//
//                        arr_archievement_data.append(Model_CreateGoal.shared.func_set_goal_achievement(dic))
////                        arr_added_goals=arr_add_more
//                    }
//                }
//            }
//            tbl_goals_achievment.reloadData()
//        } else {
////            arr_added_tasks.removeAll()
//            arr_task_data.removeAll()
//            for i in 0..<arr_selected_tasks.count {
//                if i == sender.tag {
//                    if arr_selected_tasks[i] {
////                        arr_added_tasks=arr_add_more
//
//                        let model_more = arr_add_more[i]
//
//                        var dic = [String:Any]()
//
//                        dic["title"] = model_more.name
//                        dic["archievement_id"] = model_more.id
//                        dic["id"] = model_more.id
//                        dic["goal_id"] = model_more.id
//
//                        dic["created"] = model_more.date
//                        dic["date"] = model_more.start_date
//
//                        arr_task_data.append(Model_CreateGoal.shared.func_set_goal_tasks(dic))
//                    }
//                }
//            }
//            tbl_tasks.reloadData()
//        }
//
//        if arr_task_data.count == 0 {
//            self.height_task.constant = 60
//        } else {
//            self.height_task.constant = CGFloat(60*(arr_task_data.count+1))
//        }
//
//        if arr_archievement_data.count == 0 {
//            self.height_goals.constant = 60
//        } else {
//            self.height_goals.constant = CGFloat(60*(arr_archievement_data.count+1))
//        }
//
//        self.height_container_view.constant = 700+height_task.constant+self.height_goals.constant+400
//
//        UIView.animate(withDuration: 0.2) {
//            self.view.layoutIfNeeded()
//        }
    }
    
}



extension CreateGoal_ViewController: UIDocumentMenuDelegate,UIDocumentPickerDelegate {
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
    }
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
}
