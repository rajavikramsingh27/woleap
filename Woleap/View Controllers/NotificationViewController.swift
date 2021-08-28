//
//  NotificationViewController.swift
//  Woleap
//
//  Created by ayush pathak on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    //    Marks: IBOutlets
    
    @IBOutlet weak var NotiView: UIView!
    @IBOutlet weak var IMgView: UIImageView!
    
    @IBOutlet weak var notibackView: UIView!
    @IBOutlet weak var WoleapLbl: UILabel!
    @IBOutlet weak var UidesignBtn: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
   @IBOutlet weak var SnoozeBtn: UIButton!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var DismissBtn: UIButton!
    
    @IBOutlet weak var snoozeView: UIView!
    
    @IBOutlet weak var doneView: UIView!
    
    @IBOutlet weak var dismissview: UIView!
    @IBOutlet weak var bellView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snoozeView.roundedimage()
        doneView.roundedimage()
        dismissview.roundedimage()
        func_shadow(view: NotiView, color: UIColor.lightGray,CorRad: 4)
         NotiView.layer.cornerRadius = 10.0
        bellView.layer.cornerRadius = 10.0
//        notibackView.backgroundColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.2)
    }
    
    // Marks: IBAction

    @IBAction func AlarmBtn(_ sender: Any) {
    }
    
    @IBAction func SnoozeBTn(_ sender: Any) {
    }
    
    
    @IBAction func DOneBTn(_ sender: Any) {
    }
    
    @IBAction func DismissBTn(_ sender: Any) {
    }
    
    
}
