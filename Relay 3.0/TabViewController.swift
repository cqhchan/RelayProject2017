//
//  TabViewController.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 8/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    @IBOutlet weak var menu: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        let image = UIImage(named: "relay 3")
   
        self.navigationItem.titleView = UIImageView(image: image)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // create sidebar using SWRevealViewController function i borrowed of a library.
    func sideMenus() {
        
            menu.target = revealViewController();
            menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
            
            revealViewController().rearViewRevealWidth = 275
            
            
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
            let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
            
            tap.cancelsTouchesInView = false
            pan.cancelsTouchesInView = false
            swipe.cancelsTouchesInView = false
            view.addGestureRecognizer(swipe)
            view.addGestureRecognizer(tap)
            view.addGestureRecognizer(pan)
            
            
        }
 
    
   

    
    
            /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
