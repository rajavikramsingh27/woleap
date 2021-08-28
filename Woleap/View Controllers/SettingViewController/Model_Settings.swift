//
//  Model_Settings.swift
//  Woleap
//
//  Created by appentus technologies pvt. ltd. on 8/26/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class Model_Settings {
    static let shared = Model_Settings()
    
    var name = ""
    var email = ""
    var mobile = ""
    var start_time = ""
    var due_to = ""
    
    var message = ""
    
//    func func_update_profile(completionHandler:@escaping (String)->()) {
//        let params = [
//            "user_id":Model_Splash.shared.id,
//            "name":name,
//            "email":email,
//            "mobile":mobile,
//            "start_time":start_time,
//            "due_to":due_to,
//        ]
//        print(params)
//        
//        APIFunc.postAPI(url: k_base_url+"update_profile", parameters: params) {
//            (dict_JSON) in
//            print(dict_JSON)
//            
//            if "\(dict_JSON["status"]!)" == "1" {
//                self.message = dict_JSON["message"] as! String
//                
//                if let data_LoginData = UserDefaults.standard.object(forKey: "login_Data") as? Data {
//                    var dict_LoginData = NSKeyedUnarchiver.unarchiveObject(with: data_LoginData) as! [String: Any]
//                    print(dict_LoginData)
//                    
//                    dict_LoginData["name"] = self.name
//                    dict_LoginData["email"] = self.email
//                    dict_LoginData["mobile"] = self.mobile
//                    
//                    dict_LoginData["start_time"] = self.start_time
//                    dict_LoginData["due_to"] = self.due_to
//                    
//                    Model_Splash.shared.func_login_Data_In_Default(dict_Result: dict_LoginData)
//                }
//                
//                completionHandler("\(dict_JSON["status"]!)")
//            } else {
//                if "\(dict_JSON["status"]!)" == "0" {
//                    self.message = "\(dict_JSON["message"]!)"
//                    completionHandler("\(dict_JSON["status"]!)")
//                } else {
//                    completionHandler("0")
//                }
//            }
//        }
//    }
    
    
    
}


