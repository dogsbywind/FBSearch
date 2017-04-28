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
        /*Alamofire.request("https://dogs-by-wind.appspot.com/fbsearch.php?keyword=usc&type=user").responseJSON { response in
            
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
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadResults()
        print("a")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        return cell
    }


}
