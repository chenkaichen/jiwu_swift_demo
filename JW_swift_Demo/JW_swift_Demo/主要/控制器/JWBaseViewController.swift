//
//  JWBaseViewController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/27.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

/// 按钮类型：在创建导航栏按钮时传入的类型
///
/// - ButtonSharedType: 分享
/// - ButtonBackType: 返回
enum ButtonType {
    case ButtonSharedType
    case ButtonBackType
}

class JWBaseViewController: UIViewController {
    
    var tableView : UITableView?
    
    /// 因为首页隐藏了导航栏，在后面创建的控制器必须要把导航栏显示
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    /// 添加导航栏左边按钮
    ///
    /// - Parameter buttonType: 按钮类型
    func initLeftButton(buttonType: ButtonType = .ButtonBackType){
        
        // 因为没有图片，所以把向下的图片改变一下做返回图片
        let backImage : UIImage = #imageLiteral(resourceName: "下箭头")
        let hImage = UIImage(cgImage: backImage.cgImage!, scale: 1, orientation: .right)
        
        /// 暂时先不做图片优化，因为没有正确的图片
//        let hImage = UIImage(cgImage: backImage.cgImage!, scale: 1, orientation: .right).ckc_image(size: backImage.size)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: hImage, style: .done, target: self, action: #selector(leftBtnClick))
        
    }
    
    /// 左边按钮点击事件
    func leftBtnClick(){
        navigationController?.popViewController(animated: true)
        
    }
    
    /// 添加导航栏右边按钮
    ///
    /// - Parameter buttonType: 按钮类型
    func initRightButton(buttonType: ButtonType = .ButtonSharedType){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "分享"), style: .done, target: self, action: #selector(rightBtnClick))
        
    }
    
    /// 右边按钮点击事件
    func rightBtnClick(){
        
    }
    
}
