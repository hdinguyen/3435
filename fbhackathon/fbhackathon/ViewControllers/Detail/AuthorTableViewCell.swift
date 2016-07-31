//
//  AuthorTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

typealias authorHandler = ()->Void

class AuthorTableViewCell: UITableViewCell {
    
    var coverImage:UIImageView?
    var profileImage:UIImageView?
    var analysisLb:UILabel?
    var join:UIButton?
    var deny:UIButton?
    var handler:authorHandler!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func load(data:String, isOffer: Bool, size:CGSize, handler:authorHandler) {
        self.handler = handler
        if coverImage == nil {
            coverImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height - 30))
            coverImage?.contentMode = .ScaleAspectFill
            coverImage?.clipsToBounds = true
            self.addSubview(coverImage!)
            
            profileImage = UIImageView(frame: CGRect(x: 30, y: coverImage!.frame.size.height - 70, width: 100, height: 100))
            profileImage?.layer.cornerRadius = 50
            profileImage?.layer.masksToBounds = true
            profileImage?.layer.borderWidth = 1
            profileImage?.layer.borderColor = UIColor.whiteColor().CGColor
            profileImage?.contentMode = .ScaleAspectFill
            self.addSubview(profileImage!)
            
            analysisLb = UILabel(frame: CGRect(x: profileImage!.frame.size.width + profileImage!.frame.origin.x, y: coverImage!.frame.size.height, width: coverImage!.frame.size.width, height: 30))
            analysisLb?.font = UIFont.systemFontOfSize(12)
            self.addSubview(analysisLb!)
            
            deny = UIButton(frame: CGRect(x: size.width - 70 - 80 - 30, y: coverImage!.frame.size.height - 40 - 20, width: 70, height: 40))
            deny?.layer.cornerRadius = 3
            deny?.layer.borderColor = UIColor.redColor().CGColor
            deny?.layer.borderWidth = 1
            deny?.backgroundColor = UIColor.colorWithHexString("C51B45cc")
            deny?.setTitle("Reject", forState: .Normal)
            self.addSubview(deny!)
            
            join = UIButton(frame: CGRect(x: size.width - 70 - 30, y: coverImage!.frame.size.height - 40 - 20, width: 70, height: 40))
            join?.layer.cornerRadius = 3
            join?.layer.borderColor = UIColor.redColor().CGColor
            join?.layer.borderWidth = 1
            join?.backgroundColor = UIColor.colorWithHexString("434857cc")
            join?.addTarget(self, action: #selector(AuthorTableViewCell.sendOffer), forControlEvents: .TouchUpInside)
            if isOffer == true {
                join?.setTitle("Offer", forState: .Normal)
            } else {
                join?.setTitle("Accept", forState: .Normal)
                
            }
            self.addSubview(join!)
            
            
        }
        if let image = UIImage(named: data) {
            coverImage?.image = image
        } else {
            coverImage?.image = UIImage(named: "blur")
        }
        profileImage?.image = Common.shareInstance.userImage().image
        
        analysisLb?.text = "34 users used | 20 users said good quality"
    }
    
    func sendOffer() {
        join?.enabled = false
        self.handler()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
