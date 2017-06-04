//
//  JWDynamicViewModel.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/27.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

enum TextSiseType {
    case aline
    case threeline
    case moreline
}

class JWDynamicViewModel: CustomStringConvertible {

    var dynamicModel : JWDynamicModel
    
    /// 是否显示查看全文按钮
    var isHiddenShowAllBtn : Bool = true
    
    /// 内容文本行数
    var contentRows : Int = 3
    
    /// 查看全文按钮展开和收起title
    var showAllButtonTitle : String?
    
    /// 是否是显示全文状态
    var isShowAll : Bool!{
    
        didSet{
            // 当是展开状态设为多行，收起状态设为3行
            contentRows = self.isShowAll! ? 0 : 3
            
            showAllButtonTitle = self.isShowAll! ? "收起全文" : "查看全文"
        
        }
        
    
    }
    
    init(model: JWDynamicModel) {
        
        dynamicModel = model
        isShowAll = false
        showAllButtonTitle = "查看全文"
        
        isHiddenShowAllBtn = !(calculateTextSize(text: model.content!, textSizeType: .moreline).height > calculateTextSize(text: model.content!, textSizeType: .threeline).height)
        
    }
    
    /// 计算文本高度
    ///
    /// - Parameters:
    ///   - text: 计算的文本
    ///   - textSizeType: 是多少行
    /// - Returns: 文本的尺寸
    func calculateTextSize(text: String, textSizeType: TextSiseType) -> CGSize{
        
        var textSize : CGSize!
        
        switch textSizeType {
        case .aline:
            textSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
            break
        case .threeline:
            textSize = CGSize(width: viewWidth - 90, height: ("测试文本" as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil).size.height * 3.0)
            break
        case .moreline:
            textSize = CGSize(width: viewWidth - 90, height: CGFloat(MAXFLOAT))
            break
        }
        
    return (text as NSString).boundingRect(with: textSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil).size
    }
    
    var description: String{
    return dynamicModel.description
        
    }
    
    
}
