//
//  LoginViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: BaseViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLogin = FBSDKLoginButton(frame: CGRect(x: 20, y: 50, width: 100, height: 50))
        fbLogin.delegate = self
        self.view.addSubview(fbLogin)
        self.navigationItem.title = "Login"
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let picking = PickingSkillViewController(isMine: false)
        self.navigationController?.pushViewController(picking, animated: true)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("LOGOUT PRESSED")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
