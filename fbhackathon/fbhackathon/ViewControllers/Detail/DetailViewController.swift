//
//  DetailViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var titleName:String = ""
    var show_offer:Bool = true

    init(name:String, show_offer:Bool) {
        super.init(nibName: nil, bundle: nil)
        self.titleName = name
        self.show_offer = show_offer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(AuthorTableViewCell.self, forCellReuseIdentifier: "author")
        tableView.registerClass(DescriptionTableViewCell.self, forCellReuseIdentifier: "decription")
        tableView.registerClass(RatingTableViewCell.self, forCellReuseIdentifier: "rating")
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "comment")
        tableView.separatorStyle = .None
        self.view = tableView
        
        self.navigationItem.title = self.titleName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        }
        if indexPath.row == 1 {
            return 230
        }
        if indexPath.row == 2 {
            return 40
        }
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let authorCell = tableView.dequeueReusableCellWithIdentifier("author", forIndexPath: indexPath) as! AuthorTableViewCell
            authorCell.load(self.titleName, isOffer: self.show_offer, size: CGSize(width: tableView.frame.width, height: 230), handler: {
                let alertController = UIAlertController(title: "Sent Offer", message: "Your offer was sent. Please wait", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(action)
                self.presentViewController(alertController, animated: true, completion: nil)
            })
            return authorCell
        }
        if indexPath.row == 1 {
            let decriptionCell = tableView.dequeueReusableCellWithIdentifier("decription", forIndexPath: indexPath) as! DescriptionTableViewCell
            decriptionCell.load("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", size: CGSize(width: tableView.frame.width, height: 230))
            return decriptionCell
        }
        if indexPath.row == 2 {
            let ratingCell = tableView.dequeueReusableCellWithIdentifier("rating", forIndexPath: indexPath) as! RatingTableViewCell
            ratingCell.load(4.5, size: CGSize(width: tableView.frame.size.width, height: 40))
            return ratingCell
        }
        var cell = tableView.dequeueReusableCellWithIdentifier("comment")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "comment")
            cell?.selectionStyle = .None
            cell?.imageView?.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
            cell?.imageView?.layer.cornerRadius = 5
            cell?.imageView?.layer.masksToBounds = true
            cell?.imageView?.clipsToBounds = true
            cell?.imageView?.contentMode = .ScaleAspectFit
        }
        cell?.textLabel?.text = "Nice mentor"
        let person = Common.shareInstance.userImage()
        cell?.detailTextLabel?.text = person.name
        cell?.imageView?.image = person.image
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
