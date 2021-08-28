//  Due_Next_ViewController.swift
//  Woleap

//  Created by ayush pathak on 19/07/19.
//  Copyright © 2019 appentus. All rights reserved.

import UIKit

var title_due_next = ""

class Due_Next_ViewController: UIViewController {
    @IBOutlet weak var Tblview: UITableView!
    @IBOutlet weak var nav_bar: UINavigationBar!
    
    private let sectionTitles = ["Achievements", "Goals", "List"]
    var imageArray: [UIImage] = [ UIImage(named: "medal.png")!, UIImage(named: "goal.png")!, UIImage(named: "tasks.png")!]
    var imageArray2: [UIImage] = [ UIImage(named: "exclamation-mark")!, UIImage(named: "exclamation-mark")!,UIImage(named: "exclamation-mark")!,UIImage(named: "calendar-2")!,UIImage(named: "calendar-2")!]
    
    private var sectionIsExpanded = [false, false, false]
    private let numberOfActualRowsForSection = 4
    
    let months = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var arr_searched_ach = [Model_Due_Next]()
    var arr_for_search_ach = [Model_Due_Next]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nav_bar.topItem?.title = title_due_next
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  func_get_home_data()
    }
    
    @objc func func_get_home_data() {
        func_ShowHud()
//        Model_Due_Next.shared.func_get_home_data { (status) in
//            DispatchQueue.main.async {
//                self.func_HideHud()
//
//                self.arr_for_search_ach = Model_Due_Next.shared.arr_get_archievements
//
//                self.Tblview.reloadData()
//            }
//        }
    }
    
    @IBAction func btn_back(_ sender:Any) {
        pop_single()
    }
    
}

extension Due_Next_ViewController:UITableViewDelegate,UITableViewDataSource{
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
//        cell1.View.isHidden = false
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
        
//        cell1.View.layer.cornerRadius = cell1.View.frame.width/2
//        func_shadow(view: cell1.View, color: UIColor.lightGray,CorRad: 0)
        
        cell1.tapGesture.view?.tag = section
        cell1.longGesture.view?.tag = section
        
//        if section == 0 {
//            cell1.lbl_total_counts.text = "\(Model_Due_Next.shared.arr_get_archievements.count)"
//        } else if section == 1 {
//            cell1.lbl_total_counts.text = "\(Model_Due_Next.shared.arr_get_goals.count)"
//        } else {
//            cell1.lbl_total_counts.text = "\(Model_Due_Next.shared.arr_get_list.count)"
//        }
        
        if sectionIsExpanded[section] {
            cell1.setExpanded()
        } else {
            cell1.setCollapsed()
        }
        
        return cell1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionIsExpanded[section] == true {
               return 4
//            if section == 0 {
//                return Model_Due_Next.shared.arr_get_archievements.count
//            } else if section == 1 {
//                return Model_Due_Next.shared.arr_get_goals.count
//            } else {
//                return Model_Due_Next.shared.arr_get_list.count
//            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CEll2 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalendarTableViewCell
        
        CEll2.Targetbtn.tag = indexPath.row
        CEll2.Targetbtn.addTarget(self, action: #selector(tblbtn(_:)), for: .touchUpInside)
        
        CEll2.cellCalenderBtn.addTarget(self, action: #selector(cellCalenderBtn(_:)), for: .touchUpInside)
                
//        if indexPath.section == 0 {
//            let model = Model_Due_Next.shared.arr_get_archievements[indexPath.row]
//            CEll2.TodaymeetingLbl.text = model.title
//            CEll2.MeetingwithJerryLbl.text = ""
//            CEll2.Date.text = model.date
//
//            if model.status == "" || model.status == "not_started" {
//                CEll2.cellCalenderBtn.isSelected = true
//                CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
//            } else {
//                CEll2.cellCalenderBtn.isSelected = false
//                if model.status == "in_progress" {
//                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
//                } else {
//                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
//                }
//            }
//        } else if indexPath.section == 1 {
//            let model = Model_Due_Next.shared.arr_get_goals[indexPath.row]
//            CEll2.TodaymeetingLbl.text = model.title
//            CEll2.MeetingwithJerryLbl.text = ""
//            CEll2.Date.text = model.date
//
//            if model.status == "" || model.status == "not_started" {
//                CEll2.cellCalenderBtn.isSelected = true
//                CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
//            } else {
//                CEll2.cellCalenderBtn.isSelected = false
//                if model.status == "in_progress" {
//                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
//                } else {
//                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
//                }
//            }
//        } else {
//            let model = Model_Due_Next.shared.arr_get_list[indexPath.row]
//            CEll2.TodaymeetingLbl.text = model.name
//            CEll2.MeetingwithJerryLbl.text = ""
//            CEll2.Date.text = model.start_date
//
//            if model.status == "" || model.status == "not_started" {
//                CEll2.cellCalenderBtn.isSelected = true
//                CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
//            } else {
//                CEll2.cellCalenderBtn.isSelected = false
//                if model.status == "in_progress" {
//                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
//                } else {
//                    CEll2.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
//                }
//            }
//        }
        
        return CEll2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func tblbtn2(_ sender: UIButton) {
        sectionIsExpanded[sender.tag] = !sectionIsExpanded[sender.tag]
        Tblview.reloadData()
    }
    
    @IBAction func btn_show_all_list(_ sender:UIButton) {
        
        if sender.tag == 0 {
            push_VC("AchivementViewController", storyboard: "Main")
        } else if sender.tag == 1 {
            push_VC("GoalViewController", storyboard: "Main")
        } else if sender.tag == 2 {
            push_VC("ListViewController", storyboard: "Main")
        }
        
    }
    
    @IBAction func cellCalenderBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func tblbtn(_ sender: UIButton){
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.Tblview)
        let indexPath = self.Tblview.indexPathForRow(at: buttonPosition)
        
        if indexPath?.section == 0 {
//            Model_New_Achievement.shared.archievement_id = Model_Due_Next.shared.arr_get_archievements[sender.tag].id
            push_VC("NewAchivementsViewController", storyboard: "Main")
        } else if indexPath?.section == 1 {
            push_VC("CreateGoal_ViewController", storyboard: "Main")
//            Model_CreateGoal.shared.goal_id = Model_Due_Next.shared.arr_get_goals[sender.tag].id
        } else  if indexPath?.section == 2 {
            push_VC("ListViewController", storyboard: "Main")
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
//            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    
}


