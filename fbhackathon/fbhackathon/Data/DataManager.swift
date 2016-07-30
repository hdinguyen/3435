//
//  DataManager.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    static let shareInstance = DataManager()
    var userId:String = ""
    var fbUserId:String = ""
    
    func wrtie(key:String, value:String) {
        userDefault.setObject(value, forKey: key)
        userDefault.synchronize()
    }
    
    func clean(key:String) {
        userDefault.removeObjectForKey(key)
        userDefault.synchronize()
    }
    
    func read(key:String) -> String {
        if userDefault.objectForKey(key) == nil {
            return ""
        }
        return userDefault.objectForKey(key) as! String
    }
}
