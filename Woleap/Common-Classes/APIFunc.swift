
//  APIFunc.swift
//  Woleap
//
//  Created by ayush pathak on 16/07/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation
import Alamofire
import CDAlertView

class APIFunc {
    class func postAPI(url: String , parameters: [String:Any] , completion: @escaping ([String:Any]) -> ()){
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            let apiURL = url
            let param = parameters
            Alamofire.request(apiURL, method: .post, parameters: param).validate().responseString { (response) in
                switch response.result {
                case .success:
                    let responseJson = anyConvertToDictionary(text: response.result.value!)
                    completion(responseJson!)
                    break
                case .failure(let error):
                    completion(["error":true,"error_message" : "\(error.localizedDescription)"])
                    print(error)
                    break
                }
            }
        }else{
            func_show_alert()
        }
    }
    
    class func getAPI(url: String , parameters: [String:Any] , completion: @escaping ([String:Any]) -> ()){
        if Reachability.isConnectedToNetwork(){
            let apiURL = url
            let param = parameters
            Alamofire.request(apiURL, method: .get, parameters: param).validate().responseString { (response) in
                switch response.result {
                case .success:
                    let responseJson = anyConvertToDictionary(text: response.result.value!)
                    completion(responseJson!)
                    break
                case .failure(let error):
                    completion(["error":true,"error_message" : "\(error.localizedDescription)"])
                    break
                }
            }
        }else{
            func_show_alert()
        }
    }
    
    
    class func postApiMultiPart(url: String ,imageParamaterName : String, parameters: [String:Any] ,imageData: Data, completion: @escaping (NSDictionary) -> ()){
        if Reachability.isConnectedToNetwork(){
            let date = NSDate()
            let df = DateFormatter()
            df.dateFormat = "dd-mm-yy-hh-mm-ss"
            
            let imageName = df.string(from: date as Date)
            
            Alamofire.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
                multipartFormData.append(imageData, withName: imageParamaterName,fileName: "\(imageName)file.png", mimeType: "image/png")
                for (key, value) in parameters {
                    
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, to: url) { (result) in
                print(result)
                switch result {
                case .success(let upload, _ , _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        
                        print("uploding")
                    })
                    
                    upload.responseJSON { response in
                        
                        let resp = response.result.value! as! NSDictionary
                        completion(resp)
                        
                    }
                    
                case .failure(let error):
                    print("failed")
                    completion(["error":true,"error_message" : "\(error.localizedDescription)"])
                    
                }
            }
            
        }else{
            func_show_alert()
        }
        
        
        
        
    }
    
    
    
    
    class func postApiMultiPart_Video(url: String ,imageParamaterName : String, parameters: [String:Any] ,imageData: URL, completion: @escaping (NSDictionary) -> ()){
        var data : Data!
        
        if Reachability.isConnectedToNetwork(){
            
            let date = NSDate()
            let df = DateFormatter()
            df.dateFormat = "dd-mm-yy-hh-mm-ss"
            
            let imageName = df.string(from: date as Date)
            
            do {
                data = try Data(contentsOf:imageData)
            } catch {
                print("Unable to load data: \(error)")
            }
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
                multipartFormData.append(data, withName: imageParamaterName,fileName: "\(imageName)file.mp4", mimeType: "video/mp4")
                for (key, value) in parameters {
                    
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, to: url) { (result) in
                print(result)
                switch result {
                case .success(let upload, _ , _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        
                        print("uploding")
                    })
                    
                    upload.responseJSON { response in
                        
                        let resp = response.result.value! as! NSDictionary
                        completion(resp)
                        
                    }
                    
                case .failure(let error):
                    print("failed")
                    completion(["error":true,"error_message" : "\(error.localizedDescription)"])
                    
                }
            }
            
        }else{
            func_show_alert()
        }
        
        
        
        
    }
    
    
    
}


func func_show_alert() {
    let alert = CDAlertView(title:"Internet Connection not Available!", message:"", type:.error)
    alert.autoHideTime = 2
    alert.show()
}

func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}


func anyConvertToDictionary(text: String) -> [String: Any]? {
    
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("\(error.localizedDescription)")
            
        }
    }
    return nil
}
