//
//  ProfileImageTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileImageTableViewCell: UITableViewCell {

    var backgroundImage:UIImageView?
    var profileImage:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(imageUrl:String, size:CGSize) {
        if backgroundImage == nil {
            backgroundImage = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
            self.addSubview(backgroundImage!)
            profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            profileImage?.center = CGPoint(x: size.width/2, y: size.height/2)
            profileImage?.layer.borderColor = UIColor.whiteColor().CGColor
            profileImage?.layer.borderWidth = 1
            profileImage?.layer.cornerRadius = 50
            profileImage?.layer.masksToBounds = true
            self.addSubview(profileImage!)
            backgroundImage?.image = UIImage(named: "bgProfile")
        }
        profileImage?.kf_setImageWithURL(NSURL(string: imageUrl)!)
    }

}
