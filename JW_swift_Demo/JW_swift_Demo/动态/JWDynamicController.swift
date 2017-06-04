//
//  JWDynamicController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import MJRefresh

class JWDynamicController: JWBaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    let dynamicViewModel = JWDynamicListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载视图
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height))
        tableView?.separatorStyle = .none
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        
        tableView?.register(UINib.init(nibName: "JWDynamicCell", bundle: nil), forCellReuseIdentifier: "JWDynamicCell")
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 200
        
        loadDynamic()
        
        let header = MJRefreshNormalHeader()
        tableView?.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(loadDynamic))
        
    }
    
    func loadDynamic(){
        
        dynamicViewModel.loadDynamicList(isLoadMore: false) { (isSuccess) in
            
            self.tableView?.reloadData()
            self.tableView?.mj_header.endRefreshing()
            
            // 当有第一页数据时才添加上拉加载
            self.initFooterView()
            
        }
    }
    
    // 添加上拉加载
    func initFooterView(){
        
        if tableView?.mj_footer != nil {
            return
        }
        
        let footer = MJRefreshAutoGifFooter()
        footer.isAutomaticallyRefresh = false
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreDynamic))
        tableView?.mj_footer = footer
    }
    
    /// 加载更多
    ///
    /// - Parameter page: 页码
    func loadMoreDynamic(){
        
        dynamicViewModel.loadDynamicList(isLoadMore: true) { (isSuccess) in
            
            self.tableView?.reloadData()
            self.tableView?.mj_footer.endRefreshing()
            
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dynamicViewModel.dynamicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let idenfifier : String = "JWDynamicCell"
        
        let cell : JWDynamicCell = tableView.dequeueReusableCell(withIdentifier: idenfifier, for: indexPath) as! JWDynamicCell
        
        cell.viewModel = dynamicViewModel.dynamicList[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
    }
    
}

extension JWDynamicController : JWDynamicDelegate{

    func showAllButtonIsClick(cell: JWDynamicCell) {
        
        let tempIndexPath = tableView?.indexPath(for: cell)
        
        tableView?.beginUpdates()
        tableView?.reloadRows(at: [tempIndexPath!], with: .none)
        tableView?.endUpdates()
        
    }

}
