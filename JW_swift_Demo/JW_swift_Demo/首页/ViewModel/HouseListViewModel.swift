//
//  HouseListViewModel.swift
//  Swift_jiwuhui
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

class HouseListViewModel {
    
    lazy var houseList = [JWHouseViewModel]()
    
    private var page : Int64 = 1
    
    func loadHouseList(completion:@escaping (_ isSuccess: Bool) ->()){
        
        page += 1
        
        JWHTTPManager.sharedRequest.houseListRequest(page: page) { (list, isSuccess) in
            
            if !isSuccess {
                
                completion(false)
                return
            }
            
            var array = [JWHouseViewModel]()
            
            for dict in list {
                
                let model = HouseListModel()
                
                model.yy_modelSet(with: dict)
                
                let viewModel = JWHouseViewModel(model: model)
                
                array.append(viewModel)
                
            }
            
            self.houseList += array
            
            completion(isSuccess)
        }
    }
}
