//
//  PlaceViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/19/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit

class PlaceViewController: ResultViewController {

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
        let query:String = "https://dogs-by-wind.appspot.com/fbsearch.php?keyword="+Passengers.union.keyword+"&type=place"
        Passengers.union.next=nextButton
        Passengers.union.prev=prevButton
        loadResults(table: self.placeTable,searchQuery: query)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        placeTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevClicked(_ sender: Any) {
        currentPage = currentPage - 1
        loadResultUnit(index: currentPage)
        placeTable.reloadData()
        loadButtons()
    }
    @IBAction func nextClicked(_ sender: Any) {
        currentPage = currentPage + 1
        loadResultUnit(index: currentPage)
        placeTable.reloadData()
        loadButtons()
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
