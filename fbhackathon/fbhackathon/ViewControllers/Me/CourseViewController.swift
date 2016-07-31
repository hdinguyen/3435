//
//  CourseViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

enum COURSE_SCREEN {
    case PROGRAM
    case OFFER
    case COURSE
}

class program {
    var program_id:String = ""
    var program_detail:String = ""
    var program_length:String = ""
    var program_price:String = ""
    var program_title:String = ""
    var is_offline:Bool = true
    var location:String = "0.0 - 0.0"
    
    init(data:[String:AnyObject]) {
        self.program_id = (data["id"] as! NSNumber).stringValue
        self.program_detail = data["details"] as! String
        self.program_length = (data["length"] as! NSNumber).stringValue
        self.program_price = (data["price"] as! NSNumber).stringValue
        self.program_title = data["title"] as! String
        self.is_offline = (data["is_offline"] as! NSNumber).boolValue
        self.location = data["location"] as! String
    }
}

class course {
    var course_id:String = ""
    var program_detail:String = ""
    var status:String = ""
    var title:String = ""
    var location:String = "0.0 - 0.0"
    
    init(data:[String:AnyObject]) {
        self.course_id = (data["id"] as! NSNumber).stringValue
        self.program_detail = data["program"]!["details"] as! String
        self.status = (data["status"] as! NSNumber).stringValue
        self.title = data["program"]!["title"] as! String
        self.program_detail = data["program"]!["details"] as! String
        self.location = data["program"]!["location"] as! String
    }
}

class offer {
    var offer_id:String = ""
    var program_id:String = ""
    var program_detail:String = ""
    var program_title:String = ""
    var price:String = ""
    var return_program_id:String = ""
    var return_program_detail:String = ""
    var return_program_title:String = ""
    var mentor_id:String = ""
    var mentee_id:String = ""
    var type: String = ""
    var status: String = ""
    var mentor_identity: String = ""
    var mentee_identity: String = ""
    
    init(offer:[String:AnyObject]) {
        self.offer_id = (offer["id"] as! NSNumber).stringValue
        self.program_id = (offer["program"]!["id"] as! NSNumber).stringValue
        self.program_detail = offer["program"]!["details"] as! String
        self.program_title = offer["program"]!["title"] as! String
        self.price = (offer["price"] as! NSNumber).stringValue
        self.return_program_id = (offer["return_program"]!["id"] as! NSNumber).stringValue
        self.return_program_detail = offer["return_program"]!["details"] as! String
        self.return_program_title = offer["return_program"]!["title"] as! String
        self.mentor_id = (offer["mentor_person"]!["id"] as! NSNumber).stringValue
        self.mentee_id = (offer["mentee_person"]!["id"] as! NSNumber).stringValue
        self.type = (offer["is_offline"] as! NSNumber).stringValue
        self.status = offer["status"] as! String
        self.mentor_identity = offer["mentor_person"]!["identity"] as! String
        self.mentor_identity = offer["mentee_person"]!["identity"] as! String
    }
}

class CourseViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var screenType:COURSE_SCREEN = .PROGRAM
    var dataSource = [AnyObject]()

    init (screen:COURSE_SCREEN) {
        super.init(nibName: nil, bundle: nil)
        self.screenType = screen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.height - 64), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        switch screenType {
        case .COURSE:
            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/courses") { (data, error) in
                for i:[String:AnyObject] in data!["data"] as! [[String:AnyObject]] {
                    self.dataSource.append(course(data: i))
                }
                tableView.reloadData()
            }
        case .PROGRAM:
            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/programs") { (data, error) in
//            APIClient.getRequest("users/1/programs") { (data, error) in
            
                for i:[String:AnyObject] in data!["data"] as! [[String:AnyObject]] {
                    self.dataSource.append(program(data: i))
                }
                tableView.reloadData()
            }
            
        case .OFFER:
            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/offers") { (data, error) in
                for i:[String:AnyObject] in data!["data"] as! [[String:AnyObject]] {
                    self.dataSource.append(offer(offer: i))
                }
                tableView.reloadData()
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        }
        switch self.screenType {
        case .COURSE:
            let itemCourse = self.dataSource[indexPath.row] as! course
            cell?.textLabel?.text = itemCourse.program_detail
            cell?.detailTextLabel?.text = itemCourse.location
        case .OFFER:
            let itemOffer = self.dataSource[indexPath.row] as! offer
            cell?.textLabel?.text = itemOffer.program_title
            cell?.detailTextLabel?.text = itemOffer.program_detail
        case .PROGRAM:
            let itemProgram = self.dataSource[indexPath.row] as! program
            cell?.textLabel?.text = itemProgram.program_detail
            cell?.detailTextLabel?.text = ""
        
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
