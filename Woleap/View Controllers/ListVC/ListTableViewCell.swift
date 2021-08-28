//
//  ListTableViewCell.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 26/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    //    Marks:IBOutlet
    
    @IBOutlet weak var TempLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var targetBtn: UIButton!
    @IBOutlet weak var ListView: UIView!
    
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
