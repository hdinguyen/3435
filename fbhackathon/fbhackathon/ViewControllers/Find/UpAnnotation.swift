//
//  UpAnnotation.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import MapKit

class UpAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var contentsubtitle: String {
        return subtitle!
    }
}
