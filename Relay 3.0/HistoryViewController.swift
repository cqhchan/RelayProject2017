//
//  HistoryViewController.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 9/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {


    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
