//
//  AuthorTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class AuthorTableViewCell: UITableViewCell {
    
    var coverImage:UIImageView?
    var profileImage:UIImageView?
    var analysisLb:UILabel?
    var join:UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func load(data:AnyObject, size:CGSize) {
        if coverImage == nil {
            coverImage = UIImageView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height - 30))
            self.addSubview(coverImage!)
            profileImage = UIImageView(frame: CGRect(x: 30, y: coverImage!.frame.size.height - 70, width: 100, height: 100))
            profileImage?.layer.cornerRadius = 50
            profileImage?.layer.masksToBounds = true
            profileImage?.layer.borderWidth = 1
            profileImage?.layer.borderColor = UIColor.whiteColor().CGColor
            self.addSubview(profileImage!)
            
            analysisLb = UILabel(frame: CGRect(x: profileImage!.frame.size.width + profileImage!.frame.origin.x, y: coverImage!.frame.size.height, width: coverImage!.frame.size.width, height: 30))
            self.addSubview(analysisLb!)
            
            join = UIButton(frame: CGRect(x: size.width - 50 - 20, y: coverImage!.frame.size.height - 30 - 10, width: 50, height: 30))
            join?.layer.cornerRadius = 3
            join?.layer.borderColor = UIColor.redColor().CGColor
            join?.layer.borderWidth = 1
            join?.setTitle("Offer", forState: .Normal)
            self.addSubview(join!)
        }
        coverImage?.backgroundColor = UIColor.yellowColor()
        profileImage?.backgroundColor = UIColor.greenColor()
        analysisLb?.backgroundColor = UIColor.blueColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
