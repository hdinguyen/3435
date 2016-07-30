//
//  ProfileViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class profileInfo {
    var key:String = ""
    var value:String = ""
    
    init(key:String?, value:String?) {
        if key != nil {
            self.key = key!
        }
        if value != nil {
            self.value = value!
        }
    }
    
    func getContent()->String {
        return key + ": " + value
    }
}

class ProfileViewController: BaseViewController , UITableViewDelegate, UITableViewDataSource {

    var dataSource = [profileInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(ProfileImageTableViewCell.self, forCellReuseIdentifier: "imageProfile")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        dataSource.append(profileInfo(key: nil, value: nil))
        dataSource.append(profileInfo(key: "Name", value: "Jennifer Lu"))
        dataSource.append(profileInfo(key: "Email", value: "jen.lu@gmail.com"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("imageProfile", forIndexPath: indexPath) as! ProfileImageTableViewCell
            cell.selectionStyle = .None
            cell.loadCell("http://science-all.com/images/wallpapers/profile-pictures/profile-pictures-14.jpg", size: CGSize(width: tableView.frame.width, height: 200))
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.textLabel?.text = dataSource[indexPath.row].getContent()
        return cell
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
