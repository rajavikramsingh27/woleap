//  Constact.swift
//  Woleap

//  Created by ayush pathak on 16/07/19.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation
import UIKit
import MBProgressHUD
import CDAlertView
import CoreData


let color_app = UIColor (red: 218.0/255.0, green: 73.0/255.0, blue: 87.0/255.0, alpha: 1.0)

let k_base_url = "http://appentus.me/appentus_promap/Api/"

let date_format_WoLeap = "yyyy-MM-dd"

extension UIViewController {
    func func_ShowHud() {
//        JJHUD.showLoading()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.view .isUserInteractionEnabled = false
    }
    
    func func_ShowHud_Success(with message:String) {
//        JJHUD.showSuccess(text: message, delay: 60)
        let alert = CDAlertView(title:message, message:"", type:.success)
        alert.autoHideTime = 0.7
        alert.show()
//        self.view .isUserInteractionEnabled = false
    }
    
    func func_ShowHud_Error(with message:String) {
//        JJHUD.showError(text: message, delay:60)
        let alert = CDAlertView(title:message, message:"", type:.error)
        alert.autoHideTime = 0.7
        alert.show()
//        self.view .isUserInteractionEnabled = false
    }
    
    func func_HideHud() {
//        JJHUD.hide()
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    
    func func_IsValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    func pop_single() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_dismiss_ViewControllers(_ sender:Any) {
        pop_single()
    }
}

extension UIView {
    func func_roundCorners(_ corners: UIRectCorner, _ radius: Int) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

func func_DatePickerDate(_ sender:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: sender)
}



func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UINavigationBar {
    func func_shadow(navbar:UINavigationBar)  {
        navbar.layer.shadowOpacity = 1.0
        navbar.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        navbar.layer.shadowRadius = 1.0
        navbar.layer.shadowColor = UIColor .lightGray.cgColor
    }
}



func func_ArrOrDictToString(from object:[String]) -> String {
//    return "\"[\"" + object.joined(separator: "\",\"") + "\"]\""
    guard let data = try? JSONSerialization.data(withJSONObject: object, options:.prettyPrinted) else {
        return ""
    }
    return String(data: data, encoding:.utf8)!
}



func func_ArrOfDictToString(from object:[[String:String]]) -> String {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options:[]) else {
        return ""
    }
    return unescapeString(string: String(data: data, encoding:.utf8)!)
}

func unescapeString(string: String) -> String {
    return string.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
}


@IBDesignable class Custom_Image:UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var width: Int = 0
    @IBInspectable var height: Int = 0
    @IBInspectable var color: UIColor? = UIColor.clear
    @IBInspectable var opacity: Float = 0.0
    @IBInspectable var radius: Float = 0.0
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = color?.cgColor
        layer.shadowOffset = CGSize(width: width, height: height);
        layer.shadowOpacity = opacity
        layer.shadowRadius = CGFloat(radius)
        layer.shadowPath = shadowPath.cgPath
    }
    
}

enum status_type {
    case error_from_api
    case success
    case fail
}

func return_status(_ resp:[String:Any]) -> status_type {
    if let error = resp["error"] as? Bool{
        return status_type.error_from_api
    }else{
        let status = "\(resp["status"]!)"
        if status == "1"{
            return status_type.success
        }else{
            
            return status_type.fail
        }
    }
}

extension String{
    func remove_white_string() -> String{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
}

enum work_Or_personal{
    case work
    case personal
}

func set_status_work_personal(type: work_Or_personal) {
    switch type {
    case .work:
        print("work")
        UserDefaults.standard.set(0, forKey: "work_Or_personal")
        is_work_or_personal = 0
    case .personal:
        print("personal")
        UserDefaults.standard.set(1, forKey: "work_Or_personal")
        is_work_or_personal = 1
    }
   
}
extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
extension Date {
    var month_int: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
}
func array_to_string(object:NSArray) -> String {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options:.prettyPrinted) else {
        return ""
    }
    return String(data: data, encoding:.utf8)!
}

func string_to_array(object:String) -> NSArray {
    var array : NSArray!
    do{
        if let json = object.data(using:.utf8){
            if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? NSArray {
                array = jsonData
            }
        }
    }catch {
        print(error.localizedDescription)
    }
    return array
}
func func_shadow_1(view:UIView) {
    view.layer.shadowOpacity = 1.0
    view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    view.layer.shadowRadius = 2.0
    view.layer.shadowColor = UIColor .lightGray.cgColor
}

