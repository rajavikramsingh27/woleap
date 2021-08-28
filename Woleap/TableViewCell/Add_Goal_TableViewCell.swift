//  Add_Goal_TableViewCell.swift
//  Woleap
//
//  Created by iOS-Appentus on 30/July/2019.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Add_Goal_TableViewCell: UITableViewCell {
    @IBOutlet weak var btn_add_more:UIButton!
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_date:UILabel!
    @IBOutlet weak var btn_delete:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
