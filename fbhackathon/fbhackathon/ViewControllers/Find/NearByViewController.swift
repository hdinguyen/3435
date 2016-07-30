//
//  NearByViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import MapKit

class NearByViewController: BaseViewController, MKMapViewDelegate {

    let searchBar = UISearchBar(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let map = MKMapView(frame: CGRectZero)
        map.delegate = self
        map.showsUserLocation = true
        
        self.view = map
        self.navigationItem.titleView = searchBar
        let find:UIBarButtonItem = UIBarButtonItem(title: "Find", style: .Done, target: self, action: #selector(NearByViewController.findPressed))
        self.navigationItem.rightBarButtonItem = find
        // Do any additional setup after loading the view.
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        searchBar.resignFirstResponder()
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
