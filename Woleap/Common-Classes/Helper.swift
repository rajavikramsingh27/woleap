//  Helper.swift
//  Woleap
//  Created by iOS-Appentus on 29/July/2019.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation
import UIKit



extension UIViewController {
    func push_VC(_ identifier:String, storyboard : String) {
        weak var storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier:identifier)
        self.navigationController?.pushViewController(vcToPresent, animated: true)
    }
    
    
    
}


