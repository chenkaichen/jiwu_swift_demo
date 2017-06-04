//
//  JWHouseViewModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/27.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWHouseViewModel: CustomStringConvertible {

    var houseModel: HouseListModel
    
    /// 拼接地址
    var cityText : String?
    /// 拼接佣金
    var commissionText : String?
    /// 拼接奖励详情
    var favorableText : String?
    /// 判断是否有奖励说明（有的话要加高cell）
    var maxMargin : CGFloat = 0
    /// 是否显示奖励详情
    var isHiddenCommissionView : Bool?
    
    init(model: HouseListModel) {
        
        self.houseModel = model
        
        cityText = "\((model.cityName)!) - \(( model.districtName)!)"
        commissionText = "佣金:" + model.commission!
        
        //奖励说明
        if model.favorable == "" {
            isHiddenCommissionView = true
            maxMargin = 20
            
        }else {
            isHiddenCommissionView = false
            maxMargin = 60
            favorableText = "奖励说明：" + (model.favorable)!
            
        }
        
    }
    
    var description: String{
        
        return houseModel.description
    }
    
}
