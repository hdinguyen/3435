//
//  NearByViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearByViewController: BaseViewController, MKMapViewDelegate,  CLLocationManagerDelegate{

    let searchBar = UISearchBar(frame: CGRectZero)
    var locationManager:CLLocationManager?
    let map = MKMapView(frame: CGRectZero)
    var currentDistance:CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager?.requestWhenInUseAuthorization()
        } else {
            locationManager?.startUpdatingLocation()
        }
        
        map.delegate = self
        map.showsUserLocation = true
        
        self.view = map
        
        searchBar.inputAccessoryView = Common.shareInstance.createToolBar({ (data) in
            self.searchBar.resignFirstResponder()
        })
        self.navigationItem.titleView = searchBar
        
        let find:UIBarButtonItem = UIBarButtonItem(title: "List", style: .Done, target: self, action: #selector(NearByViewController.findPressed))
        self.navigationItem.leftBarButtonItem = find
        
        
        let distance:UIBarButtonItem = UIBarButtonItem(title: "Distance", style: .Done, target: self, action: #selector(NearByViewController.distance))
        self.navigationItem.rightBarButtonItem = distance
        
    }
    
    func distance() {
        let option = UIAlertController(title: "Distance", message: nil, preferredStyle: .ActionSheet)
        
        let action1k = UIAlertAction(title: "1 km", style: .Default) { (action) in
            self.currentDistance = 1000
            self.locationManager!.startUpdatingLocation()
        }
        
        let action5k = UIAlertAction(title: "5 km", style: .Default) { (action) in
            self.currentDistance = 5000
            self.locationManager!.startUpdatingLocation()
        }
        
        let action10k = UIAlertAction(title: "10 km", style: .Default) { (action) in
            self.currentDistance = 10000
            self.locationManager!.startUpdatingLocation()
        }
        
        option.addAction(action1k)
        option.addAction(action5k)
        option.addAction(action10k)
        self.presentViewController(option, animated: true, completion: nil)
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        } else {
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, currentDistance, currentDistance)
        map.setRegion(region, animated: true)
        manager.stopUpdatingLocation()
    }
    
    func findPressed() {
        self.tabBarController?.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
