//
//  JWHouseDetailViewModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/14.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

class JWHouseDetailViewModel{
    
    var houseDetailModel = JWHouseDetailModel()
    
    /// 加载楼盘详情
    ///
    /// - Parameters:
    ///   - fid: 楼盘详情Id
    ///   - completion: 是否成功
    func loadHouseHouseDetail(fid : String, completion:@escaping (_ isSuccess: Bool) ->()){
        
        JWHTTPManager.sharedRequest.houseDetailRequest(fid: fid) { (houseDetail, isSuccess) in
            
            guard let tempModel = JWHouseDetailModel.yy_model(with: houseDetail) else{
                
                completion(isSuccess)
                
                return
            }
            
            self.houseDetailModel = tempModel
            
            completion(isSuccess)
            
        }
    }
    
    
}
