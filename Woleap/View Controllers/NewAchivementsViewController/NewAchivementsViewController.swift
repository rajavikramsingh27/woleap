//  NewAchivementsViewController.swift
//  Woleap

//  Created by ayush pathak on 24/06/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit


class NewAchivementsViewController: UIViewController, UITextFieldDelegate {
//    Marks: IBOutlets
    @IBOutlet weak var TitleTxtFld: UITextField!
    @IBOutlet weak var setDateLbl: UILabel!
    
    @IBOutlet weak var txt_coment: UITextView!
    @IBOutlet weak var NotstrtdLbl: UILabel!
    @IBOutlet weak var InProgressLbl: UILabel!
    @IBOutlet weak var CompleteLbl: UILabel!
    
    @IBOutlet weak var CurrentLBl: UILabel!
    @IBOutlet weak var NextLbl: UILabel!
    @IBOutlet weak var SetDateView: UIView!
    
    @IBOutlet weak var CurrentView: UIView!
    @IBOutlet weak var NextView: UIView!
    
    @IBOutlet weak var UploadView: UIView!
    
    @IBOutlet weak var NotStrtdBTn: UIButton!
    @IBOutlet weak var InprogressBtn: UIButton!
    @IBOutlet weak var CompleteBtn: UIButton!
    
    @IBOutlet weak var CurrentlvlBtn: UIButton!
    @IBOutlet weak var NextLvlBtn: UIButton!
    
    @IBOutlet weak var btn_margin: UIButton!
    @IBOutlet weak var btn_important: UIButton!
    @IBOutlet weak var btn_significant: UIButton!
    @IBOutlet weak var btn_transform:UIButton!
    
    @IBOutlet weak var btn_easy:UIButton!
    @IBOutlet weak var btn_normal:UIButton!
    @IBOutlet weak var btn_hard:UIButton!
    @IBOutlet weak var btn_challenging:UIButton!
    
    @IBOutlet weak var datepickerView: UIView!
    
    @IBOutlet weak var techpopView: UIView!
    
    @IBOutlet weak var progress_status: UIProgressView!
    
    var emptylbl = UILabel()
    var emptybtn = UIButton()
    
    var arr_select_goals = [Bool]()
    var arr_select_category = [Bool]()
    var arr_select_tech = [Bool]()
    var arr_select_business = [Bool]()
    
    @IBOutlet weak var coll_goals: UICollectionView!
    @IBOutlet weak var coll_category: UICollectionView!
    
    @IBOutlet weak var tbl_tech: UITableView!
    @IBOutlet weak var tbl_business: UITableView!
    
    @IBOutlet weak var tbl_add_to_tech: UITableView!
    
    var arr_tech = [String]()
    var arr_business = [String]()
    
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var height_tech: NSLayoutConstraint!
    @IBOutlet weak var height_business: NSLayoutConstraint!
    @IBOutlet weak var height_container_view: NSLayoutConstraint!
    
    @IBOutlet weak var top_goals: NSLayoutConstraint!
    @IBOutlet weak var height_goals: NSLayoutConstraint!
    @IBOutlet weak var view_goals: UIView!
    
    @IBOutlet weak var lbl_attached_file_name: UILabel!
    
    @IBOutlet weak var switch_work_personal: UISwitch!
    
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var lbl_TechPopUp_Header: UILabel!
    
    @IBOutlet weak var btn_cancel_optional:UIButton!
    
    var is_technology = false
    
    var str_status = ""
    var str_category = ""
    var str_operating_level = ""
    var str_impact_rating = ""
    var str_dificuilt_rating = ""
    
    var arr_tech_skils = [Model_New_Achievement]()
    var arr_business_skills = [Model_New_Achievement]()
    
    var arr_category = ["Job Related","Personal Ambition/Growth"]
    
    var once = true
    
    @IBOutlet weak var img_select_custom_skills:UIImageView!
    @IBOutlet weak var txt_custom_skills:UITextField!
    @IBOutlet weak var btn_add_custom_skills:UIButton!
    
    var is_tech_skills = false
    var arr_custom_tech_skills = [Model_New_Achievement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switch_work_personal.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        for _ in 0..<5 {
            arr_select_goals.append(false)
        }
        if is_work_or_personal == 1{
            self.switch_work_personal.isOn = true
        }else{
            self.switch_work_personal.isOn = false
        }

        img_select_custom_skills.layer.cornerRadius = img_select_custom_skills.bounds.height/2
        img_select_custom_skills.clipsToBounds = true
        
        img_select_custom_skills.image = UIImage (named: "")
        img_select_custom_skills.backgroundColor = UIColor (red: 232.0/255.0, green: 236.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        
        btn_cancel_optional.isHidden = true
        
//      func_ShowHud()
        let datee = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        setDateLbl.text = dateFormatter.string(from: datee)
        
        func_un_selected(NotStrtdBTn, NotstrtdLbl)
        func_selected(InprogressBtn, InProgressLbl)
        func_un_selected(CompleteBtn, CompleteLbl)
        
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        let full_width = self.view.bounds.width-32
        let one_width = full_width/3*2
        progress_status.progress = Float(one_width/full_width)

        str_status = "in_progress"
        
        btn(button: CurrentlvlBtn,button2: NextLvlBtn , label: CurrentLBl, label2: NextLbl)
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        str_operating_level = "current level"
        
        techpopView.isHidden = true
        
        func_set_UI()
        
//        Model_New_Achievement.shared.arr_skills.removeAll()
//        Model_New_Achievement.shared.arr_business_benefits.removeAll()
//
        for _ in 0..<5 {
            arr_select_category.append(false)
        }
        
        func_get_archievement_data()
        
        if !is_from_long_gesture {
            func_get_archievement_by_id()
        }
        
         self.scroll_view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 730.0)
    }
    
    
    
//    func func_set_UI_ForUpdate() {
//        TitleTxtFld.text = Model_New_Achievement.shared.title
//        setDateLbl.text = Model_New_Achievement.shared.date
//
//        let btn = UIButton()
//
//        switch_work_personal.isUserInteractionEnabled = false
//
//        if Model_New_Achievement.shared.is_personal == "0" {
//            switch_work_personal.isOn = false
//        } else {
//            switch_work_personal.isOn = true
//        }
//
//        if Model_New_Achievement.shared.status == "not_started" {
//            CompleteBtn("")
//        } else if Model_New_Achievement.shared.status == "in_progress" {
//            InprogBTn(btn)
//        } else if Model_New_Achievement.shared.status == "complete" {
//            NotStrtBtn("")
//        }
//
//        if Model_New_Achievement.shared.category == "Job Related" {
//            arr_select_category[0] = true
//        } else if Model_New_Achievement.shared.category == "Personal Ambition/Growth" {
//            arr_select_category[1] = true
//        }
//
//        coll_category.reloadData()
//
//        if Model_New_Achievement.shared.operating_level == "current level" {
//            CurrentlvlBtn("")
//        } else if Model_New_Achievement.shared.operating_level == "next level" {
//             NxtlvlBtn("")
//        }
//
//        if Model_New_Achievement.shared.impact_rating == "marginal" {
//            btn_margin(btn)
//        } else if Model_New_Achievement.shared.impact_rating == "important" {
//            btn_important(btn)
//        } else if Model_New_Achievement.shared.impact_rating == "significant" {
//            btn_significant(btn)
//        } else if Model_New_Achievement.shared.impact_rating == "transformtional" {
//            btn_transform(btn)
//        }
//
//        if Model_New_Achievement.shared.difficulty_level == "easy" {
//            btn_easy(btn)
//        } else if Model_New_Achievement.shared.difficulty_level == "normal" {
//            btn_normal(btn)
//        } else if Model_New_Achievement.shared.difficulty_level == "hard" {
//            btn_hard(btn)
//        } else if Model_New_Achievement.shared.difficulty_level == "challenging" {
//            btn_challenging(btn)
//        }
//
//        if Model_New_Achievement.shared.comment == "" {
//            txt_coment.text = "Add additional details..."
//            txt_coment.textColor = UIColor .lightGray
//        } else {
//            txt_coment.text = Model_New_Achievement.shared.comment
//            txt_coment.textColor = UIColor .black
//        }
//
//        self.height_tech.constant = CGFloat(60*(Model_New_Achievement.shared.arr_achiev_skills.count+1))
//        self.height_business.constant = CGFloat(60*(Model_New_Achievement.shared.arr_achiev_business_benefits.count+1))
//
//        var height_FOR_container_view = CGFloat(855)
//        if Model_New_Achievement.shared.arr_get_goals.count == 0 {
//            height_FOR_container_view = CGFloat(855-80)
//        }
//
//        self.height_container_view.constant = height_FOR_container_view//+self.height_tech.constant+self.height_business.constant+400
//
//        arr_tech_skils = Model_New_Achievement.shared.arr_achiev_skills
//        arr_business_skills = Model_New_Achievement.shared.arr_achiev_business_benefits
//
//        self.tbl_tech.reloadData()
//        self.tbl_business.reloadData()
//    }
    
    func func_set_UI() {
//        Switchbtn.set( width: 47, height: 27)
        
        func_txtfield(txt: TitleTxtFld, color: UIColor.lightGray, brwidth: 0)
        func_txtfield(txt: txt_coment, color: UIColor.lightGray, brwidth: 0)
        
        CurrentView.curvecorner()
        NextView.curvecorner()
        
        UploadView.curvecorner()
        SetDateView.curvecorner()
                
        TitleTxtFld.padding()
        
        txt_coment.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        
        func_shadow_1(view: datepickerView)
        
//        height_container_view.constant = 2222
//         self.scroll_view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 730.0)
    }
    
    //   Marks: IBAction
    @IBAction func HomeBtn(_ sender: Any) {
        pop_single()
    }
    
    @IBAction func back(_ sender: UIButton) {
        pop_single()
    }
    
    
    @IBAction func AddAchiveBtn(_ sender: Any) {
        
    }
    
    @IBAction func CancelAchiveBtn(_ sender: Any) {
        
    }
    
    @IBAction func CalenderBtn(_ sender: Any) {
        datepicker.setDate(Date(), animated: true)
        datepickerView.isHidden = false
        self.view.endEditing(true)
    }
    
    @IBAction func switch_action(_ sender: UISwitch) {
        if sender.isOn{
            set_status_work_personal(type: .personal)
        }else{
            set_status_work_personal(type: .work)
        }
    }
    
    
    @IBAction func AddMoreDetlBtn(_ sender: Any) {
        
    }
    
    @IBAction func CancelMoreDetlBtn(_ sender: Any) {
        btn_cancel_optional.isHidden = true
        
        var height_FOR_container_view = CGFloat(855)
//        if Model_New_Achievement.shared.arr_get_goals.count == 0 {
//            self.height_goals.constant = 0
//            self.top_goals.constant = 0
//            height_FOR_container_view = CGFloat(855-80)
//            self.view_goals.isHidden = true
//        } else {
//            self.view_goals.isHidden = false
//        }
        self.height_container_view.constant = height_FOR_container_view
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    @IBAction func UploadBtn(_ sender: Any) {
        
    }
    
    @IBAction func Goal1Btn(_ sender: Any) {
//        btn(button: GOal1Btn, button2: Goal2BTn, label: emptylbl, label2: emptylbl)
        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func Goal2Btn(_ sender: Any) {

        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func NotStrtBtn(_ sender: Any) {
        func_selected(NotStrtdBTn, NotstrtdLbl)
        func_un_selected(InprogressBtn, InProgressLbl)
        func_un_selected(CompleteBtn, CompleteLbl)
        
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        let full_width = self.view.bounds.width-32
        let one_width = full_width/3
        progress_status.progress = Float(one_width/full_width)
        
        str_status = "not_started"
    }
    
    @IBAction func InprogBTn(_ sender: UIButton) {
        func_un_selected(NotStrtdBTn, NotstrtdLbl)
        func_selected(InprogressBtn, InProgressLbl)
        func_un_selected(CompleteBtn, CompleteLbl)
        
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        let full_width = self.view.bounds.width-32
        let one_width = full_width/3*2
        progress_status.progress = Float(one_width/full_width)
        
        str_status = "in_progress"
     }
    
    @IBAction func CompleteBtn(_ sender: Any) {
        func_un_selected(NotStrtdBTn, NotstrtdLbl)
        func_un_selected(InprogressBtn, InProgressLbl)
        func_selected(CompleteBtn, CompleteLbl)
        
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        let full_width = self.view.bounds.width-32
        let one_width = full_width/3*3
        progress_status.progress = Float(one_width/full_width)
        
        str_status = "complete"
    }
    
    @IBAction func CurrentlvlBtn(_ sender: Any) {
        btn(button: CurrentlvlBtn,button2: NextLvlBtn , label: CurrentLBl, label2: NextLbl)
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        str_operating_level = "current level"
    }
    
    @IBAction func NxtlvlBtn(_ sender: Any) {
        btn(button: NextLvlBtn,button2: CurrentlvlBtn, label: NextLbl, label2: CurrentLBl)
        self.view.endEditing(true)
        datepickerView.isHidden = true
        
        str_operating_level = "next level"
    }
    
    @IBAction func SapBtn(_ sender: Any) {
        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func AddMoreBtn(_ sender: Any) {
        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func CustomerstfnBTn(_ sender: Any) {
        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func Addbtn2(_ sender: Any) {
        techpopView.isHidden = false
        
        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func datepicker(_ sender: UIDatePicker) {
        setDateLbl.text = func_DatePickerDate(sender.date)
    }
    
    @IBAction func pickerhidebtn(_ sender: Any) {
        datepickerView.isHidden = true
        self.view.endEditing(true)
        datepickerView.isHidden = true
    }
    
    @IBAction func techpopAddBtn(_ sender: Any) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        Model_New_Achievement.shared.arr_business_benefits.removeAll()
//        Model_New_Achievement.shared.arr_skills.removeAll()
    }
    
}



extension NewAchivementsViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datepickerView.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
}



extension NewAchivementsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbl_tech {
            return arr_tech_skils.count+1
        } else if tableView == tbl_business {
            return arr_business_skills.count+1
        } else {
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbl_tech {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-tech", for: indexPath) as! Technology_TableViewCell
            
            cell.btn_select.tag = indexPath.row
            cell.btn_select.addTarget(self, action: #selector(btn_add_technology(_:)), for: .touchUpInside)
            
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(btn_delete_techs(_:)), for: .touchUpInside)
            
            if indexPath.row == arr_tech_skils.count {
                cell.lbl_title.text = "Select/Add technology"
                cell.btn_delete.isHidden = true
            } else {
//                cell.lbl_title.text = arr_tech_skils[indexPath.row].name
                cell.btn_delete.isHidden = false
            }
            
            return cell
        } else if tableView == tbl_business {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell-business", for: indexPath) as! Business_TableViewCell
            
            cell.btn_select.tag = indexPath.row
            cell.btn_select.addTarget(self, action: #selector(btn_add_business(_:)), for: .touchUpInside)
            
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(btn_delete_business(_:)), for: .touchUpInside)
            
            if indexPath.row == arr_business_skills.count {
                cell.lbl_title.text = "Select/Add Business"
                cell.btn_delete.isHidden = true
            } else {
//                cell.lbl_title.text = arr_business_skills[indexPath.row].name
                cell.btn_delete.isHidden = false
            }
            
            return cell
        } else {
//            var arr_business_benefits = [Model_New_Achievement]()
//            var arr_skills = [Model_New_Achievement]()
//            var arr_get_goals = [Model_New_Achievement]()
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TechPopupTableViewCell
            if is_technology {
//                cell.DemoLbl.text = Model_New_Achievement.shared.arr_skills[indexPath.row].name
                
                if arr_select_tech[indexPath.row] {
                    cell.ImgView.image = UIImage (named: "check-blue.png")
                    cell.ImgView.backgroundColor = UIColor .clear
                    cell.AddBtn.setTitle("ADDED", for: .normal)
                } else {
                    cell.ImgView.image = UIImage (named: "")
                    cell.ImgView.backgroundColor = UIColor (red: 232.0/255.0, green: 236.0/255.0, blue: 239.0/255.0, alpha: 1.0)
                    cell.AddBtn.setTitle("ADD", for: .normal)
                }
            } else {
//                cell.DemoLbl.text = Model_New_Achievement.shared.arr_business_benefits[indexPath.row].name
                
                if arr_select_business[indexPath.row] {
                    cell.ImgView.image = UIImage (named: "check-blue.png")
                    cell.ImgView.backgroundColor = UIColor .clear
                    cell.AddBtn.setTitle("ADDED", for: .normal)
                } else {
                    cell.ImgView.image = UIImage (named: "")
                    cell.ImgView.backgroundColor = UIColor (red: 232.0/255.0, green: 236.0/255.0, blue: 239.0/255.0, alpha: 1.0)
                    cell.AddBtn.setTitle("ADD", for: .normal)
                }
                
            }
            
            cell.AddBtn.tag = indexPath.row
            cell.AddBtn.addTarget(self, action: #selector(btn_add_to_technology(_:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func btn_add_technology(_ sender: UIButton) {
        is_tech_skills = true
        
        lbl_TechPopUp_Header.text = "Technology/Skills"
        if sender.tag == arr_tech_skils.count {
            if !is_from_long_gesture {
//                for i in 0..<Model_New_Achievement.shared.arr_skills.count {
//                    let model = Model_New_Achievement.shared.arr_skills[i]
//                    for model_1 in arr_tech_skils {
//                        if model_1.name == model.name {
//                            arr_select_tech[i] = true
//                        } else {
//                            if Model_New_Achievement.shared.arr_skills.contains(where: {$0.name == model_1.name}) {
//                                print("h")
//                            } else {
//                                print("nhi h")
//                                arr_select_tech.append(true)
//                                Model_New_Achievement.shared.arr_skills.append(model_1)
//                            }
//                        }
//                    }
//                }
            }
            
            techpopView.isHidden = false
            is_technology = true
            
            tbl_add_to_tech.reloadData()
        }
    }
    
    
    @IBAction func btn_add_business(_ sender: UIButton) {
        is_tech_skills = false
        
        lbl_TechPopUp_Header.text = "Business Benefits"
            
        if sender.tag == arr_business_skills.count {
            if !is_from_long_gesture {
//                for i in 0..<Model_New_Achievement.shared.arr_business_benefits.count {
//                    let model = Model_New_Achievement.shared.arr_business_benefits[i]
//                    for model_1 in arr_business_skills {
//                        if model_1.name == model.name {
//                            arr_select_business[i] = true
//                        } else {
//                            if Model_New_Achievement.shared.arr_business_benefits.contains(where: {$0.name == model_1.name}) {
//                                print("h")
//                            } else {
//                                print("nhi h")
//                                arr_select_business.append(true)
//                                Model_New_Achievement.shared.arr_business_benefits.append(model_1)
//                            }
//                        }
//                    }
//                }
                
            }
            
            techpopView.isHidden = false
            is_technology = false
            
            tbl_add_to_tech.reloadData()
        }
    }
    
    @IBAction func btn_delete_techs(_ sender: UIButton) {
//        Model_New_Achievement.shared.id = arr_tech_skils[sender.tag].id
//        func_ShowHud()
//        Model_New_Achievement.shared.func_remove_archievement_skill { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                if status == "success" {
//                    self.func_ShowHud_Success(with: Model_New_Achievement.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_New_Achievement.shared.message)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    self.func_get_archievement_by_id()
//                })
//            }
//        }
    }
    
    @IBAction func btn_delete_business(_ sender: UIButton) {
//        Model_New_Achievement.shared.id = arr_business_skills[sender.tag].id
//        func_ShowHud()
//        Model_New_Achievement.shared.func_remove_archievement_business_benefit { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                if status == "success" {
//                    self.func_ShowHud_Success(with: Model_New_Achievement.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_New_Achievement.shared.message)
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    self.func_get_archievement_by_id()
//                })
//            }
//        }
    }
    
    
    
    @IBAction func btn_hide_techPopUp(_ sender: UIButton) {
        techpopView.isHidden = true
    }
    
    @IBAction func btn_add_to_technology(_ sender: UIButton) {
        if is_technology {
            for i in 0..<arr_select_tech.count {
                if i == sender.tag {
                    if arr_select_tech[i] {
                        arr_select_tech[i] = false
                    } else {
                        arr_select_tech[i] = true
                    }
                }
            }
        } else {
            for i in 0..<arr_select_business.count {
                if i == sender.tag {
                    if arr_select_business[i] {
                        arr_select_business[i] = false
                    } else {
                        arr_select_business[i] = true
                    }
                }
            }
        }
        tbl_add_to_tech.reloadData()
    }
    
    
    
    @IBAction func btn_margin(_ sender: UIButton) {
//        btn_margin.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_important.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_significant.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_transform.frame.size = CGSize(width: 15.0, height: 15.0)
        
//        btn_margin.backgroundColor = UIColor.white
//        btn_important.backgroundColor = UIColor.lightGray
//        btn_significant.backgroundColor = UIColor.lightGray
//        btn_transform.backgroundColor = UIColor.lightGray
        
        btn_margin.isSelected = true
        btn_important.isSelected = false
        btn_significant.isSelected = false
        btn_transform.isSelected = false
        
        str_impact_rating = "marginal"
    }
    
    @IBAction func btn_important(_ sender: UIButton) {
//        btn_important.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_margin.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_significant.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_transform.frame.size = CGSize(width: 15.0, height: 15.0)
        
//        btn_margin.backgroundColor = UIColor.lightGray
//        btn_important.backgroundColor = UIColor.white
//        btn_significant.backgroundColor = UIColor.lightGray
//        btn_transform.backgroundColor = UIColor.lightGray
        
        btn_margin.isSelected = false
        btn_important.isSelected = true
        btn_significant.isSelected = false
        btn_transform.isSelected = false
        
        str_impact_rating = "important" 
    }
    
    @IBAction func btn_significant(_ sender: UIButton) {
//        btn_significant.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_margin.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_important.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_transform.frame.size = CGSize(width: 15.0, height: 15.0)
        
//        btn_margin.backgroundColor = UIColor.lightGray
//        btn_important.backgroundColor = UIColor.lightGray
//        btn_significant.backgroundColor = UIColor.white
//        btn_transform.backgroundColor = UIColor.lightGray
        
        btn_margin.isSelected = false
        btn_important.isSelected = false
        btn_significant.isSelected = true
        btn_transform.isSelected = false
        
        str_impact_rating = "significant" 
    }
    
    @IBAction func btn_transform(_ sender: UIButton) {
        
//        btn_transform.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_margin.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_significant.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_important.frame.size = CGSize(width: 15.0, height: 15.0)
        
//
//        btn_margin.backgroundColor = UIColor.lightGray
//        btn_important.backgroundColor = UIColor.lightGray
//        btn_significant.backgroundColor = UIColor.lightGray
//        btn_transform.backgroundColor = UIColor.white
        
        btn_margin.isSelected = false
        btn_important.isSelected = false
        btn_significant.isSelected = false
        btn_transform.isSelected = true
        
        str_impact_rating = "transformtional"
    }
    
    @IBAction func btn_easy(_ sender: UIButton) {
        btn_easy.isSelected = true
        btn_normal.isSelected = false
        btn_hard.isSelected = false
        btn_challenging.isSelected = false
        
//        btn_easy.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_normal.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_hard.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_challenging.frame.size = CGSize(width: 15.0, height: 15.0)
//
//
//        btn_normal.backgroundColor = UIColor.lightGray
//        btn_challenging.backgroundColor = UIColor.lightGray
//        btn_hard.backgroundColor = UIColor.lightGray
//        btn_easy.backgroundColor = UIColor.white
        
        str_dificuilt_rating = "easy"
    }
    
    @IBAction func btn_normal(_ sender: UIButton) {
        btn_easy.isSelected = false
        btn_normal.isSelected = true
        btn_hard.isSelected = false
        btn_challenging.isSelected = false
        
//        btn_normal.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_easy.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_hard.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_challenging.frame.size = CGSize(width: 15.0, height: 15.0)
//
//
//        btn_easy.backgroundColor = UIColor.lightGray
//        btn_challenging.backgroundColor = UIColor.lightGray
//        btn_hard.backgroundColor = UIColor.lightGray
//        btn_normal.backgroundColor = UIColor.white
        
        
        str_dificuilt_rating = "normal"
    }
    
    
    @IBAction func btn_hard(_ sender: UIButton) {
        btn_easy.isSelected = false
        btn_normal.isSelected = false
        btn_hard.isSelected = true
        btn_challenging.isSelected = false
        
//        btn_hard.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_easy.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_normal.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_challenging.frame.size = CGSize(width: 15.0, height: 15.0)
        
//        btn_easy.backgroundColor = UIColor.lightGray
//        btn_challenging.backgroundColor = UIColor.lightGray
//        btn_normal.backgroundColor = UIColor.lightGray
//        btn_hard.backgroundColor = UIColor.white
        
        str_dificuilt_rating = "hard" 
    }
    
    @IBAction func btn_challenging(_ sender: UIButton) {
        btn_easy.isSelected = false
        btn_normal.isSelected = false
        btn_hard.isSelected = false
        btn_challenging.isSelected = true
        
//        btn_challenging.frame.size = CGSize(width: 22.5, height: 22.5)
//        btn_easy.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_normal.frame.size = CGSize(width: 15.0, height: 15.0)
//        btn_hard.frame.size = CGSize(width: 15.0, height: 15.0)
//
//
//        btn_easy.backgroundColor = UIColor.lightGray
//        btn_hard.backgroundColor = UIColor.lightGray
//        btn_normal.backgroundColor = UIColor.lightGray
//        btn_challenging.backgroundColor = UIColor.white
        
        str_dificuilt_rating = "challenging"
    }
    
    @IBAction func addd_more(_ sender:UIButton) {
        btn_cancel_optional.isHidden = false
//        height_container_view.constant = 1120.0
        
        var height_FOR_container_view = CGFloat(855)
//        if Model_New_Achievement.shared.arr_get_goals.count == 0 {
//            self.height_goals.constant = 0
//            self.top_goals.constant = 0
//            height_FOR_container_view = CGFloat(855-80)
//            self.view_goals.isHidden = true
//        } else {
//            self.view_goals.isHidden = false
//        }
//
//        self.height_tech.constant = CGFloat(60*(Model_New_Achievement.shared.arr_achiev_skills.count+1))
//        self.height_business.constant = CGFloat(60*(Model_New_Achievement.shared.arr_achiev_business_benefits.count+1))
//
        self.height_container_view.constant = height_FOR_container_view+self.height_tech.constant+self.height_business.constant+444
        
        let bottomOffset = CGPoint(x: 0, y: scroll_view.contentSize.height - scroll_view.bounds.size.height)
        scroll_view.setContentOffset(bottomOffset, animated: true)
//         self.scroll_view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 730.0)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
}



extension NewAchivementsViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txt_coment.text == "Add additional details..." {
           txt_coment.text = ""
            txt_coment.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txt_coment.text == "" {
            txt_coment.text = "Add additional details..."
            txt_coment.textColor = UIColor.lightGray
        }

    }
}





//  MARK:- UICollectionView methods
extension NewAchivementsViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == coll_goals {
            return UIEdgeInsets (top: 0, left: 15, bottom: 0, right: 15)
        } else {
            return UIEdgeInsets (top: 0, left: 0, bottom: 0, right:0)
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == coll_goals {
            return CGSize (width: 185, height:collectionView.bounds.height)
        } else {
            let width = coll_category.bounds.width/2
            return CGSize (width: width, height:collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coll_goals {
            return 5//arr_select_goals.count
        } else {
            return arr_category.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == coll_goals {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Tag_Goal_CollectionViewCell
            
//            cell.lbl_goal_name.text = Model_New_Achievement.shared.arr_get_goals[indexPath.row].title
//
            if arr_select_goals[indexPath.row] {
                cell.btn_select.isSelected = true
                func_selected(cell.btn_select, cell.lbl_goal_name)
            } else {
                cell.btn_select.isSelected = false
                func_un_selected(cell.btn_select, cell.lbl_goal_name)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-category", for: indexPath) as! Tag_Goal_CollectionViewCell
            
            cell.lbl_goal_name.text = arr_category[indexPath.row]
          
            if arr_select_category[indexPath.row] {
                cell.btn_select.isSelected = true
                func_selected(cell.btn_select, cell.lbl_goal_name)
            } else {
                cell.btn_select.isSelected = false
                func_un_selected(cell.btn_select, cell.lbl_goal_name)
            }
            
//            if once{
//                if indexPath.row == 0{
//                    once = false
//                    cell.btn_select.isSelected = true
//                    func_selected(cell.btn_select, cell.lbl_goal_name)
//                }
//            }
            
            
            
            return cell
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == coll_goals {
            for i in 0..<arr_select_goals.count {
                if i == indexPath.row {
                    arr_select_goals[i] = true
                } else {
                    arr_select_goals[i] = false
                }
            }
            coll_goals.reloadData()
        } else {
            for i in 0..<arr_select_category.count {
                if i == indexPath.row {
                    arr_select_category[i] = true
                    str_category = arr_category[i]
                } else {
                    arr_select_category[i] = false
                }
            }
            coll_category.reloadData()
        }
        
    }
    
    func func_selected(_ button: UIButton,_ label: UILabel) {
        button.setImage(UIImage(named: "tick-2"), for: .normal)
        button.backgroundColor = UIColor (red: 74.0/255.0, green: 119.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        label.textColor = UIColor.black
    }
    
    func func_un_selected(_ button: UIButton,_ label: UILabel) {
        button.setImage(UIImage(named: ""), for: .normal)
        button.backgroundColor = UIColor.lightGray
        label.textColor = UIColor.lightGray
    }
    
    @IBAction func btn_add_custom_skills(_ sender:UIButton) {
        if txt_custom_skills.text!.isEmpty {
            if is_tech_skills {
                func_ShowHud_Error(with:"Enter Technology/Skills")
            } else {
                func_ShowHud_Error(with:"Enter Business Benifits")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1.3) {
                self.func_HideHud()
            }
            
            return
        }
        
        let dict_custom_tech_skills = ["name":txt_custom_skills.text!]
        
        if is_tech_skills {
            //Model_New_Achievement.shared.arr_skills.append(func_set_data(dict: dict_custom_tech_skills))
            arr_select_tech.append(true)
        } else {
           // Model_New_Achievement.shared.arr_business_benefits.append(func_set_data(dict: dict_custom_tech_skills))
            arr_select_business.append(true)
        }
            
        tbl_add_to_tech.reloadData()
        txt_custom_skills.text = ""
    }
}



extension NewAchivementsViewController {
    private func func_set_data(dict:[String:Any]) -> Model_New_Achievement {
        print(dict)
        let model = Model_New_Achievement()
        
//        model.id = "\(dict["id"] ?? "")"
//        model.name = "\(dict["name"] ?? "")"
//        model.user_id = "\(dict["user_id"] ?? "")"
//        model.created = "\(dict["created"] ?? "")"
//
        return model
    }
    
    func get_achivement_form_data() {
        func_ShowHud()
        let param = ["user_id":model_login.shared.id]

        APIFunc.postAPI(url: "get_archievement_data", parameters: <#T##[String : Any]#>, completion: <#T##([String : Any]) -> ()#>)

    }

    
//    func get_data_home(user_id:String,search:String,date:String,is_personal:String,is_next:String,is_due:String) {
//        func_ShowHud()
//        let param = [
//            "user_id":model_login.shared.id,
//            "search":search,
//            "date":date,
//            "is_personal":is_personal,
//            "is_next":is_next,
//            "is_due":is_due
//            ] as [String:Any]
//
//        APIFunc.postAPI(url: k_base_url+"get_home_data", parameters: param) { (resp) in
//            let status = return_status(resp)
//            switch status{
//            case .success:
//                let result = resp as NSDictionary
//                let dict_arr_get_goals = result["get_goals"] as! NSArray
//                let dict_arr_get_tasks = result["get_tasks"] as! NSArray
//                let dict_arr_get_archievements = result["get_archievements"] as! NSArray
//                let datse = result["dates"] as! NSArray
//
//                let arr = [array_to_string(object: dict_arr_get_goals),
//                           array_to_string(object: dict_arr_get_tasks),
//                           array_to_string(object: dict_arr_get_archievements),
//                           array_to_string(object: datse)]
//
//                CD_Manger.shared.add_data_to_database(arr, .Get_home_data, completion: { (_) in
//                    CD_Manger.shared.fetch_result(.Get_home_data)
//                    self.func_HideHud()
//                    self.Tblview.reloadData()
//                    self.calendar.reloadData()
//                    print("Get home Successfully.")
//                })
//            case .fail:
//                self.func_HideHud()
//                self.func_ShowHud_Error(with: "\(resp["message"]!)")
//            case .error_from_api:
//                self.func_HideHud()
//                self.func_ShowHud_Error(with: resp["error_message"] as! String)
//            }
//        }
//    }
}


