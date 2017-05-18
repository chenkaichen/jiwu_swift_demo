//
//  JWDynamicController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import MJRefresh

class JWDynamicController: UITableViewController {

    var dynamicPage : Int64 = 0
    
    let dynamicViewModel = JWDynamicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载视图
        tableView.register(UINib.init(nibName: "JWDynamicCell", bundle: nil), forCellReuseIdentifier: "JWDynamicCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        let header = MJRefreshNormalHeader()
        tableView.mj_header = header
        header.setRefreshingTarget(self, refreshingAction: #selector(loadDynamic))
        
        
        let footer = MJRefreshAutoGifFooter()
        tableView.mj_footer = footer
        footer.isAutomaticallyRefresh = false
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreDynamic))
        
        loadDynamic()
        
    }
    
    func loadDynamic(){
        
        dynamicPage = 1
        
        dynamicViewModel.loadDynamicList(page: dynamicPage) { (isSuccess) in
            
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            
        }
        
    }
    
    func loadMoreDynamic(page : Int64){
        
        dynamicPage += 1
        
        dynamicViewModel.loadDynamicList(page: dynamicPage) { (isSuccess) in
            
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
            
        }
    
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dynamicViewModel.dynamicList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : JWDynamicCell = tableView.dequeueReusableCell(withIdentifier: "JWDynamicCell", for: indexPath) as! JWDynamicCell
        
        cell.model = dynamicViewModel.dynamicList[indexPath.row]
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
