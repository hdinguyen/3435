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
    var dataSource = [String:[String]]()

    init (screen:COURSE_SCREEN) {
        super.init(nibName: nil, bundle: nil)
        self.screenType = screen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
            break
//            APIClient.getRequest("users/1/programs") { (data, error) in
//                
//                for i:[String:AnyObject] in data!["data"] as! [[String:AnyObject]] {
//                    self.dataSource.append(program(data: i))
//                }
//                tableView.reloadData()
//            }
            
        case .OFFER:
//            APIClient.getRequest("users/\(DataManager.shareInstance.userId)/offer") { (data, error) in
//                
//                tableView.reloadData()
//            }
            self.dataSource = ["Culture":["I need to learn basic about Japanese tea meeting", "I can help you write canchi art", "Just join the canavan festival. If you love to know more", "I want to learn the UK teapot culture"], "Sport":["I need to learn basic Golf", "I need someone training Cycling", "I'm expert inn Yoga, I can help if you want to train", "I need to learn Zumba basic step"], "Art":["Photography", "Typo", "Re-touch", "Graffiti", "Cosplay"], "Music":["I want to know how to play \"I'm yours\" on guitar", "I have a few think love to share about Meditation", "I love to learn play Hamonica", "I can improve your singing"], "Hobby":["I can guide how to bought a reasonable Helicopter", "(Origami)I want to know how to make a dog with paper"], "Cooking":["I know how to make the Tiramisu cake", "I love to know how to cook Beepsteak", "Can you teach me how to cook a Korea dishes", "I know the tip to make good Sushi", "Fruice", "Vegan", "How to make good Seafood"]]
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.keys.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[section]
        
        return (dataSource[key]?.count)!
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        }
        
        let arr:[String] = Array(self.dataSource.keys)
        let key:String = arr[indexPath.section]
        
        cell?.textLabel?.text = dataSource[key]![indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let detail = DetailViewController(name: "", show_offer: false)
        self.navigationController?.pushViewController(detail, animated: true)
        (self.tabBarController as! MeViewController).topView.hidden = true
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
