//
//  HouseListViewModel.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import Foundation

class HouseListViewModel {
    
    lazy var houseList = [HouseModel]()
    
    func loadHouseList(page : Int64, isLoadUp : Bool, completion:@escaping (_ isSuccess: Bool) ->()){
    
    JWHTTPManager.sharedRequest.homeRequest(page: page) { (list, isSuccess) in
        
        guard let array = NSArray.yy_modelArray(with: HouseModel.self, json: list) as? [HouseModel] else {
        completion(isSuccess)
            
        return
        }
        
        print(array)
        
        if isLoadUp == true{
            self.houseList = array
            
        }else{
            self.houseList += array
        
        }
        
        completion(isSuccess)
    }
    }
}
