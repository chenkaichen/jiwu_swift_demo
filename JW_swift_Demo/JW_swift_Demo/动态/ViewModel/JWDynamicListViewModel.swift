//
//  JWDynamicViewModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWDynamicListViewModel {
    
    lazy var dynamicList = [JWDynamicViewModel]()
    
    private var page : Int64 = 0
    
    /// 加载动态
    ///
    /// - Parameters:
    ///   - isLoadMore: 是否上拉加载更多
    ///   - completion: 是否成功
    func loadDynamicList(isLoadMore : Bool , completion : @escaping (_ isSuccess : Bool) -> ()){
        
        if isLoadMore {
            page += 1
            
        }else{
            page = 1
            
        }
        
        JWHTTPManager.sharedRequest.dynamicRequest(page: page) { (dynamicListJson, isSuccess) in
            
            if !isSuccess {
                completion(false)
                return
                
            }
            
            var array = [JWDynamicViewModel]()
            
            // 字典转模型
            for dict in dynamicListJson {
                
                let model = JWDynamicModel()
                
                // 自定转模型
                model.yy_modelSet(with: dict)
                
                //模型转视图模型
                let viewModel = JWDynamicViewModel(model: model)
                
                array.append(viewModel)
                
            }
            
            // 添加视图模型
            if isLoadMore{
                self.dynamicList += array
                
            }else{
                self.dynamicList = array
                
            }
            
            completion(true)
            
        }
        
    }
    
}
