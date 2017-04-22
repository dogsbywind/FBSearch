//
//  ResultViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/17/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit
import SwiftSpinner
import Alamofire
import SwiftyJSON

class ResultViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userTable: UITableView!
    @IBOutlet weak var pageTable: UITableView!
    @IBOutlet weak var eventTable: UITableView!
    @IBOutlet weak var placeTable: UITableView!
    @IBOutlet weak var groupTable: UITableView!
    var resultUnits = [ResultUnit]()
    
    var resultsLoaded = [ResultUnit]()
    
    var currentPage:Int = 0
    
    var totalPages:Int = 0
    
    func loadResultUnit(index:Int){
        resultsLoaded = [ResultUnit]()
        for sub in (index*10)...(index*10+9){
            if sub < resultUnits.count {
                resultsLoaded   +=  [resultUnits[sub]]
            }
        }
    }
    
    func initSideMenu(menuButton:UIBarButtonItem){
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = 275
    }
    
    func loadResults(table:UITableView,searchQuery:String){
        SwiftSpinner.show(delay: 0.1, title: "Loading Data...")
        Alamofire.request(searchQuery).responseJSON { response in
            if let JSONa = response.result.value {
                let js = JSON(JSONa)
                var profilePhoto:UIImage = UIImage()
                for (_,subJson):(String, JSON) in js["data"] {
                    if let photoUrl = URL(string:subJson["picture"]["data"]["url"].string!){
                        if let data = NSData(contentsOf: photoUrl){
                            profilePhoto = UIImage(data: data as Data)!
                        }
                    }
                    guard let resultUnit = ResultUnit(name:subJson["name"].string!,photo: profilePhoto ,favo:true, id: subJson["id"].string!)
                        else {
                            fatalError("unable to create")
                    }
                    resultUnit.url = subJson["picture"]["data"]["url"].string!
                    self.resultUnits += [resultUnit]
                }
                self.totalPages = self.resultUnits.count/10
                self.loadResultUnit(index: 0)
                table.reloadData()
                Passengers.union.next.isEnabled=(self.totalPages>0)
                Passengers.union.prev.isEnabled=false
                SwiftSpinner.hide()
                print("JSON: \(JSONa)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsLoaded.count
        // return the number of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->       UITableViewCell{
        let cellIdentifier = "ResultTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ResultTableViewCell  else {
            fatalError("failed.")
        }
        let resultUnit = resultsLoaded[indexPath.row]
        let defaults = UserDefaults.standard
        //can come up with a better idea, only reload the row that might be modified
        //but to save time...
        if defaults.dictionary(forKey: resultUnit.id) != nil{
            cell.favoStar.image = #imageLiteral(resourceName: "filled.png")
        }
        else{
            cell.favoStar.image = #imageLiteral(resourceName: "empty.png")
        }
        cell.nameLabel.text = resultUnit.name
        cell.profilePhoto.image = resultUnit.photo
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
        // create your cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if indexPath.row<resultsLoaded.count{
            Passengers.union.searchid = resultsLoaded[indexPath.row].id
            Passengers.union.favoDict["name"] = resultsLoaded[indexPath.row].name
            Passengers.union.favoDict["id"] = resultsLoaded[indexPath.row].id
            Passengers.union.favoDict["profileUrl"] = resultsLoaded[indexPath.row].url
            var type = String()
            switch tableView{
            case userTable :
                type = "user"
                break
            case pageTable:
                type = "page"
                break
            case eventTable:
                type = "event"
                break
            case placeTable:
                type = "place"
                break
            case groupTable:
                type = "group"
                break
            default:
                break
            }
            Passengers.union.favoDict["type"] = type
            performSegue(withIdentifier: "toDetail", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadResults()
        /*let url = URL(string:"https://dogs-by-wind.appspot.com/fbsearch.php?keyword=usc&type=user")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
        
        task.resume()*/
       /* Alamofire.request("https://dogs-by-wind.appspot.com/fbsearch.php?keyword=usc&type=user").responseJSON { response in

            if let JSONa = response.result.value {
                let js = JSON(JSONa)
                for (_,subJson):(String, JSON) in js["data"] {
                    print(subJson["id"])
                }
                print(js["data"])
                
                //print("JSON: \(JSONa)")
            }
        }*/
       // SwiftSpinner.show(delay: 1.0, title: "Connecting...", animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

