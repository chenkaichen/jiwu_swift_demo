//
//  JWDynamicModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWDynamicModel: NSObject {
    
    //动态详情
    var content : String?
    //发布时间
    var ctime : String?
    //动态详情Id
    var fid : String?
    //动态图片
    var paths : String?
    //头像
    var personpath : String?
    //已点赞
    var praiseNumber : String?
    //点赞人
    var praisename : String?
    //评论
    var remark : String?
    //身份
    var rolename : String?
    //评论数
    var replynum : String?
    //昵称
    var truename : String?
    //动态类型
    var type : String?
    //楼盘动态分享URL
    var buildpath : String?
    
    
    //FIXME: 不知道有什么用
    var agentname : String?
    var badNum : String?
    var booPrase : String?
    var cityid : String?
    var fname : String?
    var id : String?
    var isTop : String?
    var jid : String?
    var mobile : String?
    var openbad : String?
    var opencomment : String?
    var parentid : String?
    
    
    
//    "remark": {
//    "Agentbbs": [{
//				"beReplyJid": 0,
//				"beReplyJname": "",
//				"content": "为啥发布新房源明明就说个几楼面积单价总价南户就是违反广告不能发布的呢",
//				"ctime": "2017-05-16 22:05:25",
//				"jid": 195396,
//				"replyType": 1,
//				"truename": "宋清云"
//    }],
//    "number": 3,
//    "result": 0
//    },
 
    override var description: String{
    return yy_modelDescription()
    
    }
    
}
