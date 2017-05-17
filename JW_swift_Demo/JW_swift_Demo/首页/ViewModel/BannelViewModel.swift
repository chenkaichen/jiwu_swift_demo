//
//  BannelViewModel.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

class BannelViewModel {
    
    lazy var bannelList = [BannelModel]()
    
    func loadBannelList(completion:@escaping (_ isSuccess: Bool) ->()){
        
        JWHTTPManager.sharedRequest.bannelRequest { (list, isSuccess) in
            
            guard let array = NSArray.yy_modelArray(with: BannelModel.self, json: list) as? [BannelModel] else {
                completion(isSuccess)
                
                return
            }
            
            self.bannelList = array
            
            completion(isSuccess)
            
        }
    }
}
