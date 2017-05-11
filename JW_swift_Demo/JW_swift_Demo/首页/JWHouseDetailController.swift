//
//  JWHouseDetailController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWHouseDetailController: UIViewController {

    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    @IBOutlet weak var doBack: UIBarButtonItem!
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
        
        navigationTitle.title = (sender as! HouseModel).bname
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doBack.target = self
        doBack.action = #selector(back)
        
        // Do any additional setup after loading the view.
    }

    func back (){
    
    dismiss(animated: true) { 
        
        
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
