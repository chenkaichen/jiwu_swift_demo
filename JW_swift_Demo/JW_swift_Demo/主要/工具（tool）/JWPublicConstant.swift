//
//  JWPublicConstant.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/31.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import Foundation
import ReachabilitySwift

/// 屏幕宽
public let viewWidth : CGFloat = UIScreen.main.bounds.width

/// 屏幕高
public let viewHeight : CGFloat = UIScreen.main.bounds.height

public let loginUserName : String = "loginUserName"
public let loginPassWord : String = "loginPassWord"

public func NETWORK_AVILIABLE() -> Bool?{

    let reachability : Reachability?
    
    do {
     
        reachability = Reachability.init()
        
        return reachability?.isReachable
        
    }

}
