//
//  JWNavigionBaseViewController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/31.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWNavigionBaseViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1、设置导航栏标题属性：设置标题颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        // 2、设置导航栏背景图片为透明
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        // 3、设置导航栏阴影图片（去掉黑色分割线）
        navigationBar.shadowImage = UIImage()
        
        let navigationBaseView = UIView(frame: CGRect(x: 0, y: -20, width: view.width, height: 64))
        navigationBaseView.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        navigationBaseView.isUserInteractionEnabled = false
        
        if !(navigationBar.subviews.contains(navigationBaseView)) {
            navigationBar.insertSubview(navigationBaseView, at: 0)
            
        }
        
        // 解决不能侧滑返回
        interactivePopGestureRecognizer?.delegate = self

    }

}
