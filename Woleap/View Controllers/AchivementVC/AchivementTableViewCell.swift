//
//  AchivementTableViewCell.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class AchivementTableViewCell: UITableViewCell {
    
    
    //     Marks: IBoutlets
    
    @IBOutlet weak var DEsignlbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var NotStrtLbl: UILabel!
//    @IBOutlet weak var CalendarImgView: UIImageView!
    @IBOutlet weak var NotStrtImgView: UIImageView!
    @IBOutlet weak var AchvView: UIView!
    @IBOutlet weak var AchvView2: UIView!
    @IBOutlet weak var Targetbtn: UIButton!
    
    @IBOutlet weak var lbl_status_indicator:UILabel!
    
    @IBOutlet weak var cellCalenderBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
