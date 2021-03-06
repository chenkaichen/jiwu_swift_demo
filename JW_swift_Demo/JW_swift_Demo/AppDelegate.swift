//
//  AppDelegate.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        WXApi.registerApp("wx16b656007fd46f35")
        
       let userDefault = UserDefaults.standard
        
        if !((userDefault.object(forKey: loginUserName) != nil)
            &&
            (userDefault.object(forKey: loginPassWord) != nil)){
            
            let loginStory = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginController")
            
            window?.rootViewController = loginStory
            
            window?.makeKeyAndVisible()
            
            print("come to here  ----没有登录")
            
        }
        
        userDefault.synchronize()
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return WXApi.handleOpen(url, delegate: JWLoginViewController() as WXApiDelegate)
        
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        
        return WXApi.handleOpen(url, delegate: JWLoginViewController() as WXApiDelegate)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

