//
//  JWHTTPManager+Extension.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/8.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import Foundation

extension JWHTTPManager{
    
    func posterRequest (completion: @escaping ([[String :AnyObject]] , _ isSuccess : Bool) -> ()){
        
        
        let base_Url = "http://t.jiwu.com/apps!appPoster.action"
        
        let paramet = ["cityId":"0","versionCode":"5.0","version":"4.0","key":"5ff5c01c406a9086c8a08fde047054c1"] as [String : Any]
            
            
            JWHTTPManager.sharedRequest.httpRequest(method: .POST, URLString: base_Url, parameters: paramet as [String : AnyObject]) { (json, isSuccess) in
            
            let result = json["Poster"] as? [[String : AnyObject]] ?? []
            
            completion(result, isSuccess)
            
            }
    
    
    }
    
    func homeRequest(page : Int64 , completion: @escaping ([[String :AnyObject]] , _ isSuccess : Bool) -> ()){
        
        let base_Url = "http://t.jiwu.com/apps!homeList.action"
        
        let paramet = ["seeclient":"0","cityId":"0","page":page,"pageSize":"10","sortWay":"1","versionCode":"5.0","version":"4.0","key":"5ff5c01c406a9086c8a08fde047054c1"] as [String : Any]
        
        JWHTTPManager.sharedRequest.httpRequest(method: .POST, URLString: base_Url, parameters: paramet as [String : AnyObject]) { (json, isSuccess) in
            
            let result = json["Homes"] as? [[String : AnyObject]] ?? []
            
            completion(result, isSuccess)
            
        }
        
    }

}
