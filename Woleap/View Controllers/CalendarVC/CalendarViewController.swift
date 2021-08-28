//  CalenderViewController.swift
//  Woleap

//  Created by Devender Singh Shekhawat on 21/06/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import FSCalendar

class CalendarViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UIPickerViewDelegate,UIPickerViewDataSource, FSCalendarDelegate  {

//    Marks: IBOutlets
    @IBOutlet weak var calcirle: UIButton!
    @IBOutlet weak var SearchTxtFld: UITextField!
    @IBOutlet weak var calcircle2: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var RoundBtn: UIView!
    @IBOutlet weak var Tblview: UITableView!
    @IBOutlet weak var SwitchBTN: UISwitch!
    @IBOutlet weak var pickerBtn: UIButton!
    @IBOutlet weak var pickerLbl: UILabel!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var picker: UIPickerView!
//
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var txt_search:UITextField!
    
    
    @IBOutlet weak var view_calendar_popup: UIView!
    @IBOutlet weak var calendar_popup_top_constraint: NSLayoutConstraint!
    
    var arr_searched_ach = [Model_Calendar]()
    var arr_for_search_ach = [Model_Calendar]()
  
    private let sectionTitles = ["Achievements", "Goals", "Lists"]
    var imageArray: [UIImage] = [ UIImage(named: "medal.png")!, UIImage(named: "goal.png")!, UIImage(named: "tasks.png")!]
    var imageArray2: [UIImage] = [ UIImage(named: "exclamation-mark")!, UIImage(named: "exclamation-mark")!,UIImage(named: "exclamation-mark")!,UIImage(named: "calendar-2")!,UIImage(named: "calendar-2")!]
    var sectionIsExpanded = [false, false, false]
    let numberOfActualRowsForSection = 4
    let months = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let datef = DateFormatter()
    var date : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initviews()
        SwitchBTN.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)

    }
    
    func initviews() {
        view_calendar_popup.alpha = 0.0
        datef.dateFormat = "yyyy-MM-dd"
        if is_work_or_personal == 1{
            SwitchBTN.isOn = true
        }else{
            SwitchBTN.isOn = false
        }
        date = Date()
        calcirle.setTitle("4", for: .normal)
        calcircle2.setTitle("3", for: .normal)
        
        SwitchBTN.set( width: 47, height: 27)
        RoundBtn.layer.cornerRadius = RoundBtn.frame.width/2
        func_shadow(view: RoundBtn, color: UIColor.lightGray,CorRad: 0)
        
        calcirle.layer.cornerRadius = calcirle.frame.width/2
        calcirle.clipsToBounds = true
        calcircle2.layer.cornerRadius = calcirle.frame.width/2
        calcircle2.clipsToBounds = true
        
        calendar.scope = .week
        self.calendar.setScope(.week, animated: true)
        calendar.delegate = self
        calendar.dataSource = self
        
        func_shadow_1(view: calendarView)
        func_shadow_1(view: pickerView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh_get_home), name: NSNotification.Name (rawValue: "refresh_get_home"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let currentPageDate = calendar.currentPage
        pickerLbl.text = currentPageDate.month
        self.picker.selectRow(Int(currentPageDate.month_int)! - 1, inComponent: 0, animated: true)
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        get_data_home(user_id: model_login.shared.id, search: "", date: date.string(from: self.date), is_personal: "\(is_work_or_personal)", is_next: "0", is_due: "0")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        view_calendar_popup.fadeOut() 
            self.date = date
            get_data_home(user_id: model_login.shared.id, search: "", date: datef.string(from: self.date), is_personal: "\(is_work_or_personal)", is_next: "0", is_due: "0")
    }
    
    
    @IBAction func switch_work_personal(_ sender:UISwitch) {
        if sender.isOn{
            set_status_work_personal(type: .personal)
        }else{
           set_status_work_personal(type: .work)
        }
        get_data_home(user_id: model_login.shared.id, search: "", date: datef.string(from: self.date), is_personal: "\(is_work_or_personal)", is_next: "0", is_due: "0")
    }
    
    @IBAction func btn_due(_ sender:UIButton) {
        push_VC("Due_Next_ViewController", storyboard: "Main")
    }
    
    @IBAction func btn_next(_ sender:UIButton) {
        push_VC("Due_Next_ViewController", storyboard: "Main")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionIsExpanded.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! Calender2TableViewCell
        
        cell1.ROundView.isHidden = false
        
        cell1.AchiveLbl.text = sectionTitles[section]
        cell1.BadgeImgView.image = imageArray[section]
        
        cell1.View.isHidden = false
        cell1.Label.layer.masksToBounds = true
        cell1.Label.layer.cornerRadius = cell1.Label.frame.height/2
        
        cell1.ROundView.layer.masksToBounds = true
        cell1.ROundView.layer.cornerRadius = cell1.ROundView.frame.height/2
        cell1.ROundView.layer.borderWidth = 0.5
        cell1.ROundView.layer.borderColor = UIColor.lightGray.cgColor
        
        cell1.btn.tag = section
        cell1.btn.addTarget(self, action: #selector(tblbtn2(_:)), for: .touchUpInside)
        
        cell1.btn_show_all_list.tag = section
        cell1.btn_show_all_list.addTarget(self, action: #selector(btn_show_all_list(_:)), for: .touchUpInside)
        
        cell1.View.layer.cornerRadius = cell1.View.frame.width/2
        func_shadow(view: cell1.View, color: UIColor.lightGray,CorRad: 0)
        
        cell1.tapGesture.view?.tag = section
        cell1.longGesture.view?.tag = section
        
        cell1.tapGesture.addTarget(self, action: #selector(normalTap(sender:)))
        cell1.longGesture.addTarget(self, action: #selector(longTap(sender:)))
        
        if section == 0 {
            cell1.lbl_total_counts.text = "\(model_home.shared.get_archievements_id.count)"
        } else if section == 1 {
            cell1.lbl_total_counts.text = "\(model_home.shared.get_goals_id.count)"
        } else {
            cell1.lbl_total_counts.text = "\(model_home.shared.get_tasks_id.count)"
        }
        
        if sectionIsExpanded[section] {
            cell1.setExpanded()
        } else {
            cell1.setCollapsed()
        }
        
        return cell1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionIsExpanded[section] == true {
            if section == 0 {
                return model_home.shared.get_archievements_id.count
            } else if section == 1 {
                return model_home.shared.get_goals_id.count
            } else {
                return model_home.shared.get_tasks_id.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CEll2 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTableViewCell
        
        
        CEll2.Targetbtn.tag = indexPath.row
        CEll2.Targetbtn.addTarget(self, action: #selector(tblbtn(_:)), for: .touchUpInside)
        
        CEll2.cellCalenderBtn.addTarget(self, action: #selector(cellCalenderBtn(_:)), for: .touchUpInside)
        
        if indexPath.section == 0 {
            if model_home.shared.get_archievements_title.count > 0{
                CEll2.TodaymeetingLbl.text = model_home.shared.get_archievements_title[indexPath.row]
                CEll2.MeetingwithJerryLbl.text = ""
                CEll2.Date.text = model_home.shared.get_archievements_date[indexPath.row]
                
                if model_home.shared.get_archievements_status[indexPath.row] == "" || model_home.shared.get_archievements_status[indexPath.row] == "not_started" {
                    CEll2.cellCalenderBtn.isSelected = true
                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
                } else {
                    CEll2.cellCalenderBtn.isSelected = false
                    if model_home.shared.get_archievements_status[indexPath.row] == "in_progress" {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
                    } else {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
                    }
                }
            }
        } else if indexPath.section == 1 {
            if model_home.shared.get_goals_title.count > 0{
                CEll2.TodaymeetingLbl.text = model_home.shared.get_goals_title[indexPath.row]
                CEll2.MeetingwithJerryLbl.text = ""
                CEll2.Date.text = model_home.shared.get_goals_date[indexPath.row]
                
                if model_home.shared.get_goals_status[indexPath.row] == "" || model_home.shared.get_goals_status[indexPath.row] == "Not Started" {
                    CEll2.cellCalenderBtn.isSelected = true
                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
                } else {
                    CEll2.cellCalenderBtn.isSelected = false
                    if model_home.shared.get_goals_status[indexPath.row] == "In Progress" {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
                    } else if model_home.shared.get_goals_status[indexPath.row] == "Past Due" {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
                    } else {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
                    }
                }
            }
        } else {
            if model_home.shared.get_tasks_title.count>0{
                CEll2.TodaymeetingLbl.text = model_home.shared.get_tasks_title[indexPath.row]
                CEll2.MeetingwithJerryLbl.text = ""
                CEll2.Date.text = model_home.shared.get_tasks_date[indexPath.row]
                
                if model_home.shared.get_tasks_status[indexPath.row] == "" || model_home.shared.get_tasks_status[indexPath.row] == "not_started" {
                    CEll2.cellCalenderBtn.isSelected = true
                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
                } else {
                    CEll2.cellCalenderBtn.isSelected = false
                    if model_home.shared.get_tasks_status[indexPath.row] == "in_progress" {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
                    } else {
                        CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
                    }
                }
            }
        }
        return CEll2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    Marrks: IBAction
    @objc func normalTap(sender : UIGestureRecognizer) {
        type_add = sender.view!.tag
        let new_achiv_popUp = storyboard?.instantiateViewController(withIdentifier: "New_Achiv_PopUp_ViewController") as! New_Achiv_PopUp_ViewController
        self.view.addSubview(new_achiv_popUp.view)
        self.addChild(new_achiv_popUp)
    }
    
    @objc func longTap(sender : UIGestureRecognizer) {
        is_from_long_gesture = true
        
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
        } else if sender.state == .began {
            if sender.view?.tag == 0 {
                push_VC("NewAchivementsViewController", storyboard: "Main")
            } else if sender.view?.tag == 1 {
                push_VC("CreateGoal_ViewController", storyboard: "Main")
            } else {
                push_VC("ListViewController", storyboard: "Main")
            }
        }
    }
    
    @IBAction func cellCalenderBtn(_ sender: UIButton) {
      

    }
    
    
    
    @IBAction func SettingBtn(_ sender: Any) {
        push_VC("SettingViewController", storyboard: "Main")
    }
    
    @IBAction func btn_show_all_list(_ sender:UIButton) {
        if sender.tag == 0 {
//
            let vcToPresent = self.storyboard?.instantiateViewController(withIdentifier:"AchivementViewController") as! AchivementViewController
            vcToPresent.datef = self.date
            self.navigationController?.pushViewController(vcToPresent, animated: true)
        } else if sender.tag == 1 {
            push_VC("GoalViewController", storyboard: "Main")
        } else if sender.tag == 2 {
            push_VC("ListViewController", storyboard: "Main")
        }
       
    }
    
    @IBAction func Calendarbtn(_ sender: Any) {
        view_calendar_popup.fadeIn()
    }
    
    @IBAction func btn_hide_popup_calendar(_ sender: UIButton) {
        view_calendar_popup.fadeOut()
    }
    @IBAction func Searchbtn(_ sender: Any) {
       
    }
    
    @IBAction func cellcalendarBTN(_ sender: Any) {
        calendarView.isHidden = false
        calendarView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8)
    }
    
    @IBAction func calendarhideBTn(_ sender: Any) {
        calendarView.isHidden = true
    }
    
    @IBAction func pickerBTN(_ sender: Any) {
        picker.isHidden = false
        pickerView.isHidden = false
    }
    
    @IBAction func doneBTn(_ sender: Any) {
        picker.isHidden = true
        pickerView.isHidden = true
    }
    
    @objc func tblbtn(_ sender: UIButton){
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.Tblview)
        let indexPath = self.Tblview.indexPathForRow(at: buttonPosition)
        
        is_from_long_gesture = false
        
        if indexPath?.section == 0 {
            push_VC("NewAchivementsViewController", storyboard: "Main")
        } else if indexPath?.section == 1 {
            push_VC("CreateGoal_ViewController", storyboard: "Main")
        } else  if indexPath?.section == 2 {
            push_VC("ListViewController", storyboard: "Main")
        }
   }
    
    @objc func tblbtn2(_ sender: UIButton) {
        sectionIsExpanded[sender.tag] = !sectionIsExpanded[sender.tag]
        self.Tblview.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return months[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return months.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLbl.text = months[row]
    }
}

extension CalendarViewController : FSCalendarDataSource , FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {

        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = date_format_WoLeap
        let dateString : String = dateFormatter1.string(from:date)
        if model_home.shared.dates.contains(dateString){
            return UIColor.white
        }else{
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = date_format_WoLeap
        let dateString : String = dateFormatter1.string(from:date)
        
        if model_home.shared.dates.contains(dateString){
            return hexStringToUIColor(hex: "2E7798")
        }else{
            return nil
        }
    }
    
}


extension CalendarViewController{
//    API HOME
    @objc func refresh_get_home(){
        get_data_home(user_id: model_login.shared.id, search: "", date: datef.string(from: self.date), is_personal: "\(is_work_or_personal)", is_next: "0", is_due: "0")
    }
    
    func get_data_home(user_id:String,search:String,date:String,is_personal:String,is_next:String,is_due:String) {
        func_ShowHud()
        let param = [
            "user_id":model_login.shared.id,
            "search":search,
            "date":date,
            "is_personal":is_personal,
            "is_next":is_next,
            "is_due":is_due
            ] as [String:Any]

        APIFunc.postAPI(url: k_base_url+"get_home_data", parameters: param) { (resp) in
            let status = return_status(resp)
            switch status{
            case .success:
                let result = resp as NSDictionary
                let dict_arr_get_goals = result["get_goals"] as! NSArray
                let dict_arr_get_tasks = result["get_tasks"] as! NSArray
                let dict_arr_get_archievements = result["get_archievements"] as! NSArray
                let datse = result["dates"] as! NSArray
                
                let arr = [array_to_string(object: dict_arr_get_goals),
                           array_to_string(object: dict_arr_get_tasks),
                           array_to_string(object: dict_arr_get_archievements),
                           array_to_string(object: datse)]
                
                CD_Manger.shared.add_data_to_database(arr, .Get_home_data, completion: { (_) in
                    CD_Manger.shared.fetch_result(.Get_home_data)
                    self.func_HideHud()
                    self.Tblview.reloadData()
                    self.calendar.reloadData()
                    print("Get home Successfully.")
                })
            case .fail:
                self.func_HideHud()
                self.func_ShowHud_Error(with: "\(resp["message"]!)")
            case .error_from_api:
                self.func_HideHud()
                self.func_ShowHud_Error(with: resp["error_message"] as! String)
            }
        }
    }
}
