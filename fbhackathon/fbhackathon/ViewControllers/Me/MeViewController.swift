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
    let editButton = UIButton(type: .Custom)
    
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
        
        editButton.frame = CGRect(x: self.view.frame.size.width - 40 , y: topView.frame.size.height - 40, width: 30, height: 30)
        editButton.setTitle("+", forState: .Normal)
        editButton.setTitleColor(UIColor.colorWithHexString("007ffa"), forState: .Normal)
        editButton.addTarget(self, action: #selector(MeViewController.editPressed), forControlEvents: .TouchUpInside)
        topView.addSubview(editButton)
        
        editButton.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.topView.hidden = false
    }
    
    func editPressed() {
        let profile = (self.viewControllers![3] as! UINavigationController).viewControllers[0] as! ProfileViewController
        profile.showPickerSkill()
        self.topView.hidden = true
    }
    
    func segmentChanged(sender:UISegmentedControl) {
        self.selectedIndex = sender.selectedSegmentIndex
        if self.selectedIndex != 3 {
            editButton.hidden = true
        } else {
            editButton.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
