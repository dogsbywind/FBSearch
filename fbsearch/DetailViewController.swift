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
import FacebookShare
import FBSDKCoreKit
import EasyToast

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var albumTable: UITableView!
    
    @IBOutlet weak var postTable: UITableView!

    @IBOutlet weak var albumNotFound: UILabel!
    
    @IBOutlet weak var postNotFound: UILabel!
    
    
    var albumUnits = [AlbumUnit]()
    var postUnits = [PostUnit]()
    var hiddenStatus = Array(repeating: true, count: 10)
    
    func loadAP(){
        SwiftSpinner.show(delay: 0.1, title: "Loading Data...")
        let searchQuery = "https://dogs-by-wind.appspot.com/fbsearch.php?detail="+Passengers.union.searchid
        Alamofire.request(searchQuery).responseJSON { response in
            if let JSONa = response.result.value {
                let js = JSON(JSONa)
                var profilePhoto:UIImage = UIImage()
                if let photoUrl = URL(string:Passengers.union.favoDict["profileUrl"]!){
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
                if self.albumTable != nil {
                    if self.albumUnits.count > 0 {
                        self.albumTable.reloadData()
                        self.albumTable.isHidden = false
                        self.albumNotFound.isHidden = true
                        self.albumTable.estimatedRowHeight = 66
                        self.albumTable.rowHeight = UITableViewAutomaticDimension
                    }
                    else {
                        self.albumTable.isHidden = true
                        self.albumNotFound.isHidden = false
                    }
                }
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
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAP()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === albumTable {
            return albumUnits.count
        }
        else {
            return postUnits.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->       UITableViewCell{
        var returnCell:UITableViewCell
        if tableView === albumTable {
            let cellIdentifier = "albumCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlbumTableViewCell  else {
                fatalError("failed.")
            }
            let albumUnit = albumUnits[indexPath.row]
            cell.albumTitle.text = albumUnit.title
            if hiddenStatus[2*indexPath.row] {
                cell.pic1.isHidden = true
                cell.pic1.image = nil
                cell.pic1W.constant = 1
                cell.pic1H.constant = 1
            }
            else {
                cell.pic1.isHidden = false
                cell.pic1.image = albumUnit.pic1
                if albumUnit.pic1 != nil {
                    cell.pic1W.constant = 2*(albumUnit.pic1?.size.width)!
                    if cell.pic1W.constant > 330{
                        cell.pic1W.constant = 330
                    }
                    cell.pic1H.constant = cell.pic1W.constant*(albumUnit.pic1?.size.height)!/(albumUnit.pic1?.size.width)!
                }
            }
            if hiddenStatus[2*indexPath.row+1] {
                cell.pic2.isHidden = true
                cell.pic2.image = nil
                cell.pic2W.constant = 1
                cell.pic2H.constant = 1
            }
            else {
                cell.pic2.isHidden = false
                cell.pic2.image = albumUnit.pic2
                if albumUnit.pic2 != nil {
                    cell.pic2W.constant = 2*(albumUnit.pic2?.size.width)!
                    if cell.pic2W.constant > 330{
                        cell.pic2W.constant = 330
                    }
                    cell.pic2H.constant = cell.pic2W.constant*(albumUnit.pic2?.size.height)!/(albumUnit.pic2?.size.width)!
                }
            }
            returnCell = cell
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
            returnCell = cell
            
            }
        return returnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //if indexPath.row<resultsLoaded.count{
            if tableView === albumTable{
                //print (cell.albumTitle.text)
                if indexPath.row < albumUnits.count{
                    let albumUnit = albumUnits[indexPath.row]
                    if albumUnit.pic1 != nil {
                        hiddenStatus [2*indexPath.row] = !hiddenStatus [2*indexPath.row]
                    }
                    if albumUnit.pic2 != nil {
                        hiddenStatus [2*indexPath.row+1] = !hiddenStatus [2*indexPath.row+1]
                    }
                    var tmp = 99
                    for i in [0,1,2,3,4] {
                        if (i != indexPath.row && !hiddenStatus[2*i]){
                            hiddenStatus[2*i] = true
                            hiddenStatus[2*i+1] = true
                            tmp = i
                        }
                    }
                    tableView.beginUpdates()
                    tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    if tmp < 5{
                        let anotherPath = IndexPath(row: tmp, section: 0)
                        tableView.reloadRows(at: [anotherPath], with: UITableViewRowAnimation.automatic)
                    }
                    tableView.endUpdates()
                }
            }
       // }
    }
    
    func addToFavorite(dict:[String:String]){
        let defaults = UserDefaults.standard
        if defaults.object(forKey: dict["id"]!) == nil{
            defaults.set(dict,forKey:dict["id"]!)
            self.view.showToast("Added to favorites!", position: .bottom, popTime: 3, dismissOnTap: true)
        }
        else {
            defaults.removeObject(forKey: dict["id"]!)
            self.view.showToast("Removed from favorites!", position: .bottom, popTime: 3, dismissOnTap: true)
        }
    }
    
    func shareOnFB(){
        let sharedContent = LinkShareContent(url:URL(string:"https://dogs-by-wind.appspot.com/fbsearch.html")!, title:Passengers.union.favoDict["name"],description:"FB Share for CSCI 571", imageURL:URL(string:Passengers.union.favoDict["profileUrl"]!))
        let dialog = ShareDialog(content:sharedContent)
        //print("SDK version \(FBSDKSettings.sdkVersion())")
        dialog.mode = .feedWeb
        dialog.presentingViewController = self
        dialog.failsOnInvalidData = true
        dialog.completion = { result in
            //print(result)
            switch result{
            case .success:
                self.view.showToast("Shared!", position: .bottom, popTime: 3, dismissOnTap: true)
            case .failed:
                self.view.showToast("Failed!", position: .bottom, popTime: 3, dismissOnTap: true)
            case .cancelled:
                self.view.showToast("Cancelled!", position: .bottom, popTime: 3, dismissOnTap: true)
            /// The operation failed.
            //case failed(Error):
            /// The operation was cancelled by the user.
            //case cancelled:
            //Handle results
            }
            //print(result)
        }
        do {
            try dialog.show()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func showPopUp(){
        let popUp = UIAlertController(title:nil, message:"Menu",preferredStyle:.actionSheet)
        
        let addFavo = UIAlertAction(title:"Add to favorites", style:.default,handler:{
            (alert: UIAlertAction!)-> Void in
            self.addToFavorite(dict: Passengers.union.favoDict)
        })
        let removeFavo = UIAlertAction(title:"Remove from favorites", style:.default,handler:{
            (alert: UIAlertAction!)-> Void in
            self.addToFavorite(dict: Passengers.union.favoDict)
        })
        
        let shareAction = UIAlertAction(title:"Share", style:.default,handler:{
            (alert: UIAlertAction!)-> Void in
            self.shareOnFB()
        })
        
        let cancelAction = UIAlertAction(title:"Cancel",style:.cancel,handler:{
            (alert:UIAlertAction!)->Void in
        })
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Passengers.union.searchid) == nil
        {
            popUp.addAction(addFavo)
        }
        else{
            popUp.addAction(removeFavo)
        }
        popUp.addAction(shareAction)
        popUp.addAction(cancelAction)
        
        self.present(popUp, animated: true,completion: nil)
    }

    
    @IBAction func popUpMenu1(_ sender: Any) {
        showPopUp()
       // addToFavorite(dict: Passengers.union.favoDict)
    }
    @IBAction func popUpMenu2(_ sender: Any) {
        showPopUp()
        // addToFavorite(dict: Passengers.union.favoDict)
    }

}
