//
//  AboutmeViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/24/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class AboutmeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        initSideMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSideMenu(){
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
    }


}
