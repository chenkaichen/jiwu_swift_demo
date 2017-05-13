//
//  JWSearchView.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/13.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

enum ClickType {
    case ClickSearchViewType
    case ClickAddressBtnType
}

class JWSearchView: UIView {
    //地址选择视图
    @IBOutlet weak var addressChoiceView: UIView!
    //声明闭包
    typealias completion = (_ clickType : ClickType) -> Void
    //把闭包设置为属性
    var resultCompletion : completion?
    //为闭包设置调用函数
    func clickedMyBtn(result:completion?){
        resultCompletion = result
        
    }
    
    @IBAction func clickSearchView(_ sender: UIButton) {
        //点击按钮时，为闭包赋值
        resultCompletion!(.ClickSearchViewType)
    }
    
    //隐藏地址选择
    func isHiddenAddressChoiceView(){
        
        UIView.animate(withDuration: 0.2, animations: {
            //这里要先等移出屏幕再隐藏，动画才能过渡得比较好
            self.addressChoiceView.y = -64 - self.addressChoiceView.height
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                self.addressChoiceView.isHidden = true
                
            })
        })
    }
    
    //显示地址选择
    func showAddressChoiceView(){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.addressChoiceView.isHidden = false
            self.addressChoiceView.y = 64
            
        })
    }
    
    @IBAction func AddressBtnClick(_ sender: UIButton) {
        
        if addressChoiceView.isHidden == false {
            isHiddenAddressChoiceView()
            
        }else{
            showAddressChoiceView()
            
        }
        
        //点击按钮时，为闭包赋值
        resultCompletion!(.ClickAddressBtnType)
    }
    
}
