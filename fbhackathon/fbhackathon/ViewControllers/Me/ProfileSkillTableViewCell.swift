//
//  ProfileSkillTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class ProfileSkillTableViewCell: UITableViewCell, TagViewDelegate {

    var cloudView:CloudTagView?
    var bgcolors = [UIColor.colorWithHexString("1BC98E"), UIColor.colorWithHexString("9F86FF"), UIColor.colorWithHexString("1CA8DD")]
    var txcolors = [UIColor.colorWithHexString("FFFFFF"), UIColor.colorWithHexString("FFFFFF"), UIColor.colorWithHexString("FFFFFF")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(data:[profileSkill], size:CGSize) {
        if cloudView == nil {
            cloudView = CloudTagView()
            self.addSubview(cloudView!)
        }
        cloudView?.frame = CGRect(x: 5, y: 5, width: size.width - 10, height: size.height - 5)
        
        for i:profileSkill in data {
            let tag = TagView(text: i.key)
            tag.backgroundColor = bgcolors[i.status.rawValue]
            tag.tintColor = txcolors[i.status.rawValue]
            tag.delegate = self
            cloudView?.tags.append(tag)
        }
    }
    
    func tagTouched(tag: TagView) {
        tag.removeFromSuperview()
    }

}
