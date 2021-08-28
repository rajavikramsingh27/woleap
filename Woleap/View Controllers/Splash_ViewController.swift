//  Splash_ViewController.swift
//  Woleap

//  Created by ayush pathak on 17/07/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit

var is_work_or_personal = Int()

class Splash_ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let work_Or_personal = UserDefaults.standard.object(forKey: "work_Or_personal") {
            is_work_or_personal = work_Or_personal as! Int
        }else{
            UserDefaults.standard.set(1, forKey: "work_Or_personal")
            is_work_or_personal = 1
        }
        
        CD_Manger.shared.fetch_result(.login)
        if model_login.shared.id != ""{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                self.push_VC("CalendarViewController", storyboard: "Main")
            })
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
                self.push_VC("LoginViewController", storyboard: "Main")
            }
        }
    }
}
