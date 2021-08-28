//  achievmentsViewController.swift
//  Woleap

//  Created by Devender Singh Shekhawat on 24/06/19.
//  Copyright © 2019 appentus. All rights reserved.

var is_from_long_gesture = false

import UIKit

class AchivementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var achiev = AchivementTableViewCell()
    var array = [false,false,false]
    
//    Marks IBOutlets
    @IBOutlet weak var tlbView: UITableView!
    @IBOutlet weak var RoundBtn: UIView!
    @IBOutlet weak var SwitchBTN: UISwitch!
    
    @IBOutlet weak var txt_search:UITextField!
    
    var arr_searched_ach = [Model_Achievement]()
    var arr_for_search_ach = [Model_Achievement]()
    var datef = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if is_work_or_personal == 1{
            SwitchBTN.isOn = true
        }else{
            SwitchBTN.isOn = false
        }
        RoundBtn.layer.cornerRadius = RoundBtn.frame.width/2
        func_shadow(view: RoundBtn, color: UIColor.lightGray,CorRad: 0)
        SwitchBTN.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
//        if Model_New_Achievement.shared.is_personal == "0" {
//            SwitchBTN.isOn = false
//        } else {
//            SwitchBTN.isOn = true
//        }
//        SwitchBTN.isUserInteractionEnabled = false
//
//        Model_Achievement.shared.is_personal = Model_New_Achievement.shared.is_personal
//        Model_Achievement.shared.arr_get_archievements.removeAll()
//        func_get_home_data()
    }
    

    @objc func func_remove_archievement() {
//        func_ShowHud()
//        Model_Achievement.shared.func_remove_archievement { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//                if status == "1" {
//                    self.func_ShowHud_Success(with: Model_Achievement.shared.message)
//                } else {
//                    self.func_ShowHud_Error(with: Model_Achievement.shared.message)
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: {
//                    self.func_HideHud()
//                    if status == "1" {
//                        self.func_get_home_data()
//                    }
//
//                })
//
//                self.tlbView.reloadData()
//            }
//        }
//
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return Model_Achievement.shared.arr_get_archievements.count
        return model_home.shared.get_archievements_id.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AchivementTableViewCell
       
        if model_home.shared.get_archievements_title.count > 0{
            cell.DEsignlbl.text = model_home.shared.get_archievements_title[indexPath.row]
            
            let initial_date_formater = DateFormatter()
            initial_date_formater.dateFormat = "yyyy-MM-dd"
            
            let datee = DateFormatter()
            datee.dateFormat = "dd' 'MMM' 'yyyy"
            
            cell.DateLbl.text = datee.string(from: initial_date_formater.date(from: model_home.shared.get_archievements_date[indexPath.row])!)
            cell.NotStrtLbl.text = model_home.shared.get_archievements_status[indexPath.row]
            
        }

        if model_home.shared.get_archievements_status[indexPath.row] == "" || model_home.shared.get_archievements_status[indexPath.row] == "not_started" || model_home.shared.get_archievements_status[indexPath.row] == "<null>" {
            cell.NotStrtLbl.text = "Not started"
            cell.cellCalenderBtn.isSelected = true
            cell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
        } else {
            cell.cellCalenderBtn.isSelected = false
            cell.NotStrtLbl.text = model_home.shared.get_archievements_status[indexPath.row]
            if model_home.shared.get_archievements_status[indexPath.row] == "in_progress" {
                cell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
            } else {
                cell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
            }
        }
        
        func_btn(btn: cell.AchvView2,CR: 5,color: UIColor.lightGray, brwidth: 0, Shadow: 1, ShadowRadius: 1.0)
        cell.AchvView.curvecorner()
        cell.Targetbtn.tag = indexPath.row
        cell.Targetbtn.addTarget(self, action: #selector(trgbtn(_:)), for: .touchUpInside)
        
        cell.Targetbtn.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tlbView.deselectRow(at: indexPath, animated: true)
        is_from_long_gesture = false
        push_VC("NewAchivementsViewController", storyboard: "Main")
    }
    
    //   Marks: IBACtion
    @IBAction func HomeBtn(_ sender: Any) {
        pop_single()
    }
    
    
    @IBAction func trgbtn(_ sender: UIButton) {
        push_VC("NewAchivementsViewController", storyboard: "Main")

    }
    
    @IBAction func switch_work_personal(_ sender:UISwitch) {

        if sender.isOn{
            set_status_work_personal(type: .personal)
        }else{
            set_status_work_personal(type: .work)
        }
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        get_data_home(user_id: model_login.shared.id, search: "", date: dateformat.string(from: self.datef), is_personal: "\(is_work_or_personal)", is_next: "0", is_due: "0")
        
    }
    
    
    
    @IBAction func txt_search(_ texfield:UITextField) {
//        for _ in Model_Achievement.shared.arr_get_archievements {
//            self.array.append(false)
//        }
//
//        arr_searched_ach = [Model_Achievement]()
//
//        for i in 0..<arr_for_search_ach.count {
//            let model = arr_for_search_ach[i]
//            let target = model.title
//            if ((target as NSString?)?.range(of:texfield.text!, options: .caseInsensitive))?.location == NSNotFound
//            {
//                print(model.title)
//            } else {
//                arr_searched_ach.append(model)
//            }
//        }
//
//        if (texfield.text! == "") {
//            arr_searched_ach = arr_for_search_ach
//        }
//
//        Model_Achievement.shared.arr_get_archievements = arr_searched_ach
//        tlbView.reloadData()
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
                    self.tlbView.reloadData()
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



//@available(iOS 11.0, *)
extension AchivementViewController {
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction.init(style: .destructive, title: "Delete") { (action, view, nil) in
            print("delete")
        }
        
        delete.image = UIImage(named: "delete")
        delete.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.2196078431, blue: 0.2, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}


