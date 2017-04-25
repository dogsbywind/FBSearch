//
//  SearchViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/18/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit
import EasyToast

class SearchViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSideMenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Passengers.union.keyword = (searchText.text?.replacingOccurrences(of: " ", with: "%20"))!
    }
    
    func initSideMenu(){
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        if(searchText.text=="") {
            self.view.showToast("Enter a valid query!", position: .bottom, popTime: 3, dismissOnTap: true)
            return
        }
        performSegue(withIdentifier: "searchToResult", sender: self)

    }
    @IBAction func clearClicked(_ sender: Any) {
        searchText.text=""
    }
}
