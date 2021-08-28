//  RegisterViewController.swift
//  Woleap

//  Created by ayush pathak on 21/06/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit


import FBSDKCoreKit
import FBSDKLoginKit


class RegisterViewController: UIViewController {
//    Marks: IBoutlet
    @IBOutlet weak var RegSecondView: UIView!
    @IBOutlet weak var RegFirstView: UIView!
    @IBOutlet weak var RegImageView: UIImageView!
    @IBOutlet weak var NameTxtfld: UITextField!
    @IBOutlet weak var PhoneTxtFld: UITextField!
    @IBOutlet weak var RegEmail: UITextField!
    @IBOutlet weak var RegPassTxtFld: UITextField!
    @IBOutlet weak var RegLoginBtn: UIButton!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var LoginLbl: UILabel!
    @IBOutlet weak var RegLgnWthLkdnBtn: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var btn_FB: UIButton!
    @IBOutlet weak var GoogleBtn: UIButton!
    
    @IBOutlet weak var VIEWinScroll: UIView!
    
    @IBOutlet weak var img_logo: UIImageView!
    
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img_logo.layer.cornerRadius = 4
        img_logo.clipsToBounds = true
        
        func_shadow(view: RegFirstView, color: UIColor.lightGray,CorRad: 4)
        func_shadow(view: RegSecondView, color: UIColor.lightGray,CorRad: 4)
        
        func_txtfield(txt: RegEmail, color: UIColor.white, brwidth: 0.5)
        func_txtfield(txt: RegPassTxtFld, color: UIColor.white, brwidth: 0.5)
        func_txtfield(txt: PhoneTxtFld, color: UIColor.white, brwidth: 0.5)
        func_txtfield(txt: NameTxtfld, color: UIColor.white, brwidth: 0.5)
        func_btn(btn: RegLoginBtn,CR: 5, color:UIColor.white , brwidth: 0.0,Shadow: 0, ShadowRadius: 0.0)
        
        RegFirstView.curvecorner()
        RegSecondView.curvecorner()
        VIEWinScroll.curvecorner()
        scrollview.curvecorner()
        
        func_btn(btn: RegLgnWthLkdnBtn,CR: 5, color: UIColor.white, brwidth:1.0,Shadow: 0, ShadowRadius: 0.0)
        func_btn(btn: GoogleBtn,CR: 5, color: UIColor.white, brwidth: 1.0,Shadow: 0, ShadowRadius: 0.0)
        func_btn(btn: btn_FB,CR: 5, color: UIColor.white, brwidth: 1.0,Shadow: 0, ShadowRadius: 0.0)
        
        LoginLbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        NotificationCenter.default.addObserver(self, selector: #selector(func_linkedIn_SignIn), name: NSNotification.Name .init(rawValue: "linkedInProfile_regis"), object: nil)
    }
    
    // Marks: IBAction
    @IBAction func RegLoginBTN(_ sender: Any) {
        if !func_validation() {
            return
        }
        signup_by_mail(self.NameTxtfld.text!.remove_white_string(), self.RegEmail.text!.remove_white_string(), self.PhoneTxtFld.text!.remove_white_string(), self.RegPassTxtFld.text!.remove_white_string())
    }
    
    @IBAction func LInkEdinBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.is_login = false
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func RegisterBTN(_ sender: Any) {
        pop_single()
    }
    
    @objc func func_linkedIn_SignIn() {
        if let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken") {
            let targetURLString =  "https://api.linkedin.com/v2/me?projection=(id,firstName,email-address,lastName,profilePicture(displayImage~:playableStreams))"
            
            // Initialize a mutable URL request object.
            let request = NSMutableURLRequest(url: NSURL(string: targetURLString)! as URL)
            
            // Indicate that this is a GET request.
            request.httpMethod = "GET"
            
            // Add the access token as an HTTP header field.
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            
            // Initialize a NSURLSession object.
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // Make the request.
            let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                // Get the HTTP status code of the request.
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                if error == nil {
                    do {
                        let dataDictionary = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                        print(dataDictionary)
                        let social_ID = "\(dataDictionary["id"]!)"
                        let firstName = dataDictionary["firstName"] as! [String:Any]
                        let localized = firstName["localized"] as! [String:Any]
                        let firstName_localized = "\(localized["en_US"]!)"
                        
                        let lastName = dataDictionary["lastName"] as! [String:Any]
                        let localized_1 = lastName["localized"] as! [String:Any]
                        let lastName_localized = "\(localized_1["en_US"]!)"
                        
                        print(firstName_localized)
                        print(lastName_localized)
                        
                        let full_name = firstName_localized+lastName_localized
                        
                        DispatchQueue.main.async {
                            self.login_social_api(full_name, "", social_ID)
                        }

                    }
                    catch {
                        print("Could not convert JSON data into a dictionary.")
                    }
                } else {
                    print("error is:-",error!.localizedDescription)
                }
            }
            
            task.resume()
        }
    }
    
    func func_validation() -> Bool {
        var is_valid = true
        
        if NameTxtfld.text!.isEmpty {
            is_valid = false
            func_ShowHud_Error(with: "Enter your name")
        } else if PhoneTxtFld.text!.isEmpty {
            is_valid = false
            func_ShowHud_Error(with: "Enter your phone number")
        } else if PhoneTxtFld.text!.count < 7 {
            is_valid = false
            func_ShowHud_Error(with: "Your phone number must be greater than 7 characters")
        } else if RegPassTxtFld.text!.isEmpty {
            is_valid = false
            func_ShowHud_Error(with: "Enter your password")
        } else if RegPassTxtFld.text!.count < 6 {
            is_valid = false
            func_ShowHud_Error(with: "Your password min length 6")
        } else if RegEmail.text!.isEmpty {
            is_valid = false
            func_ShowHud_Error(with: "Enter your E-mail")
        } else if !func_IsValidEmail(testStr: RegEmail.text!) {
            is_valid = false
            func_ShowHud_Error(with: "Enter valid E-mail")
        } else {
            is_valid = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.func_HideHud()
        }
        
        return is_valid
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"
        let NUMBERS_CHARACTERS = "+0123456789"
        let EMAIL_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_@.-"
        
        
        if textField == NameTxtfld {
            if NameTxtfld.text!.count > 31 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField == PhoneTxtFld {
            if PhoneTxtFld.text!.count > 15 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: NUMBERS_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else if textField == RegEmail {
            if RegEmail.text!.count > 30 {
                if string == "" {
                    return true
                } else {
                    return false
                }
            } else {
                let cs = NSCharacterSet(charactersIn: EMAIL_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else {
            return true
        }
    }
    
}






import GoogleSignIn

extension RegisterViewController  : GIDSignInDelegate ,GIDSignInUIDelegate {
    @IBAction func btn_Google_SignIn(_ sender:UIButton) {
        //func_ShowHud()
        GIDSignIn.sharedInstance()!.signOut()
        GIDSignIn.sharedInstance()!.disconnect()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        func_HideHud()
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            let name = user.profile.name!
            let email = user.profile.email!
            let social_id = user.userID!
            self.login_social_api(name, email, social_id)
        }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        if error != nil {
            print("\(error.localizedDescription)")
        }
    }

}

extension RegisterViewController {
    @IBAction func btn_func_facebook(_ sender:UIButton) {
        self.view.endEditing(true)
        fbLoginManager.logOut()
        fbLoginManager.loginBehavior = .native
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if (result?.isCancelled)!{
                    return
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.fbLoginManager.logOut()
                    self.getFBUserData()
                } else {
                }
            } else {
                self.func_ShowHud_Error(with:error!.localizedDescription)
            }
        }
    }
    
    func getFBUserData() {
        func_ShowHud()
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: {
            (connection, result, error) -> Void in
            DispatchQueue.main.async {
                if (error == nil) {
                    let resultJson : NSDictionary = result as! NSDictionary
                    print(resultJson)
                    
                    let socialID = "\(resultJson["id"] ?? "")"
                    let email = "\(resultJson["email"] ?? "")"
                    
                    let first_name = "\(resultJson["first_name"] ?? "")"
                    let last_name = "\(resultJson["last_name"] ?? "")"
                    
                    let imageDict : NSDictionary = resultJson["picture"] as! NSDictionary
                    let dataOne : NSDictionary = imageDict["data"] as! NSDictionary
                    //                    let imageUrl = "\(dataOne["url"]!)"
                    let name = first_name+" "+last_name
                    self.login_social_api(name, email, socialID)
                } else {
                    self.func_ShowHud_Error(with:"\(error!)")
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        self.func_HideHud()
                    }
                }
            }
        })
    }
    
}
extension RegisterViewController{
    //    MARK: API FUNCTIONS
    
    func signup_by_mail(_ name:String,_ email: String,_ mobile:String,_ password:String) {
        func_ShowHud()
        self.view.endEditing(true)
        let param = ["email":email,"password":password,"login_type":"manual","name":name,"mobile":mobile] as [String:Any]
        
        APIFunc.postAPI(url: k_base_url+"login", parameters: param) { (resp) in
            let status = return_status(resp)
            switch status{
            case .success:
                let result = resp["result"] as! NSDictionary
                var arr_values = [String]()
                
                arr_values.append("\(result["id"]!)")
                arr_values.append("\(result["name"]!)")
                arr_values.append("\(result["email"]!)")
                arr_values.append("\(result["mobile"]!)")
                arr_values.append("\(result["password"]!)")
                arr_values.append("\(result["start_time"]!)")
                arr_values.append("\(result["due_to"]!)")
                arr_values.append("\(result["social_id"]!)")
                arr_values.append("\(result["login_type"]!)")
                arr_values.append("\(result["is_active"]!)")
                arr_values.append("\(result["created"]!)")
                
                CD_Manger.shared.add_data_to_database(arr_values, .login, completion: { (_) in
                    CD_Manger.shared.fetch_result(.login)
                    self.func_HideHud()
                    print("Signup successful")
                    self.func_ShowHud_Success(with: "Signup Successful")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.7, execute: {
                        self.push_VC("CalendarViewController", storyboard: "Main")
                    })
                })
            case .fail:
                self.func_HideHud()
                self.func_ShowHud_Error(with: "\(resp["message"]!)")
            case .error_from_api:
                self.func_HideHud()
                self.func_ShowHud_Error(with: resp["error_message"] as! String)
            }
        }
    }
    
    func login_social_api(_ name:String,_ email:String,_ social_id:String) {
        func_ShowHud()
        self.view.endEditing(true)
        let param = ["name":name,"email":email,"login_type":"social","social_id":social_id] as [String:Any]
        
        APIFunc.postAPI(url: k_base_url+"signup", parameters: param) { (resp) in
            let status = return_status(resp)
            switch status{
            case .success:
                let result = resp["result"] as! NSDictionary
                var arr_values = [String]()
                
                arr_values.append("\(result["id"]!)")
                arr_values.append("\(result["name"]!)")
                arr_values.append("\(result["email"]!)")
                arr_values.append("\(result["mobile"]!)")
                arr_values.append("\(result["password"]!)")
                arr_values.append("\(result["start_time"]!)")
                arr_values.append("\(result["due_to"]!)")
                arr_values.append("\(result["social_id"]!)")
                arr_values.append("\(result["login_type"]!)")
                arr_values.append("\(result["is_active"]!)")
                arr_values.append("\(result["created"]!)")
                
                CD_Manger.shared.add_data_to_database(arr_values, .login, completion: { (_) in
                    CD_Manger.shared.fetch_result(.login)
                    self.func_HideHud()
                    print("social login successful")
                    self.func_ShowHud_Success(with: "Login Successful")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.7, execute: {
                        self.push_VC("CalendarViewController", storyboard: "Main")
                    })
                })
            case .fail:
                self.func_HideHud()
                self.func_ShowHud_Error(with: "\(resp["message"]!)")
            case .error_from_api:
                self.func_HideHud()
                self.func_ShowHud_Error(with: resp["error_message"] as! String)
            }
        }
    }
    
}

