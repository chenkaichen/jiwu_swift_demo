//
//  JWHouseDetailModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/14.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWHouseDetailModel: NSObject {
    
    /*均价*/
    var averagePrice: String?
    /*楼盘Id*/
    var bid: String?
    /*楼盘名*/
    var bname: String?
    /*建筑面积*/
    var buildArea: String?
    /*城市Id*/
    var cityId: String?
    /*城市名*/
    var cityName: String?
    /*佣金类型*/
    var commissionText: String?
    /*装修情况*/
    var decoration: String?
    /*开发商*/
    var developer: String?
    /*详情Id*/
    var fid: String?
    /*佣金*/
    var fxsyj: String?
    /*所有在售房源*/
    var hzfy: String?
    /*是否已分享*/
    var isshareRed: String?
    /*结佣公司*/
    var jyCompany: String?
    /*结佣周期*/
    var jyTime: String?
    /*开盘时间*/
    var kpsj: String?
    /*可售套数*/
    var ksts: String?
    /*经度*/
    var latitude: String?
    /*纬度*/
    var longitude: String?
    /*车位数*/
    var parkingNum: String?
    /*物业费*/
    var pmprice: String?
    /*物业公司*/
    var pname: String?
    /*物业类型*/
    var propertyType: String?
    /*占地面积*/
    var totalArea: String?
    /*详情页楼盘图片*/
    var path: String?
    /*楼盘HTML*/
    var buildpath: String?
    
    //MARK: 咱不知道用途
    /*均价*/
    var awardArray: String?
    /*均价*/
    var bbsNumber: String?
    /*均价*/
    var bftime: String?
    /*均价*/
    var bstime: String?
    /*均价*/
    var buildType: String?
    /*均价*/
    var bulkPercentage: String?
    /*均价*/
    var cjCusNumber: String?
    /*均价*/
    var contractts: String?
    /*均价*/
    var countCus: String?
    /*均价*/
    var cusarea: String?
    /*均价*/
    var cusfeature: String?
    /*均价*/
    var designHouseNum: String?
    /*均价*/
    var dyvalue: String?
    /*均价*/
    var filingpattern: String?
    
    /*楼盘图片*/
    var listpic: Array<JWHouseDetailPicModel>?
    /*主力户型*/
    var fname: String?
    
    // 楼盘详情展示图片
    var houseDetailPicS : [JWHouseDetailPicModel]?
    
    
    override var description: String{
        return yy_modelDescription()
        
    }

}
