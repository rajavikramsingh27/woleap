//
//  Tag_Goal_CollectionViewCell.swift
//  Woleap
//
//  Created by ayush pathak on 19/07/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit

class Tag_Goal_CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl_goal_name:UILabel!
    @IBOutlet weak var btn_select:UIButton!
    
    @IBOutlet weak var GoalTitle1View: UIView!
    
    override func awakeFromNib() {
        GoalTitle1View.layer.cornerRadius = 2
        GoalTitle1View.clipsToBounds = true
    }
    
}







