//  Calender2TableViewCell.swift
//  Woleap

//  Created by Devender Singh Shekhawat on 25/06/19.
//  Copyright © 2019 appentus. All rights reserved.


import UIKit


class Calender2TableViewCell: UITableViewCell {
//    Marks: IBOutlets
    @IBOutlet weak var AchiveLbl: UILabel!
    @IBOutlet weak var BadgeImgView: UIImageView!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var RoundImgView: UIImageView!
    
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var ROundView: UIView!
    
    @IBOutlet weak var btn_show_all_list:UIButton!
    
    @IBOutlet weak var lbl_total_counts:UILabel!
    
    
    var tapGesture = UITapGestureRecognizer()
    var longGesture = UILongPressGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapGesture.numberOfTapsRequired = 1
        longGesture.minimumPressDuration = 0.5
        
        if View != nil {
            View.addGestureRecognizer(tapGesture)
            View.addGestureRecognizer(longGesture)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setExpanded() {
//        RoundImgView.image = UIImage(named: "horizontal-line")
        dropdownImg.image = UIImage(named: "ups.png")
        Label.backgroundColor = UIColor.init(red: 72.0/255.0, green: 170.0/255.0, blue: 219.0/255.0, alpha: 1.0 )
    }
    
    func setCollapsed() {
//        RoundImgView.image = UIImage(named: "plus-2")
          dropdownImg.image = UIImage(named: "downs.png")
         Label.backgroundColor = UIColor.init(red: 91.0/255.0, green: 105.0/255.0, blue: 194.0, alpha: 1.0)
    }
    
}
