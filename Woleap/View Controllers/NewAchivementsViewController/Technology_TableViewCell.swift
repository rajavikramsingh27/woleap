
//  Technology_TableViewCell.swift
//  Woleap
//
//  Created by ayush pathak on 19/07/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class Technology_TableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var btn_select:UIButton!
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
