//
//  JWLoginViewController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/6/4.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWLoginViewController: UIViewController,WXApiDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnClick(_ sender: UIButton) {
        
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        WXApi.send(req)
        
//        //构造SendAuthReq结构体
//        SendAuthReq* req =[[SendAuthReq alloc ]init];
//        req.scope = @"snsapi_userinfo" ;
//        //        req.state = @"XinyuanChedu" ;
//        
//        //第三方向微信终端发送一个SendAuthReq消息结构
//        [WXApi sendReq:req];
        
    }

    func onResp(_ resp: BaseResp!) {
        
        print(resp)
        
        if resp.errCode == 0 {
            
            let userDefault = UserDefaults.standard
            
            userDefault.set("chenkaichen", forKey: loginPassWord)
            userDefault.set("123456", forKey: loginUserName)
            
            userDefault.synchronize()
            
            let tabbar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "baseTabbarController")
            
            let mainWindow = UIApplication.shared.keyWindow
            
            mainWindow?.rootViewController = tabbar
            
            mainWindow?.makeKeyAndVisible()
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
