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
    
    init(isMine:Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isMine = isMine
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxt.frame = CGRectZero
        searchTxt.center = CGPoint(x: self.view.frame.size.width/2, y: self.searchTxt.frame.size.height/2)
        self.view.addSubview(searchTxt)
        
        let tableView = UITableView(frame: CGRect(x: 0, y: searchTxt.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - searchTxt.frame.size.height))
        tableView.delegate = self
        tableView.dataSource = self
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
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Skill name"
        cell.imageView?.image = UIImage(named: "")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
