//
//  RatingTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    var ratingView:FloatRatingView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(data:Float, size:CGSize) {
        if ratingView == nil {
            ratingView = FloatRatingView(frame: CGRect(x: 50, y: 5, width: size.width - 100, height:size.height - 10))
            
            ratingView!.emptyImage = UIImage(named: "StarEmpty")
            ratingView!.fullImage = UIImage(named: "StarFull")
        
            ratingView!.contentMode = UIViewContentMode.ScaleAspectFit
            ratingView!.maxRating = 5
            ratingView!.minRating = 1
            ratingView!.editable = false
            ratingView!.halfRatings = true
            ratingView!.floatRatings = false
            self.addSubview(ratingView!)
        }
        ratingView?.rating = data
    }

}
