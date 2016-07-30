//
//  DetailViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(AuthorTableViewCell.self, forCellReuseIdentifier: "author")
        tableView.registerClass(DescriptionTableViewCell.self, forCellReuseIdentifier: "decription")
        tableView.registerClass(RatingTableViewCell.self, forCellReuseIdentifier: "rating")
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "comment")
        tableView.separatorStyle = .None
        self.view = tableView
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
            authorCell.load("abc", editMode: false, size: CGSize(width: tableView.frame.width, height: 230))
            return authorCell
        }
        if indexPath.row == 1 {
            let decriptionCell = tableView.dequeueReusableCellWithIdentifier("decription", forIndexPath: indexPath) as! DescriptionTableViewCell
            decriptionCell.load("abc", size: CGSize(width: tableView.frame.width, height: 230))
            return decriptionCell
        }
        if indexPath.row == 2 {
            let ratingCell = tableView.dequeueReusableCellWithIdentifier("rating", forIndexPath: indexPath) as! RatingTableViewCell
            ratingCell.load(4.5, size: CGSize(width: tableView.frame.size.width, height: 40))
            return ratingCell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("comment", forIndexPath: indexPath)
        cell.textLabel?.text = "Comment here"
        return cell
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
