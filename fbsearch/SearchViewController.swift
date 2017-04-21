//
//  SearchViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/18/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        Passengers.union.keyword = (searchText.text?.replacingOccurrences(of: " ", with: "%20"))!
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        if(searchText.text=="") {
            return//TODO add toast
        }
        performSegue(withIdentifier: "searchToResult", sender: self)

    }
    @IBAction func clearClicked(_ sender: Any) {
        searchText.text=""
    }
}
