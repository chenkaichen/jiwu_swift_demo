//
//  JWHouseDetailPicModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/15.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWHouseDetailPicModel: NSObject {
    
    /*类型*/
//    var albumname: String?
//    /*图片数组*/
//    var piclist: String?
    
    /*占地面积*/
    var area: String?
    /*名字*/
    var name: String?
    /*图片*/
    var path: String?
    /*价格*/
    var price: String?
    /*备注*/
    var remark: String?
    
    override var description: String{
        return yy_modelDescription()
        
    }
}
