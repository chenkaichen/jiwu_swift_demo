//
//  JWDynamicViewModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWDynamicViewModel {

    lazy var dynamicList = [JWDynamicModel]()
    
    func loadDynamicList(page : Int64 , completion : @escaping (_ isSuccess : Bool) -> ()){
        
    JWHTTPManager.sharedRequest.dynamicRequest(page: page) { (dynamicListJson, isSuccess) in
        
        print(dynamicListJson)
        
        guard let result : [JWDynamicModel] = NSArray.yy_modelArray(with: JWDynamicModel.self, json: dynamicListJson) as? [JWDynamicModel] else{
        
            completion(false)
            
            return;
        
        }
        if page == 1{
            self.dynamicList = result
        
        }else{
            self.dynamicList += result
        
        }
        
        completion(true)
    
        }
        
    }
    
}
