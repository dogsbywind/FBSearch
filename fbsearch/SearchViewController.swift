//
//  SearchViewController.swift
//  fbsearch
//
//  Created by Jibiao Shen on 4/18/17.
//  Copyright © 2017 Jibiao Shen. All rights reserved.
//

import UIKit
import EasyToast
import CoreLocation

class SearchViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchText: UITextField!
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        Passengers.union.locStr = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        initSideMenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
