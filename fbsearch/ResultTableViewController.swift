//
//  ResultTableViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/19/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ResultTableViewController: UITableViewController {

    var resultUnits = [ResultUnit]()
    
    private func loadResults(){
        Alamofire.request("https://dogs-by-wind.appspot.com/fbsearch.php?keyword=usc&type=user").responseJSON { response in
            
            if let JSONa = response.result.value {
                let js = JSON(JSONa)
                var profilePhoto:UIImage = UIImage()
                for (_,subJson):(String, JSON) in js["data"] {
                    if let photoUrl = URL(string:subJson["picture"]["data"]["url"].string!){
                        if let data = NSData(contentsOf: photoUrl){
                            profilePhoto = UIImage(data: data as Data)!
                        }
                    }
                    guard let resultUnit = ResultUnit(name:subJson["name"].string!,photo: profilePhoto ,favo:true,id:subJson["id"].string!)
                        else {
                            fatalError("unable to create")
                    }
                    self.resultUnits += [resultUnit]
                }
                print(js["data"])
                self.tableView.reloadData()
                //print("JSON: \(JSONa)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadResults()
        print("a")
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //  return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultUnits.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ResultTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResultTableViewCell  else {
            fatalError("failed.")
        }
        let resultUnit = resultUnits[indexPath.row]
        cell.nameLabel.text = resultUnit.name
        cell.profilePhoto.image = resultUnit.photo
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
