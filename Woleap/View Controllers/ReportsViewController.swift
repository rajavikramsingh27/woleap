//
//  ReportsViewController.swift
//  Woleap
//
//  Created by ayush pathak on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit


class ReportsViewController: UIViewController {
    
    
    var emptybutton = UIButton()
    var emptyLbl = UILabel()
    //     Marks: IBOutLets
    
    @IBOutlet weak var fromlbl: UILabel!
    
    @IBOutlet weak var toLbl: UILabel!
    
    @IBOutlet weak var donebtn: UIButton!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var SwitchBTN: UISwitch!
    @IBOutlet weak var pickerView: UIView!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var includeachiLbl: UILabel!
    @IBOutlet weak var incgoalBtn: UILabel!
    @IBOutlet weak var inctaskBtn: UILabel!
    @IBOutlet weak var incAchBTn: UIButton!
    @IBOutlet weak var incGoalBTn: UIButton!
    @IBOutlet weak var incTaskBtn: UIButton!
    @IBOutlet weak var instackView1: UIView!
    @IBOutlet weak var instackView2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwitchBTN.set( width: 47, height: 27)
        instackView1.curvecorner()
        instackView2.curvecorner()


        
    }
    
    
    //     Marks: IBActions
    
    
    @IBAction func AchiveBTn(_ sender: Any) {
         btn(button:incAchBTn,button2: emptybutton, label: includeachiLbl, label2: emptyLbl)
    }
    
    @IBAction func GoalsBtn(_ sender: Any) {
         btn(button:incGoalBTn,button2: emptybutton, label: incgoalBtn, label2: emptyLbl)
    }
    
    
    @IBAction func TasksBTn(_ sender: Any) {
         btn(button:incTaskBtn,button2: emptybutton, label: inctaskBtn, label2: emptyLbl)
    }
    
    @IBAction func homeBtn(_ sender: Any) {
//        self.func_present_VC("CalendarViewController")
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
//
//        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        pickerView.isHidden = true
    }
    
    @IBAction func fromBtn(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    @IBAction func toBtn(_ sender: Any) {
        pickerView.isHidden = false
    }
    
    @IBAction func datepicker(_ sender: Any) {
        
      
       
        if fromBtn.tag == 1{
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.short
            
            
            let strDate = dateFormatter.string(from: (sender as AnyObject).date)
            fromlbl.text = strDate
        }
        else if toLbl.tag == 2 {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.short
            
            
            let strDate = dateFormatter.string(from: (sender as AnyObject).date)
            toLbl.text = strDate
        }
    }
    
    
}
