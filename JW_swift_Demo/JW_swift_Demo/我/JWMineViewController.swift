//
//  JWMineViewController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/6/4.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWMineViewController: JWBaseViewController,UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginOutCLick(_ sender: UIBarButtonItem) {
        
        let userDefault = UserDefaults.standard
        
        userDefault.removeObject(forKey: loginUserName)
        userDefault.removeObject(forKey: loginPassWord)
        
        userDefault.synchronize()
        
        let loginStory = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginController")
        
        let mainWindow = UIApplication.shared.keyWindow
        
        mainWindow?.rootViewController = loginStory
        
        mainWindow?.makeKeyAndVisible()
        
    }

    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
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
