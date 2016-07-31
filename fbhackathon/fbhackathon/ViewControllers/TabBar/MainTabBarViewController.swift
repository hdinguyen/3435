//
//  MainTabBarViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        (self.viewControllers![1] as! UITabBarController).tabBarItem.title = "Me"
        (self.viewControllers![1] as! UITabBarController).tabBarItem.image = UIImage(named: "me")
    }
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() == nil {
            let loginVC = LoginViewController()
            self.presentViewController(UINavigationController(rootViewController: loginVC), animated: true, completion: nil)
        } else {
            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: FBSDKAccessToken.currentAccessToken().tokenString, version: nil, HTTPMethod: "GET")
            req.startWithCompletionHandler({ (connection, result, error : NSError!) -> Void in
                if(error == nil)
                {
                    DataManager.shareInstance.fbUserId = result["id"] as! String
                }
                else
                {
                    print("error \(error)")
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
