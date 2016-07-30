//
//  FindViewViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class FindViewViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let dataSource:[String:[String]] = ["Culture":["Japanese tea", "Asia art", "Canavan", "UK Tea", "Sakura", "July 4", "Easter"], "Sport":["Golf", "Cycling", "Football", "Tennis", "Badminton", "Horse Rate", "Zumba"], "Art":["Photography", "Typo", "Re-touch", "Graffiti", "Cosplay"], "Music":["Hiphop", "Meditation", "Jazz", "Guita", "Hamonica", "Sing"], "Hobby":["Helicopter", "Origami", "Readding", "Candle Making"], "Cooking":["Cake", "Beepsteak", "French", "India", "Korea", "Sushi", "Fruice", "Vegan", "Seafood"], "Tip":["Cleaning", "Indoor", "Washing", "Electric"], "Programming":["Python", "PhP", "Computer science", "Hacking"], "Pet":["Dog", "Trainning", "Cat", "Bird", "Fish", "Turtle", "Hamster"], "Science":["Physic", "Math", "Chemistry", "Physiology"], "Business":["SME", "Startup", "Affiliate", "Authorise"], "Religion":["Buddhist", "Christian", "Muslim", "Maisen", "Other"], "Romance":["Dating", "Kissing", "Dinner", "Chit chat"], "Handmake":["Gift", "Furniture"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .Interactive
        self.view = tableView

        let searchBar = UISearchBar(frame: CGRectZero)
        self.navigationItem.titleView = searchBar
        
        let nearBy:UIBarButtonItem = UIBarButtonItem(title: "Nearby", style: .Done, target: self, action: #selector(FindViewViewController.nearByPressed))
        self.navigationItem.leftBarButtonItem = nearBy
        
        let addNew:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: #selector(FindViewViewController.newCourse))
        self.navigationItem.rightBarButtonItem = addNew
    }
    
    func newCourse() {
        let composer = ComposerViewController()
        self.navigationController?.pushViewController(composer, animated: true)
    }
    
    func nearByPressed() {
        self.tabBarController?.selectedIndex = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataSource.keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[section]
        return (self.dataSource[key]?.count)!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[section]
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = UIColor.colorWithHexString("CFD2DA")
        
        let icon = UIImageView(frame: CGRect(x: 10, y: 2, width: view.frame.size.height - 4, height: view.frame.size.height - 4))
        icon.layer.cornerRadius = icon.frame.height/2
        icon.layer.masksToBounds = true
        icon.layer.borderColor = UIColor.whiteColor().CGColor
        icon.layer.borderWidth = 1
        icon.image = UIImage(named: key)
        view.addSubview(icon)

        let label = UILabel(frame: CGRect(x: view.frame.size.height - 4 + 13, y: 0, width: view.frame.size.width - (view.frame.size.height - 4 + 13), height: 50))
        label.text = key
        view.addSubview(label)
        return view
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Skill Category"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[indexPath.section]
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.dataSource[key]![indexPath.row]
        cell?.detailTextLabel?.text = Common.shareInstance.userImage().name
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detail = DetailViewController(name: "golf")
        self.navigationController?.pushViewController(detail, animated: true)
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
