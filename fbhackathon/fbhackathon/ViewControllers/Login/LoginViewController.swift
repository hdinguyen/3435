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
        
        let bgImage = UIImageView(frame: self.view.bounds)
        bgImage.image = UIImage(named: "splash")
        self.view.addSubview(bgImage)
        let fbLogin = FBSDKLoginButton(frame: CGRect(x: 20, y: self.view.frame.size.height - 50 - 100, width: self.view.frame.size.width - 40, height: 50))
        fbLogin.readPermissions = ["public_profile", "email"]
        fbLogin.delegate = self
        self.view.addSubview(fbLogin)
        self.navigationItem.title = "Login"
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let tokenString = result.token.tokenString
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,picture.width(480).height(480)"]).startWithCompletionHandler { (request, result, err) in
            let photo_url = ((result["picture"] as! [String:AnyObject])["data"] as! [String:AnyObject])["url"] as! String

            APIClient.postRequest("users/oauth/facebook", postData: ["token":tokenString, "email":result["email"] as! String, "photo_url":photo_url], complete: { (data, error) in
                DataManager.shareInstance.userId = (data!["data"]!!["id"] as! NSNumber).stringValue
                DataManager.shareInstance.wrtie("USER_ID", value: DataManager.shareInstance.userId)
                let pick = PickingSkillViewController(isMine: false)
                self.navigationController?.pushViewController(pick, animated: true)
            })
        }
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
