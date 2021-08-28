//  CalenderTableViewCell.swift
//  Woleap

//  Created by Devender Singh Shekhawat on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit

class CalendarTableViewCell: UITableViewCell {
    //    Marks: IBOutlets
    @IBOutlet weak var TodaymeetingLbl: UILabel!
    @IBOutlet weak var MeetingwithJerryLbl: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    @IBOutlet weak var Targetbtn: UIButton!
    @IBOutlet weak var DotBtn: UIButton!
    
    @IBOutlet weak var cellCalenderBtn: UIButton!
    
    @IBOutlet weak var lbl_status_indicator:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
