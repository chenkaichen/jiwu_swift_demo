//
//  JWHTTPManager.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod {
    case GET
    case POST
}

class JWHTTPManager: AFHTTPSessionManager {

    static let sharedRequest : JWHTTPManager = {
        
        let tempHttp = JWHTTPManager()
        tempHttp.requestSerializer.timeoutInterval = 15
        tempHttp.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tempHttp
    }()
    
    func httpRequest(method: HTTPMethod = .GET, URLString: String, parameters: [String : AnyObject], completion: @escaping (_ json: AnyObject ,_ isSuccess: Bool)->()){
        
        let success = { (task :URLSessionDataTask, json :Any?) -> () in
            
            completion(json as AnyObject , true)
            
        }
        
        let failure = { (task :URLSessionDataTask? , error :Error) -> () in
        
            print("============== \(error.localizedDescription)")
            completion("" as AnyObject, false)
        
        }
        
        var tempDict = ["versionCode" : "533" , "key" : "6f0ef0be6cf3a14a6d8132476835c9d1"]
        
        for (key,value) in parameters {
            
            tempDict[key] = value as? String
            
        }
        
        if method == .GET {
            get(URLString, parameters: tempDict, progress: nil, success: success, failure: failure)
            
        }else{
            post(URLString, parameters: tempDict, progress: nil, success: success, failure: failure)
        
        }
    }
}
