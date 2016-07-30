//
//  MeViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class MeViewController: UITabBarController {

    let topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.title = "Me"
        
        let program = CourseViewController(screen: COURSE_SCREEN.PROGRAM)
        let offer = CourseViewController(screen: COURSE_SCREEN.OFFER)
        let course = CourseViewController(screen: COURSE_SCREEN.COURSE)
        let profile = ProfileViewController()
        
        self.viewControllers = [UINavigationController(rootViewController: program), UINavigationController(rootViewController: offer), UINavigationController(rootViewController: course), UINavigationController(rootViewController: profile)]
        
        self.tabBar.hidden = true
        topView.backgroundColor = UIColor.colorWithHexString("CFD2DA")
        self.view.addSubview(topView)
        
        let segment = UISegmentedControl(items: ["Program","Offer","Course","Profile"])
        segment.center = CGPoint(x: topView.bounds.width/2, y: topView.bounds.height/2 + 10)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(MeViewController.segmentChanged(_:)), forControlEvents: .ValueChanged)
        topView.addSubview(segment)
    }
    
    func segmentChanged(sender:UISegmentedControl) {
        self.selectedIndex = sender.selectedSegmentIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
