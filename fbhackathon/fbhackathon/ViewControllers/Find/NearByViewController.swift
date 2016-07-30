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
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let detail = DetailViewController(name: "golf")
        self.navigationController?.pushViewController(detail, animated: true)
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
        self.randomData(location)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? UpAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func findPressed() {
        self.tabBarController?.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomData(location: CLLocation) {
        for i:Int in 0...50 {
            let distance = Double(arc4random_uniform(UInt32(currentDistance) + 200))/6372797.6
            let angel = Double(arc4random())
            
            let lat1 = location.coordinate.latitude * M_PI / 180
            let lon1 = location.coordinate.longitude * M_PI / 180
            
            let lat2 = asin(sin(lat1) * cos(distance) + cos(lat1) * sin(distance) * cos(angel))
            let lon2 = lon1 + atan2(sin(angel) * sin(distance) * cos(lat1), cos(distance) - sin(lat1) * sin(lat2))
            
            let coordinate = CLLocationCoordinate2D(latitude: lat2 * 180 / M_PI, longitude: lon2 * 180 / M_PI)
//            print("\(lat2) - \(lon2)")
            let person = Common.shareInstance.userImage()
            let pin = UpAnnotation(title: person.skill,
                                  locationName: person.name,
                                  discipline: "Sculpture",
                                  coordinate: coordinate)
            
            self.map.addAnnotation(pin)
        }
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
