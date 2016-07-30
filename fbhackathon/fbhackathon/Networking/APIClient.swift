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
let API_URL = "http://10.247.224.185:3000/"

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
    
    class func postRequest(urlPath: String, postData:[String:AnyObject], complete:api_response) {
        ApiManager.sharedInstance.request(.POST, API_URL + urlPath, parameters: postData, encoding: .JSON).responseJSON { (response:Response<AnyObject, NSError>) in
            complete(data: response.result.value, error: response.result.error)
        }
    }
    
    class func getRequest(urlPath: String, complete:api_response) {
        ApiManager.sharedInstance.request(.GET, API_URL + urlPath).responseJSON { (response:Response<AnyObject, NSError>) in
            complete(data: response.result.value, error: response.result.error)
        }
    }
}
