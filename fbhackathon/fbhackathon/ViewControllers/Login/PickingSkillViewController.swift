//
//  PickingSkillViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class PickingSkillViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let searchTxt = UISearchBar()
    var isMine = true
    var selectedRow = [Int]()
    
    init(isMine:Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isMine = isMine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dataSource:[String:[String]] = ["Culture":["Japanese tea", "Asia art", "Canavan", "UK Tea", "Sakura", "July 4", "Easter"], "Sport":["Golf", "Cycling", "Football", "Tennis", "Badminton", "Horse Rate", "Zumba"], "Art":["Photography", "Typo", "Re-touch", "Graffiti", "Cosplay"], "Music":["Hiphop", "Meditation", "Jazz", "Guita", "Hamonica", "Sing"], "Hobby":["Helicopter", "Origami", "Readding", "Candle Making"], "Cooking":["Cake", "Beepsteak", "French", "India", "Korea", "Sushi", "Fruice", "Vegan", "Seafood"], "Tip":["Cleaning", "Indoor", "Washing", "Electric"], "Programming":["Python", "PhP", "Computer science", "Hacking"], "Pet":["Dog", "Trainning", "Cat", "Bird", "Fish", "Turtle", "Hamster"], "Science":["Physic", "Math", "Chemistry", "Physiology"], "Business":["SME", "Startup", "Affiliate", "Authorise"], "Religion":["Buddhist", "Christian", "Muslim", "Maisen", "Other"], "Romance":["Dating", "Kissing", "Dinner", "Chit chat"], "Handmake":["Gift", "Furniture"]]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxt.frame = CGRectZero
        searchTxt.center = CGPoint(x: self.view.frame.size.width/2, y: self.searchTxt.frame.size.height/2)
        self.view.addSubview(searchTxt)
        
        let tableView = UITableView(frame: CGRect(x: 0, y: searchTxt.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - searchTxt.frame.size.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view = tableView
        if isMine == false {
            self.navigationItem.title = "Pick your interesting..."
        } else {
            self.navigationItem.title = "Pick your skills"
        }
        
        let done:UIBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(PickingSkillViewController.donePressed(_:)))
        self.navigationItem.rightBarButtonItem = done
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func donePressed(sender: AnyObject) {
        if isMine == false {
            let pickMine = PickingSkillViewController(isMine: true)
            self.navigationController?.pushViewController(pickMine, animated: true)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        if selectedRow.contains(indexPath.row) == true {
            selectedRow.removeAtIndex(selectedRow.indexOf(indexPath.row)!)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
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
