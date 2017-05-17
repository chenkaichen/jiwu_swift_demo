//
//  JWHouseDetailViewModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/14.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

class JWHouseDetailViewModel{
    
    var houseDetailModel = JWHouseDetailModel()
    
    func loadHouseHouseDetail(fid : String, completion:@escaping (_ isSuccess: Bool) ->()){
        
        JWHTTPManager.sharedRequest.houseDetailRequest(fid: fid) { (houseDetail, isSuccess) in
            
            guard let tempModel = JWHouseDetailModel.yy_model(with: houseDetail) else{
                
                completion(isSuccess)
                
                return
            }
            
            let tempJson = try? JSONSerialization.jsonObject(with: (tempModel.fname?.data(using: .utf8))!, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let pics = NSArray.yy_modelArray(with: JWHouseDetailPicModel.self, json: tempJson!)
            
            tempModel.houseDetailPicS = pics as? [JWHouseDetailPicModel]
            
            self.houseDetailModel = tempModel
            
            completion(isSuccess)
            
        }
    }
    
    
}
