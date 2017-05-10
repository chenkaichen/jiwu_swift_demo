//
//  BannelViewModel.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/9.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class BannelViewModel {
    
    
    lazy var bannelList = [BannelModel]()
    
    func loadBannelList(completion:@escaping (_ isSuccess: Bool) ->()){
        
        JWHTTPManager.sharedRequest.posterRequest { (list, isSuccess) in
            
            guard let array = NSArray.yy_modelArray(with: BannelModel.self, json: list) as? [BannelModel] else {
                completion(isSuccess)
                
                return
            }
            
            self.bannelList = array
            
            completion(isSuccess)
            
            
        }
    }
    
    
}
