//
//  DescriptionComposerTableViewCell.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

typealias composerHandler = (text:String, size:CGSize) -> Void

class DescriptionComposerTableViewCell: UITableViewCell, UITextViewDelegate {
    
    var composer:UITextView?
    var handler:composerHandler!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(size:CGSize, handler: composerHandler) {
        self.handler = handler
        if composer == nil {
            composer = UITextView()
            composer?.layoutIfNeeded()
            composer?.delegate = self
            composer?.layer.borderWidth = 0.5
            composer?.layer.borderColor = UIColor.lightGrayColor().CGColor
            composer?.layer.cornerRadius = 3
            composer?.autocorrectionType = .Default
            self.addSubview(composer!)
        }
        composer?.frame = CGRect(x:10, y:10, width:self.frame.size.width - 20,height: size.height - 10)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let att = NSAttributedString(string: textView.text, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12)])
        let rect = att.boundingRectWithSize(CGSize(width: textView.frame.width, height: 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        self.handler(text: textView.text + "\(text)", size: rect.size)
        return true
    }

}
