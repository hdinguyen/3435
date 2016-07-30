//
//  Common.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

typealias commonHandler = (data:AnyObject?) -> Void

let names = ["Jennifer", "Jenna", "Amanda", "Todd", "Hannah", "Max", "Ling"]

class person {
    var name:String = "Jennifer"
    var image:UIImage = UIImage(named:"0")!
    
    init(name:Int, image:String) {
        self.name = names[name]
        self.image = UIImage(named: image)!
    }
}

class Common: NSObject {

    static let shareInstance:Common = Common()
    var handler:commonHandler!
    
    func createToolBar(handler: commonHandler) -> UIToolbar {
        self.handler = handler
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 30))
        toolbar.barStyle = .BlackTranslucent
        let done = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(Common.dismiss))
        toolbar.items = [done]
        toolbar.sizeToFit()
        return toolbar
    }
    
    func dismiss() {
        self.handler(data: nil)
        
    }
    
    func userImage() -> person {
        let ran = arc4random_uniform(6)
        return person(name: Int(ran), image: "\(ran)")
    }
    
}

extension UIColor {
    
    public class func colorWithHexString (hex:String) -> UIColor {
        if hex.characters.count >= 6 {
            var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
            
            if (cString.hasPrefix("#")) {
                cString = (cString as NSString).substringFromIndex(1)
            }
            
            let rString = (cString as NSString).substringToIndex(2)
            let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
            let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
            var a:CUnsignedInt = 255
            if (cString as NSString).length > 6 {
                let aString = ((cString as NSString).substringFromIndex(6) as NSString).substringToIndex(2)
                NSScanner(string: aString).scanHexInt(&a)
            }
            
            var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
            NSScanner(string: rString).scanHexInt(&r)
            NSScanner(string: gString).scanHexInt(&g)
            NSScanner(string: bString).scanHexInt(&b)
            
            
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        }
        return UIColor.clearColor()
    }
}
