//
//  GroupViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/19/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class GroupViewController: ResultViewController {

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    func loadButtons(){
        if currentPage == 0 {
            prevButton.isEnabled = false
        }else {
            prevButton.isEnabled = true
        }
        if currentPage == totalPages{
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initSideMenu(menuButton:menuButton)
        if Passengers.union.fromFavo{
            navTitle.title = "Favorites"
        }
        else {
            navTitle.title = "Search Results"
        }
        Passengers.union.next=nextButton
        Passengers.union.prev=prevButton
        if Passengers.union.fromFavo{
            //loadFromFavo(table: self.groupTable, type: "group")
        }
        else{
            let query:String = "https://dogs-by-wind.appspot.com/fbsearch.php?keyword="+Passengers.union.keyword+"&type=group"
            loadResults(table: self.groupTable,searchQuery: query)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if Passengers.union.fromFavo{
            loadFromFavo(table: self.groupTable, type: "group")
        }
        groupTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func prevClicked(_ sender: Any) {
        currentPage = currentPage - 1
        loadResultUnit(index: currentPage)
        groupTable.reloadData()
        loadButtons()
    }
    @IBAction func nextClicked(_ sender: Any) {
        currentPage = currentPage + 1
        loadResultUnit(index: currentPage)
        groupTable.reloadData()
        loadButtons()
    }
    
}
