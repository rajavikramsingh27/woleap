//
//  GoalViewController.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 24/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit


class GoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //    Marks:IBoutlets
    
    @IBOutlet weak var HomeBtn: UIButton!
    
    @IBOutlet weak var SearchTxtFld: UITextField!
    
    @IBOutlet weak var Roundbtn: UIView!
    
    @IBOutlet weak var SwitchBTN: UISwitch!
    
    @IBOutlet weak var InprogressBtnOtlet: UIButton!

    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var CompleteBTnOTlet: UIButton!
    
    @IBOutlet weak var lbl_goals: UILabel!
    
    
    var swipearray = [false, false, false]
    
    let uibuttion = UIButton()
    
    var is_InProgress = false
    
    var arr_searched = [Model_Goal]()
    var arr_for_search = [Model_Goal]()
    var arr_Goals_InProgress_Complete = [Model_Goal]()
    
    @IBOutlet weak var txt_search:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Roundbtn.layer.cornerRadius = Roundbtn.frame.width/2
        func_shadow(view: Roundbtn, color: UIColor.lightGray,CorRad: 0)
        SwitchBTN.set( width: 47, height: 27)

         func_btn(btn: InprogressBtnOtlet,CR: 3, color: UIColor.lightGray, brwidth: 0.1,Shadow: 0, ShadowRadius: 0.0)
        func_btn(btn: CompleteBTnOTlet, CR: 3,color: UIColor.lightGray, brwidth: 0.1,Shadow: 0, ShadowRadius: 0.0)

       
        SwitchBTN.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  func_get_home_data()
    }
    
    @objc func func_get_home_data() {
     
    
    }
    
    //   Marks:IBAction
    @IBAction func InprogressBtn(_ sender: Any) {
        tagbtn(sender: InprogressBtnOtlet, btn: CompleteBTnOTlet, btn2: uibuttion)
        
        InprogressBtnOtlet.setTitleColor(UIColor.init(red: 74.0/255.0, green: 118.0/255.0, blue: 246.0/255.0, alpha: 1.0), for: .normal)
        InprogressBtnOtlet.backgroundColor =  UIColor.init(red: 243.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        
        CompleteBTnOTlet.setTitleColor(UIColor.black, for: .normal)
        CompleteBTnOTlet.backgroundColor =  UIColor .white
        
        is_InProgress = true
        
        if arr_Goals_InProgress_Complete.count == 0 {
            self.tblview.isHidden = true
            self.lbl_goals.text = "Goals not in InProgess"
        } else {
            self.tblview.isHidden = false
        }
        txt_search.text = ""
        tblview.reloadData()
    }
    
    @IBAction func CompleteBtn(_ sender: Any) {
        tagbtn(sender: CompleteBTnOTlet, btn: InprogressBtnOtlet, btn2: uibuttion)
        is_InProgress = false
        
        CompleteBTnOTlet.setTitleColor(UIColor.init(red: 74.0/255.0, green: 118.0/255.0, blue: 246.0/255.0, alpha: 1.0), for: .normal)
        CompleteBTnOTlet.backgroundColor =  UIColor.init(red: 243.0/255.0, green: 244.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        
        InprogressBtnOtlet.setTitleColor(UIColor.black, for: .normal)
        InprogressBtnOtlet.backgroundColor =  UIColor .white
        
        arr_for_search = arr_Goals_InProgress_Complete
        if arr_Goals_InProgress_Complete.count == 0 {
            self.tblview.isHidden = true
            self.lbl_goals.text = "Goals not in Complete"
        } else {
            self.tblview.isHidden = false
        }
        txt_search.text = ""
        tblview.reloadData()
    }
    
    @IBAction func AddBtn(_ sender: Any) {
        
    }
    
    @IBAction func CalendarBtn(_ sender: Any) {
    }
    
    @IBAction func SearchBtn(_ sender: Any) {
    }
    
    @IBAction func HomeBtn(_ sender: Any) {
        pop_single()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return arr_Goals_InProgress_Complete.count
        return 3
    }
    
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let goalcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GoalTableViewCell
//        func_btn(btn: goalcell.GoalView,CR: 5, color: UIColor.lightGray, brwidth: 0, Shadow: 1, ShadowRadius: 1.0)
//       
//        goalcell.targetbtn.addTarget(self, action: #selector(trgbtn(_:)), for: .touchUpInside)
//        
//        goalcell.targetbtn.isUserInteractionEnabled = true
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipegeasture(sender:)))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        goalcell.targetbtn.addGestureRecognizer(swipeLeft)
//        
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipegeasture(sender:)))
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        goalcell.targetbtn.addGestureRecognizer(swipeRight)
//        
//        goalcell.targetbtn.tag = indexPath.row
//        
////        if swipearray[indexPath.row] {
////            goalcell.swipeView.isHidden = false
////        } else {
//            goalcell.swipeView.isHidden = true
////        }
//        
//        let model = arr_Goals_InProgress_Complete[indexPath.row]
//        
//        goalcell.GoalLbl.text = model.title
//        goalcell.DateLlb.text = model.date
//        if model.status.isEmpty {
//            goalcell.NotstrtLbl.text = "Not started"
//        } else {
//            goalcell.NotstrtLbl.text = model.status
//        }
//        
//        if model.status == "" || model.status == "Not Started" {
//            goalcell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "BEBEBE")
//        } else {
//            if model.status == "In Progress" {
//                goalcell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
//            } else if model.status == "Past Due" {
//                goalcell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "8EA9DB")
//            } else {
//                goalcell.lbl_status_indicator.backgroundColor = hexStringToUIColor(hex: "C4DFB3")
//            }
//        }
        
        return goalcell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let goalVC = self.storyboard?.instantiateViewController(withIdentifier: "NewGoalViewController") as! NewGoalViewController
//        self.navigationController?.pushViewController(goalVC, animated: true)
//        self.present(goalVC,animated: true, completion: nil)
//    }
    
    @IBAction func trgbtn(_ sender: UIButton) {
      push_VC("CreateGoal_ViewController", storyboard: "Main")
   }
    
    @IBAction func swipegeasture(sender: UISwipeGestureRecognizer){
            if sender.direction == .left {
                let buttonPosition:CGPoint = (sender.view?.convert(CGPoint.zero, to:self.tblview))!
                let indexPath = self.tblview.indexPathForRow(at: buttonPosition)
                
                for i in 0..<swipearray.count {
                    if i == indexPath?.row {
                        swipearray[i] = true
                    } else {
                        swipearray[i] = false
                    }
                }
            } else {
                print("hh")
                for i in 0..<swipearray.count {
                    swipearray[i] = false
                }            }
            
            tblview .reloadData()
        }
    
    
    
    @IBAction func txt_Search(_ sender: UITextField) {
       
    }
    
}



extension GoalViewController {
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction.init(style: .destructive, title: "") { (action, view, nil) in
            print("delete")
            
           
        }
        
        delete.image = UIImage(named: "delete")
        delete.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.2196078431, blue: 0.2, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        self.tblview.subviews.forEach { subview in
            print("YourTableViewController: \(String(describing: type(of: subview)))")
            if (String(describing: type(of: subview)) == "UISwipeActionPullView") {
                if (String(describing: type(of: subview.subviews[0])) == "UISwipeActionStandardButton") {
                    var deleteBtnFrame = subview.subviews[0].frame
                    deleteBtnFrame.origin.y = 0
                    deleteBtnFrame.size.height = 99
                    
                    // Subview in this case is the whole edit View
                    subview.frame.origin.y =  subview.frame.origin.y + 5
                    subview.frame.size.height = 99
                    subview.subviews[0].frame = deleteBtnFrame
                    subview.backgroundColor = UIColor.clear
                }
            }
        }
    }
    
    @objc func func_remove_goal() {

        
    }
    
}
