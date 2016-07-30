//
//  ProfileViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

enum STATUS_SKILL:Int {
    case MINE = 0
    case LEARN = 1
    case WISH_TO_LEARN = 2
}

class profileSkill {
    var key:String = ""
    var status:STATUS_SKILL = .MINE
    
    init(skillName:String, status:STATUS_SKILL) {
        self.key = skillName
        self.status = status
    }
}

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
    var skillSource = [profileSkill]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height - 64), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(ProfileImageTableViewCell.self, forCellReuseIdentifier: "imageProfile")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerClass(ProfileSkillTableViewCell.self, forCellReuseIdentifier: "skillCell")
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
        
        skillSource.append(profileSkill(skillName: "Smoothy mix", status: .MINE))
        skillSource.append(profileSkill(skillName: "Tollet cleanning", status: .MINE))
        skillSource.append(profileSkill(skillName: "Oganami", status: .LEARN))
        skillSource.append(profileSkill(skillName: "Catwalk model", status: .WISH_TO_LEARN))
        skillSource.append(profileSkill(skillName: "Búng thun", status: .MINE))
        skillSource.append(profileSkill(skillName: "Yoga", status: .LEARN))
        
        dataSource.append(profileInfo(key: nil, value: nil))
        dataSource.append(profileInfo(key: "Name", value: "Jennifer Lu"))
        dataSource.append(profileInfo(key: "Email", value: "jen.lu@gmail.com"))
        dataSource.append(profileInfo(key: "My Skills", value: "\(skillSource.count)"))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        (self.tabBarController as! MeViewController).topView.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
        
        if indexPath.row < 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.selectionStyle = .None
            cell.textLabel?.text = dataSource[indexPath.row].getContent()
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("skillCell", forIndexPath: indexPath) as! ProfileSkillTableViewCell
        cell.loadCell(skillSource, size: CGSize(width: tableView.frame.size.width, height: 200))
        return cell
    }
    
    func showPickerSkill() {
        let pick = PickingSkillViewController(isMine: true)
        self.navigationController?.pushViewController(pick, animated: true)
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
