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
    var is_offline:Bool = true
    var location:String = "0.0 - 0.0"
    
    init(data:[String:AnyObject]) {
        self.program_id = (data["id"] as! NSNumber).stringValue
        self.program_detail = data["details"] as! String
        self.program_length = (data["length"] as! NSNumber).stringValue
        self.program_price = (data["price"] as! NSNumber).stringValue
        self.is_offline = (data["is_offline"] as! NSNumber).boolValue
        self.location = data["location"] as! String
    }
}

class CourseViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var screenType:COURSE_SCREEN = .PROGRAM
    var dataSource = [program]()

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
            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/courses?type=mentor") { (data, error) in
                tableView.reloadData()
            }
        case .PROGRAM:
//            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/programs") { (data, error) in
            APIClient.getRequest("users/1/programs") { (data, error) in
                
                for i:[String:AnyObject] in data!["data"] as! [[String:AnyObject]] {
                    self.dataSource.append(program(data: i))
                }
                tableView.reloadData()
            }
            
        case .OFFER:
            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/offer") { (data, error) in
                
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
        
        cell?.textLabel?.text = dataSource[indexPath.row].program_detail
        cell?.detailTextLabel?.text = "$\(dataSource[indexPath.row].program_price)"
        if dataSource[indexPath.row].is_offline == true {
            cell?.imageView?.image = UIImage(named: "offline")
        } else {
            cell?.imageView?.image = UIImage(named: "online")
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
