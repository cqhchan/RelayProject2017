//
//  TableViewController.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 9/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let dataArray = ["Profile", "Payments", "History", "Logout"];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!TableViewCell

        // Configure the cell...
        cell.MenuNames?.text = dataArray[indexPath.row];
        return cell
    }
    
    // create sidebar table and registers them to open differnt controllers when clicked
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell:TableViewCell = tableView.cellForRow(at: indexPath) as! TableViewCell
    
        if cell.MenuNames.text! == "Profile"
        {
            
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let profileViewcontroller = storyboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
            
         present(profileViewcontroller, animated: false, completion: nil)
        }
        if cell.MenuNames.text! == "Payments"
        {
         
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let paymentsViewcontroller = storyboard.instantiateViewController(withIdentifier: "Payments") as! PaymentsViewController
            
        present(paymentsViewcontroller, animated: false, completion: nil)

        }
        if cell.MenuNames.text! == "History"
        {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let HistoryViewcontroller = storyboard.instantiateViewController(withIdentifier: "History") as! HistoryViewController
        present(HistoryViewcontroller, animated: false, completion: nil)
            
    }
    if cell.MenuNames.text! == "Logout"
    {
        displaylogoutalert(userMessage: "Are you sure you want to log out?")
        

        
    }

    }
    
    func displaylogoutalert (userMessage:String)
        
    {
        //create alert message
        let myAlert = UIAlertController(title: "Logout", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        // create button
        myAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in self.logout()}))
        myAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action) in myAlert.dismiss(animated: true, completion: nil)}))
        
        
        self.present(myAlert, animated: true, completion: nil)
        
        
    }
    // logout function
    func logout()
    {
        
        
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: "session")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        
        let loginViewcontroller = storyboard.instantiateViewController(withIdentifier: "login") as! Login
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewcontroller
    
    
    return;
    }
}
