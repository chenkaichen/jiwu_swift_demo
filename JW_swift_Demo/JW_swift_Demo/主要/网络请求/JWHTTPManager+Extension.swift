//
//  JWHTTPManager+Extension.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import Foundation

extension JWHTTPManager{
    
    //首页广告
    func bannelRequest (completion: @escaping ([[String :AnyObject]] , _ isSuccess : Bool) -> ()){
        
        let base_Url = "http://t.jiwu.com/apps!appPoster.action"
        
        let paramet = ["cityId" : "12"] as [String : AnyObject]
        
        JWHTTPManager.sharedRequest.httpRequest(method: .POST, URLString: base_Url, parameters: paramet as [String : AnyObject]) { (json, isSuccess) in
            
            let result = json["Poster"] as? [[String : AnyObject]] ?? []
            
            completion(result, isSuccess)
            
        }
    }
    
    //首页楼盘列表
    func houseListRequest(page : Int64 , completion: @escaping ([[String :AnyObject]] , _ isSuccess : Bool) -> ()){
        
        let base_Url = "http://t.jiwu.com/apps!homeList.action"
        
        let paramet = ["cityId" : "0" , "isSide" : "0" , "page" : "\(page)" , "pageSize" : "10" , "seeclient" : "0" , "sortWay" : "1" ] as [String : AnyObject]
        
        JWHTTPManager.sharedRequest.httpRequest(method: .POST, URLString: base_Url, parameters: paramet as [String : AnyObject]) { (json, isSuccess) in
            
            let result = json["Homes"] as? [[String : AnyObject]] ?? []
            
            completion(result, isSuccess)
            
        }
    }
    
    //楼盘详情
    func houseDetailRequest (fid: String, completion: @escaping ([String : AnyObject] ,_ isSuccess : Bool) -> ()){
        
        let base_Url = "http://t.jiwu.com/apps!homeNewDetail.action"
        
        let paramet = ["fid" : fid ] as [String : AnyObject]
        
        JWHTTPManager.sharedRequest.httpRequest(method: .POST, URLString: base_Url, parameters: paramet as [String : AnyObject]) { (json, isSuccess) in
            
            let result = json["Homes"] as? [String : AnyObject] ?? [:]
            
            completion(result,isSuccess)
            
        }
    }
    
    func dynamicRequest(page : Int64, complition:@escaping ([[String : AnyObject]] , _ isSuccess : Bool) -> ()){
        
        let base_url = "http://t.jiwu.com/apps!bbsList.action"
        
        let paramet = ["cityId" : "12" , "page" : "\(page)" , "pageSize" : "10" , "type" : "0,1,2,4"] as [String : AnyObject]
        
        JWHTTPManager.sharedRequest.httpRequest(method : .POST ,URLString: base_url, parameters: paramet) { (dynamicList, isSuccess) in
            
            let result = dynamicList["Agentbbs"] as? [[String : AnyObject]] ?? []
            
            complition(result, isSuccess)
            
        }
    }
}
