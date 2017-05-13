//
//  HouseModel.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class HouseModel: NSObject {
    
    /*楼盘名 */
    var bname: String?
    /*楼盘图*/
    var buildPath: String?
    /*楼盘物业类型 多个用逗号隔开(CRM住宅显示住，别墅显示别，公寓显示寓，写字楼显示写，商铺显示铺，厂房显示长，SOHO显示SO，LOFT显示LO)*/
    var buildType: String?
    /*楼盘所属城市名*/
    var cityName: String?
    /*楼盘所属城市区*/
    var districtName: String?
    /*均价*/
    var priceRemark: String?
    /*佣金(佣金小于100为百分比提成)*/
    var commission: String?
    /*奖励说明*/
    var favorable: String?
    
    /*奖励信息*/
//    var awardinfo: String?
//    
//    /*参与经纪人数*/
//    var countCus: String?

}
