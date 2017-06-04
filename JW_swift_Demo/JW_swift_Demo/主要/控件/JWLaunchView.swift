//
//  JWLaunchView.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/29.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWLaunchView: UIView {
    
    /// 显示秒数
    private var showTimeCount : Int = 0
    /// 倒计时定时器
    private var showTimeTimer : Timer?
    /// 倒计时按钮
    private var countButton = UIButton()
    /// 启动图
    private var lauchImageView = UIImageView()
    
    /// 显示启动图
    ///
    /// - Parameters:
    ///   - imageUrl: 图片地址
    ///   - showTime: 显示时间
    static func showLaunch(imageUrl: String?, showTime: Int){
        
        let launchView = JWLaunchView()
        
        guard let imageUrl: String = imageUrl else { return  }
        
        launchView.lauchImageView.frame = launchView.bounds
        launchView.addSubview(launchView.lauchImageView)
        
        // 加载图片过程可能比较慢，会出现界面比启动图更早出现，用一张默认图片来覆盖
        launchView.lauchImageView.ckc_setImage(urlString: imageUrl,placeholdImage: UIImage(named: "640X1136_1-1"))
        
        let btnW : CGFloat = 60
        let btnH : CGFloat = 30
        
        launchView.countButton.frame = CGRect(x: launchView.width - btnW - 20, y: btnH, width: btnW, height: btnH)
        launchView.countButton.setTitleColor(.white, for: .normal)
        launchView.countButton.setTitle("跳过 \(showTime)", for: .normal)
        launchView.countButton.backgroundColor = UIColor.init(white: 0.2, alpha: 0.6)
        launchView.countButton.layer.cornerRadius = 4
        launchView.countButton.addTarget(launchView, action: #selector(hiddenLaunch), for: .touchUpInside)
        launchView.addSubview(launchView.countButton)
        
        launchView.showTimeTimer = Timer.scheduledTimer(timeInterval: 1, target: launchView, selector: #selector(showTimeDown), userInfo: nil, repeats: true)
        launchView.showTimeCount = showTime
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(launchView)
        
    }
    
    /// 更新版本之后第一次显示APP介绍
    ///
    /// - Parameter images: APP介绍图片
    static func showLaunchWithUpdata(images: [String]){
        
        let launchView = JWLaunchView()
        launchView.initImageViews(images: images)
        
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(launchView)
    
    }
    
    /// 创建展示图片的scrollView（待实现，当有版本更新时再做）
    ///
    /// - Parameter images: 展示图片集
    private func initImageViews(images: [String ]){
        
        for image in images {
            
            print(image)
            
            if image == images.last {
                
                print("woshi zuihouyige")
                
            }
        }
    }
    
    /// 倒计时
    @objc private func showTimeDown(){
        
        showTimeCount -= 1
        
        countButton.setTitle("跳过 \(showTimeCount)", for: .normal)
        
        if showTimeCount == 0{
            
            hiddenLaunch()
        }
    }
    
    /// 隐藏启动图
    @objc private func hiddenLaunch(){
        
        showTimeTimer?.invalidate()
        showTimeTimer = nil
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.alpha = 0
            
        }) { (isFinish) in
            
            self.removeFromSuperview()
        }
    }
    
    /// 创建启动图
    private init() {
        
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
