//  LoginViewController.swift
//  Woleap
//
//  Created by Devender Singh Shekhawat on 21/06/19.
//  Copyright © 2019 appentus. All rights reserved.



import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

//        Marks: IBoutlets
    
    @IBOutlet weak var EmailTxtField: UITextField!
    @IBOutlet weak var PasswordTxtfld: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var LInkedinBTn: UIButton!
    @IBOutlet weak var btn_FB: UIButton!
    @IBOutlet weak var GoogleBtn: UIButton!
    @IBOutlet weak var img_logo: UIImageView!
    
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initviewa()
    }
    
    func initviewa() {
        img_logo.layer.cornerRadius = 4
        img_logo.clipsToBounds = true
        func_txtfield(txt: EmailTxtField, color: UIColor.white, brwidth: 1)
        func_txtfield(txt: PasswordTxtfld, color: UIColor.white, brwidth: 1)
        func_btn(btn: LoginBtn,CR: 5, color:UIColor.white , brwidth: 0.0,Shadow: 0, ShadowRadius: 0.0)
        scrollview.curvecorner()
        func_btn(btn: LInkedinBTn,CR: 5, color: UIColor.white, brwidth:1.0,Shadow: 0, ShadowRadius: 0.0)
        func_btn(btn: GoogleBtn,CR: 5, color: UIColor.white, brwidth: 1.0,Shadow: 0, ShadowRadius: 0.0)
        func_btn(btn: btn_FB,CR: 5, color: UIColor.white, brwidth: 1.0,Shadow: 0, ShadowRadius: 0.0)
        NotificationCenter.default.addObserver(self, selector: #selector(func_linkedIn_SignIn), name: NSNotification.Name .init(rawValue: "linkedInProfile_login"), object: nil)
    }
    
    //    Marks: IBAction
    @IBAction func RegisterBtn(_ sender: Any) {
        push_VC("RegisterViewController", storyboard: "Main")
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if !func_validation() {
            return
        }

        login_by_mail(self.EmailTxtField.text!.remove_white_string(), self.PasswordTxtfld.text!.remove_white_string())
    }
    
    
    
    @IBAction func LInkEdinBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.is_login = true
        self.present(vc, animated: true, completion: nil)
    }
    
    func func_validation() -> Bool {
        var is_valid = true
        
        if EmailTxtField.text!.isEmpty {
            is_valid = false
            func_ShowHud_Error(with: "Enter your E-mail")
        } else if !func_IsValidEmail(testStr: EmailTxtField.text!) {
            is_valid = false
            func_ShowHud_Error(with: "Enter valid E-mail")
        } else if PasswordTxtfld.text!.isEmpty {
            is_valid = false
            func_ShowHud_Error(with: "Enter your password")
        } else if PasswordTxtfld.text!.count < 6 {
            is_valid = false
            func_ShowHud_Error(with: "Your password min length 6")
        } else {
            is_valid = true
        }
        return is_valid
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let EMAIL_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_@.-"
        
          if textField == EmailTxtField {
            if EmailTxtField.text!.count > 30 {
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

extension LoginViewController  : GIDSignInDelegate ,GIDSignInUIDelegate {
    @IBAction func GoogleBTn(_ sender:UIButton) {
//        //func_ShowHud()
        GIDSignIn.sharedInstance()!.signOut()
        GIDSignIn.sharedInstance()!.disconnect()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
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
    
    @objc func func_linkedIn_SignIn() {
        if let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken") {
            let targetURLString =  "https://api.linkedin.com/v2/me?projection=(id,firstName,email-address,lastName,profilePicture(displayImage~:playableStreams))"
            
            let request = NSMutableURLRequest(url: NSURL(string: targetURLString)! as URL)
            request.httpMethod = "GET"
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
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
}

extension LoginViewController {
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
                    self.func_ShowHud()
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



extension LoginViewController{
    //    MARK: API FUNCTIONS

    func login_by_mail(_ email: String,_ password:String) {
        func_ShowHud()
        self.view.endEditing(true)
        let param = ["email":email,"password":password] as [String:Any]
        
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
                    print("login successful")
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
