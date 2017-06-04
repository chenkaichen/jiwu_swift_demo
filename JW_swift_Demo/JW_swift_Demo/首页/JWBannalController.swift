//
//  JWBannalController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/28.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWBannalController: JWWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "最新活动"
        initLeftButton()
        initRightButton()
        
        loadUrlString(urlString: urlString!)
    
    }
    
    /// 分享
    override func rightBtnClick() {
        
        
    }

}
