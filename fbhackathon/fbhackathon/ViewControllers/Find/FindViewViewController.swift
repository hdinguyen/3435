//
//  FindViewViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class FindViewViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let dataSource:[String:[String]] = ["Culture":["I need to learn basic about Japanese tea meeting", "I can help you write canchi art", "Just join the canavan festival. If you love to know more", "I want to learn the UK teapot culture"], "Sport":["I need to learn basic Golf", "I need someone training Cycling", "I'm expert inn Yoga, I can help if you want to train", "I need to learn Zumba basic step"], "Art":["Photography", "Typo", "Re-touch", "Graffiti", "Cosplay"], "Music":["I want to know how to play \"I'm yours\" on guitar", "I have a few think love to share about Meditation", "I love to learn play Hamonica", "I can improve your singing"], "Hobby":["I can guide how to bought a reasonable Helicopter", "(Origami)I want to know how to make a dog with paper"], "Cooking":["I know how to make the Tiramisu cake", "I love to know how to cook Beepsteak", "Can you teach me how to cook a Korea dishes", "I know the tip to make good Sushi", "Fruice", "Vegan", "How to make good Seafood"]]
    
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[indexPath.section]
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.dataSource[key]![indexPath.row]
        cell?.detailTextLabel?.text = Common.shareInstance.userImage().name
        cell?.backgroundColor = UIColor.whiteColor()
        if indexPath.section == 0 || indexPath.section == 3 {
            if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 5 {
                cell?.backgroundColor = UIColor.colorWithHexString("d7ffcb")
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[indexPath.section]
        let detail = DetailViewController(name: self.dataSource[key]![indexPath.row])
        self.navigationController?.pushViewController(detail, animated: true)
    }

}
