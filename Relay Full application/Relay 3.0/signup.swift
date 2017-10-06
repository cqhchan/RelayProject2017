//
//  signup.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 8/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class signup: UIViewController, UITextFieldDelegate {
    /* this whole portion has been removed as the server is currently down. to test simply create local repo to store password and user info if you wish to
     
     */
    


    @IBOutlet var fullnametextfield: UITextField!
    @IBOutlet var datetextfield: UITextField!
    @IBOutlet var useremailtextfield: UITextField!
    @IBOutlet var userpasswordtextfield: UITextField!
    @IBOutlet var userconfirmpasswordtextfield: UITextField!
    @IBOutlet var phonenumbertextfield: UITextField!
    let signup_url = "http://35.186.159.173/register.php"
    //let detail : String = "relay00001bizcanteen"
    let date = Date()
    let format = DateFormatter()
    
   

    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
          self.hideKeyboardWhenTappedAround()
      
        datetextfield.delegate = self
        useremailtextfield.delegate = self
        userpasswordtextfield.delegate = self
        phonenumbertextfield.delegate = self
        userconfirmpasswordtextfield.delegate = self
        fullnametextfield.delegate = self
    
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func datefieldedit(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(signup.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }


    // get details from input and ensure that infomation is of the right format
    @IBAction func create(_ sender: Any) {
       // let iden = detail.index((detail.startIndex)!, offsetBy: 5 )
      
        let useremail = useremailtextfield.text;
        let userpassword = userpasswordtextfield.text;
        let confirmuserpassword = userconfirmpasswordtextfield.text;
        let fullname = fullnametextfield.text;
        let dateofbirth = datetextfield.text;
        let phonenumber = phonenumbertextfield.text;
       if ((useremail?.isEmpty)! || (userpassword?.isEmpty)! || (confirmuserpassword?.isEmpty)! || (fullname?.isEmpty)! || (dateofbirth?.isEmpty)! || (phonenumber?.isEmpty)! )  {
           
        displayalert(userMessage: "Fill in all fields" );
            return;
        }

        
        if useremail?.range(of:"@") == nil{
            displayalert(userMessage: "Email is not Valid")
            return;
        }
        
        if (phonenumber?.characters.count != 8) {
            displayalert(userMessage: "Please key in a valid Singapore Number, ommitting the +65")
        }
        if dateofbirth?.characters.count != 10 {
                        displayalert(userMessage: "Date input is not Valid. Please enter in the Format DD/MM/YYYY")
            return
        }
            let dayindex = dateofbirth?.index((dateofbirth?.startIndex)!, offsetBy: 2 )
            let firstmonthindex = dateofbirth!.index((dateofbirth?.startIndex)!, offsetBy: 3 )
            let endmonthindex = dateofbirth!.index((dateofbirth?.startIndex)!, offsetBy: 5 )
            let yearindex = dateofbirth?.index((dateofbirth?.startIndex)!, offsetBy: 6 )
            let range = firstmonthindex..<endmonthindex
        guard let day = Int((dateofbirth?.substring(to: (dayindex)!))!), let month = Int((dateofbirth?.substring(with: range))!),let year = Int((dateofbirth?.substring(from: yearindex!))!)
        else {displayalert(userMessage: "Date input is not Valid. Please enter in the Format DD/MM/YYYY")
            return}
        
        

     
       format.dateFormat = "yyyy"
        let currentyear = Int(format.string(from: date))
   
        guard (day >= 1&&day <= 31&&month >= 1&&month <= 12) else {
           displayalert(userMessage: "Date input is not Valid. Please enter in the Format DD/MM/YYYY")
            
            return
        }
        guard year <= (currentyear!-19) else {
            displayalert(userMessage: "You must be 18 Years Old to use this App")
            
            return
        }


        
   
        let decimalCharacters = NSCharacterSet.decimalDigits
    
        let decimalRange = userpassword!.rangeOfCharacter(from: decimalCharacters, options: [], range: nil)
       

        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        let characterrange  = userpassword!.rangeOfCharacter(from: characterset.inverted)
        
        let upperset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*[]|{}:';,./<>?\"()\\")
        let upperrange  = userpassword!.rangeOfCharacter(from: upperset.inverted)
        
        if ((userpassword!.characters.count) < 7||(userpassword!.characters.count) > 21){
            displayalert(userMessage: "Your Password must be between 8-20 Characters, contain a number and a special character")
            return;
        }
        
        if (upperrange == nil) {
            displayalert(userMessage: "Your Password must be between 8-20 Characters, contain a number and a special character")
            return;
        }
            
        if (decimalRange == nil) {
            displayalert(userMessage: "Your Password must be between 8-20 Characters, contain a number and a special character")
            return;
        }
        if characterrange == nil {
            displayalert(userMessage: "Your Password must be between 8-20 Characters, contain a number and a special character")
            return;
        }
    
        
   
        
        

        
        
        if (userpassword != confirmuserpassword) {
            displayalert(userMessage: "Passwords do not match")
            return;
            

        }
        Signup_now(username: useremailtextfield.text!, name:fullnametextfield.text!, dateofbirth:datetextfield.text!,  phonenumber:phonenumbertextfield.text!, password:userpasswordtextfield.text!)
    }
    
    
    // send info to the server and mysql database( now dysfunctional)
    func Signup_now(username:String,name:String,dateofbirth:String, phonenumber:String, password:String)
    { print("1")
        let post_data: NSDictionary = NSMutableDictionary()
        print("2")
        
        post_data.setValue(username, forKey: "username")
        post_data.setValue(name, forKey: "name")
        post_data.setValue(dateofbirth, forKey: "dateofbirth")
        post_data.setValue(phonenumber, forKey: "phonenumber")
        post_data.setValue(password, forKey: "password")
        
        print("3")
        let url:URL = URL(string: signup_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        print("4")
        
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
            print("5")
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
       

            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
         
            
            
            print("6")
            
            var json: NSDictionary
            
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])as! NSDictionary
            }
            catch
            {
                return
            }
            
            
            print("7")
            
 
            if let data_block = json["data"] as? NSDictionary{
                
                
                if let session_data = data_block["session"] as? String
                {

                    print(session_data)

                    
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                                print("8")
                    DispatchQueue.main.async(execute: self.SignupDone)
                }}
            
        })
        
        task.resume()
        
        
    }


    func SignupDone () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    print("10")
        let loginvc = storyboard.instantiateViewController(withIdentifier: "login") as! Login
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginvc
        
    }

     
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // pick date function
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {

            
            if (month < 10) {datetextfield.text = "\(day)/0\(month)/\(year)"
            return}
            if (day<10){datetextfield.text = "0\(day)/\(month)/\(year)"
            return}
            datetextfield.text = "\(day)/\(month)/\(year)"
            return
        }
    }

 }
