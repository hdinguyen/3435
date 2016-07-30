//
//  APIClient.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit
import Alamofire


typealias api_response = (data:AnyObject?, error:NSError?) -> Void

class ApiManager {
    static let sharedInstance: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders!["x-access-token"] = ""
        configuration.timeoutIntervalForRequest = 30
        return Manager(configuration: configuration)
    }()
}

class APIClient: NSObject {
    
    let alamoFireManager : Alamofire.Manager?
    
    override init(){
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        self.alamoFireManager = Alamofire.Manager(configuration: configuration)
    }
}
