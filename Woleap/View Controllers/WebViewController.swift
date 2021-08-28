//  WebViewController.swift
//  Woleap

//  Created by ayush pathak on 17/07/19.
//  Copyright © 2019 appentus. All rights reserved.



import Foundation
import UIKit



let linkedInKey = "8124w5cqqt2tq9"
let linkedInSecret = "jiwLCWqc88qJT9NQ"
let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"

class WebViewController: UIViewController, UIWebViewDelegate {
    // MARK: IBOutlet Properties
    @IBOutlet weak var webView: UIWebView!
    
    var is_loading_again = false
    
    var is_login = false
    
    // MARK: Constants
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        startAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBAction Function
    @IBAction func dismiss(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Custom Functions
    func startAuthorization() {
        // Specify the response type which should always be "code".
        let responseType = "code"
        
        // Set the redirect URL. Adding the percent escape characthers is necessary.
        let redirectURL = "https://com.appentus.linkedin.oauth/oauth".addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        // Create a random string based on the time intervale (it will be in the form linkedin12345679).
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        
        // Set preferred scope.
        let scope = "r_emailaddress,r_liteprofile,w_member_social"
        
        // Create the authorization URL string.
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(linkedInKey)&"
        authorizationURL += "redirect_uri=\(redirectURL!)&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        
        print(authorizationURL)
        
        // Create a URL request and load it in the web view.
        let request = URLRequest (url: URL(string: authorizationURL)!)
        webView.loadRequest(request)
    }
    
    func requestForAccessToken(authorizationCode: String) {
        let grantType = "authorization_code"
        
        let redirectURL = "https://com.appentus.linkedin.oauth/oauth".addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        // Set the POST parameters.
        var postParams = "grant_type=\(grantType)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(redirectURL!)&"
        postParams += "client_id=\(linkedInKey)&"
        postParams += "client_secret=\(linkedInSecret)"
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.data(using: .utf8 )
        // Initialize a mutable URL request object using the access token endpoint URL string.
        var request = URLRequest (url: URL(string: accessTokenEndPoint)!)
        
        // Indicate that we're about to make a POST request.
        request.httpMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.httpBody = postData
        
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        
        // Initialize a NSURLSession object.
        let session = URLSession(configuration: .default)
        
        // Make the request.
        let task:URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            // Get the HTTP status code of the request.
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            if statusCode == 200 {
                // Convert the received JSON data into a dictionary.
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(dataDictionary)
                    
                    let accessToken = dataDictionary["access_token"] as! String
                    
                    UserDefaults.standard.set(accessToken, forKey: "LIAccessToken")
                    UserDefaults.standard.synchronize()

                    if self.is_login{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"linkedInProfile_login"), object: nil)
                    }else{
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"linkedInProfile_regis"), object: nil)
                    }

                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        }
        
        task.resume()
    }
    
    // MARK: UIWebViewDelegate Functions
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("start loading")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        is_loading_again = true
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
            let url = request.url!
            print(url)
            
            if url.host == "com.appentus.linkedin.oauth" {
//                if is_loading_again {
                    if url.absoluteString.range(of: "code") != nil {
                        // Extract the authorization code.
                        let urlParts = url.absoluteString.components(separatedBy: "?")
                        let code = urlParts[1].components(separatedBy:"=")[1]
                        
                        requestForAccessToken(authorizationCode: code)
                    }
//                }
            }
        return true
    }
    
    
}
