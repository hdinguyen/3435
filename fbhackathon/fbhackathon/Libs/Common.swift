//
//  Common.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

typealias commonHandler = (data:AnyObject?) -> Void

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
    
}
