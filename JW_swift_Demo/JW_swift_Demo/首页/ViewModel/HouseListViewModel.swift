//
//  HouseListViewModel.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

class HouseListViewModel {
    
    lazy var houseList = [HouseListModel]()
    
    func loadHouseList(page : Int64, completion:@escaping (_ isSuccess: Bool) ->()){
        
        JWHTTPManager.sharedRequest.houseListRequest(page: page) { (list, isSuccess) in
            
            guard let array = NSArray.yy_modelArray(with: HouseListModel.self, json: list) as? [HouseListModel] else {
                completion(isSuccess)
                
                return
            }
            self.houseList += array
            
            completion(isSuccess)
        }
    }
}
