//
//  SideTableViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/23/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class SideTableViewController: UITableViewController {
    @IBOutlet weak var home: UITableViewCell!

    @IBOutlet weak var aboutme: UITableViewCell!
    @IBOutlet weak var favorites: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: self)
        if segue.identifier == "goFavo" {
            Passengers.union.fromFavo = true
        }
        else {
            Passengers.union.fromFavo = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }
        return 1
    }



}
