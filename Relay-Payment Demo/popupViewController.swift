//
//  popupViewController.swift
//  PaymentDemo
//
//  Created by Chan Qing Hong on 26/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class popupViewController: UIViewController {
    
    var detail : String = ""
    var totalamount : String = ""
    
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBAction func closepopbup(_ sender: Any) {
        self.view.removeFromSuperview()
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("13")
        Name.text = detail
        Amount.text = totalamount

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
