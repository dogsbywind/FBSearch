//
//  ResultTabBarController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/20/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class ResultTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unwindToResultTabBar(segue: UIStoryboardSegue) {
        //nothing goes here
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
