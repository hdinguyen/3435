//
//  DescriptionTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    var content:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(data:String, size:CGSize) {
        if content == nil {
            content = UILabel(frame: CGRect(x: 10, y: 5, width: size.width - 10, height: size.height-5))
            content?.numberOfLines = 0
            self.addSubview(content!)
        }
        self.content?.text = data
    }

}
