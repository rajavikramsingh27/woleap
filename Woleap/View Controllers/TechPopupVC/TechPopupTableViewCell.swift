//
//  TechPopupTableViewCell.swift
//  Woleap
//
//  Created by ayush pathak on 24/06/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit

class TechPopupTableViewCell: UITableViewCell {
    
    
    //     Marks: IBOutlets
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var DemoLbl: UILabel!
    @IBOutlet weak var AddBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        AddBtn.curvecorner()
        ImgView.roundedimage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    Marks IBaction
    
    @IBAction func AddBTn(_ sender: Any) {
        
    }
    
}
