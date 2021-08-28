//
//  GoalTableViewCell.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 26/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    //    Marks: IBOutlet
    
    @IBOutlet weak var GoalLbl: UILabel!
    @IBOutlet weak var DateLlb: UILabel!
    @IBOutlet weak var NotstrtLbl: UILabel!
    @IBOutlet weak var GoalView: UIView!
    @IBOutlet weak var targetbtn: UIButton!
    @IBOutlet weak var deletebackgroung: UIView!
    
    @IBOutlet weak var swipeView: UIView!
    
    @IBOutlet weak var lbl_status_indicator:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        deletebackgroung.roundedimage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //    Marks:IBAction
    
    
    
}
