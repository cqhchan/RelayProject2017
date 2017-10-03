//
//  Login.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 8/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class Login: UIViewController, UITextFieldDelegate{


/* this whole portion has been removed as the server is currently down. to test simply create local repo to store password and user info if you wish to

*/
    @IBOutlet var userEmailTextField: UITextField!
    @IBOutlet var userPasswordTextField: UITextField!
    @IBOutlet var loginbutton: UIButton!;
    let login_url = "http://35.186.159.173/login.php"
    let checksession_url = "http://www.kaleidosblog.com/tutorial/login/api/CheckSession"
    var login_session:String = ""
    
    override func viewDidLoad() {
  
       super.viewDidLoad()
          self.hideKeyboardWhenTappedAround()
        
        
        
        
         userEmailTextField.delegate = self
         userPasswordTextField.delegate = self
        
        let preference = UserDefaults.standard
        if preference.object(forKey: "session") != nil
        
        {
            login_session = preference.object(forKey: "session") as! String
            check_session()
        }
        else{
            LoginToDo()
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: Any) {
      

            login_now(username:userEmailTextField.text!, password: userPasswordTextField.text!)
        
        
    }
    
    // send infomation to server
    
    func login_now(username:String, password:String)
    {
        let post_data: NSDictionary = NSMutableDictionary()
        
       
        post_data.setValue(username, forKey: "username")
        post_data.setValue(password, forKey: "password")
        
        let url:URL = URL(string: login_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        
        
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        //Check for response
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
          
            
           
            var json: NSDictionary
        
        
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])as! NSDictionary
            }
            catch
            {
                      self.displayalert(userMessage: "Username or Password Incorrect")
                return
            }
            
    
        
            if let data_block = json["data"] as? NSDictionary{
          
                
            if let session_data = data_block["session"] as? String
            {
                print(session_data)
                    self.login_session = session_data
                
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async(execute: self.LoginDone)
                }
            }
        
            
            
        })
        
        task.resume()
        
        
    }
    
    
    
    func LoginDone()
    {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let MainController = storyboard.instantiateViewController(withIdentifier: "MainController")as!SWRevealViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = MainController
    }
    
    func LoginToDo()
    {
        userEmailTextField.isEnabled = true
        userPasswordTextField.isEnabled = true
        
        loginbutton.isEnabled = true
        
        
        loginbutton.setTitle("Login", for: .normal)
    }
    
        // check session, if user is still logged in so do not have to log in everytime
       func check_session()
    {
        let post_data: NSDictionary = NSMutableDictionary()
        
        
        post_data.setValue(login_session, forKey: "session")
        
        let url:URL = URL(string: checksession_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        
        
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            
            
            let json: Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
               

                
                return
            }
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            if let response_code = server_response["response_code"] as? Int
            {
                if(response_code == 200)
                {
                    DispatchQueue.main.async(execute: self.LoginDone)
                    
                    
                }
                else
                {
                    DispatchQueue.main.async(execute: self.LoginToDo)
                }
            }
            
            
            
        })
        
        task.resume()
        
        
    }
 

   

}

