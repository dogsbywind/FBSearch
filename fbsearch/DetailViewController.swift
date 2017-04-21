//
//  DetailViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/20/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit
import SwiftSpinner
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var albumTable: UITableView!
    
    @IBOutlet weak var postTable: UITableView!

    @IBOutlet weak var albumNotFound: UILabel!
    
    @IBOutlet weak var postNotFound: UILabel!
    
    
    var albumUnits = [AlbumUnit]()
    var postUnits = [PostUnit]()
    
    func loadAP(){
        SwiftSpinner.show(delay: 0.1, title: "Loading Data...")
        let searchQuery = "https://dogs-by-wind.appspot.com/fbsearch.php?detail="+Passengers.union.searchid
        Alamofire.request(searchQuery).responseJSON { response in
            if let JSONa = response.result.value {
                let js = JSON(JSONa)
                var profilePhoto:UIImage = UIImage()
                if let photoUrl = URL(string:js["picture"]["data"]["url"].string!){
                    if let data = NSData(contentsOf: photoUrl){
                        profilePhoto = UIImage(data: data as Data)!
                    }
                }
                for (_,albumJson):(String, JSON) in js["albums"]["data"] {
                    var pic1:UIImage? = nil
                    var pic2:UIImage? = nil
                    var i:Int = 0;
                    for (_,picJson):(String, JSON) in albumJson["photos"]["data"]{
                        if let picUrl = URL(string:picJson["picture"].string!){
                            if let picdata = NSData(contentsOf: picUrl){
                                if i == 0{
                                    pic1 = UIImage(data:picdata as Data)!
                                }
                                else {
                                    pic2 = UIImage(data:picdata as Data)!
                                }
                            }
                        }
                        i += 1
                    }
                    guard let albumUnit = AlbumUnit(title:albumJson["name"].string!,pic1:pic1,pic2:pic2)
                        else {
                            fatalError("unable to create")
                    }
                    self.albumUnits += [albumUnit]
                }
                for(_,postJson):(String, JSON) in js["posts"]["data"]{
                    let message = postJson["message"].string
                    var timeStamp = postJson["created_time"].string
                    if timeStamp != nil{
                        timeStamp = timeStamp?.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "+0000", with: "")
                    }
                    let postUnit = PostUnit()
                    postUnit.message = message
                    postUnit.timeStamp = timeStamp
                    postUnit.profile = profilePhoto
                    self.postUnits += [postUnit]
                }
                print("foo")
                //self.albumTable.reloadData()
                if self.postTable != nil {
                    if self.postUnits.count > 0 {
                        self.postTable.reloadData()
                        self.postTable.isHidden = false
                        self.postNotFound.isHidden = true
                        self.postTable.estimatedRowHeight = 66
                        self.postTable.rowHeight = UITableViewAutomaticDimension
                    }
                    else{
                        self.postTable.isHidden = true
                        self.postNotFound.isHidden = false
                    }
                }
                SwiftSpinner.hide()
                print("JSON: \(JSONa)")
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAP()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === albumTable {
            return albumUnits.count
        }
        else {
            return postUnits.count
        }
        // return the number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->       UITableViewCell{
        if tableView === albumTable{
           /* let cellIdentifier = "ResultTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResultTableViewCell  else {
                fatalError("failed.")
            }
            //let resultUnit = resultsLoaded[indexPath.row]
            cell.nameLabel.text = resultUnit.name
            cell.profilePhoto.image = resultUnit.photo*/
        }
        else{
            let cellIdentifier = "postCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableViewCell else{
                fatalError("Failed")
            }
            let postUnit = postUnits[indexPath.row]
            cell.profile.image = postUnit.profile
            cell.message.text = postUnit.message
            cell.timeStamp.text = postUnit.timeStamp
            return cell
        }
 
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return (tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath) as? PostTableViewCell)!
        // create your cells
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
