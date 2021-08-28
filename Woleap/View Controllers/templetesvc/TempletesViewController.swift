//
//  TempletesViewController.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 09/07/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class TempletesViewController: UIViewController {
    
    @IBOutlet weak var checkboxBtn: UIButton!
    @IBOutlet weak var cehckboxreminder: UIButton!
    @IBOutlet weak var time1Lbl: UITextField!
    @IBOutlet weak var time2Lbl: UITextField!
    @IBOutlet weak var schedulelbl: UILabel!
    @IBOutlet weak var reminderlbl: UILabel!
    
    var emptylbl = UILabel()
    var emtybutton = UIButton()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func schedulecheckBtn(_ sender: Any) {
        btn(button: checkboxBtn, button2: emtybutton ,label: schedulelbl, label2: emptylbl)
    }
    
    @IBAction func remindercheckboxBtn(_ sender: Any) {
        btn(button: cehckboxreminder, button2: emtybutton,label: reminderlbl, label2: emptylbl)
    }
    
}
