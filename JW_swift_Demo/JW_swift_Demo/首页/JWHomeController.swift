//
//  JWHomeController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class JWHomeController: UITableViewController {
    
    /// 头部广告
    var headScrollView : JWCarouselScrollView?
    
    /// 搜索
    var searchView : JWSearchView?
    
    //搜索透明视图
    var transparentView : UIView?
    //定义广告视图高度
    let bannelViewHeight : CGFloat = CGFloat(300)
    
    /// 广告视图模型
    let bannelViewModel = BannelViewModel()
    /// 楼盘列表视图模型
    let houselistViewModel = HouseListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 启动图
        JWLaunchView.showLaunch(imageUrl: "http://cdn.duitang.com/uploads/item/201408/27/20140827062302_ymAJe.jpeg", showTime: 2)
        
        loadBannel()
        
        loadSearchView()
        
        loadHouseList()
    }
    
    //MARK: 加载广告
    /// 加载广告
    func loadBannel(){
        //加载楼盘列表视图
        tableView.register(UINib.init(nibName: "JWHomeHouseCell", bundle: nil), forCellReuseIdentifier: "JWHomeHouseCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        
        // 广告轮播
        headScrollView = JWCarouselScrollView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: bannelViewHeight))
        headScrollView?.blockWithClick = {(clickIndex : Int)->() in
            
            let webView = JWBannalController()
            webView.urlString = self.bannelViewModel.bannelList[clickIndex].bannerUrl
            self.navigationController?.pushViewController(webView, animated: true)
            
            
        }
        
        tableView.contentInset = UIEdgeInsets(top: bannelViewHeight, left: 0, bottom: 0, right: 0)
        tableView.addSubview(headScrollView!)
        
        //从网络请求数据
        bannelViewModel.loadBannelList { (isSuccess) in
            
            var tempArr = [String]()
            
            for i in 0 ..< self.bannelViewModel.bannelList.count {
                
                tempArr.append(self.bannelViewModel.bannelList[i].indexBanner!)
            }
            
            self.headScrollView?.imageArray = tempArr
            self.headScrollView?.isAutoScroll = true
            
        }
    }
    
    //／ 加载搜索视图
    func loadSearchView(){
        
        //        let queue = DispatchQueue(label: "addSearchView")
        //
        //        queue.async {
        
        //        }
        
        transparentView = UIView(frame: CGRect(x: 0, y: -bannelViewHeight, width: viewWidth, height: tableView.height))
        
        transparentView?.backgroundColor = UIColor.black
        transparentView?.alpha = 0.8
        transparentView?.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.transparentViewClick))
        
        transparentView?.addGestureRecognizer(tapGesture)
        
        self.tableView.addSubview(transparentView!)
        
        searchView = Bundle.main.loadNibNamed("JWSearchView", owner: self, options: nil)?.first as? JWSearchView
        
        searchView?.y = -bannelViewHeight
        searchView?.width = viewWidth
        searchView?.alpha = 0
        tableView.addSubview(searchView!)
        
        //接受闭包传值
        searchView?.clickedMyBtn {(clickType) in
            
            if clickType == ClickType.ClickAddressBtnType {
                
                if self.transparentView?.isHidden == false{
                    self.transparentView?.isHidden = true
                    self.tableView.isScrollEnabled = true
                    self.transparentView?.alpha = 0
                    
                }else{
                    self.transparentView?.isHidden = false
                    self.tableView.isScrollEnabled = false
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.transparentView?.alpha = 0.8
                    })
                }
            }else{
                let alterViewController = UIAlertView(title: "暂时没做", message: nil, delegate: self, cancelButtonTitle: "返回")
                
                alterViewController.show()
                
            }
        }
    }
    
    func transparentViewClick(sender : UITapGestureRecognizer){
        
        self.tableView.isScrollEnabled = true
        sender.view?.isHidden = true
        self.transparentView?.alpha = 0
        searchView?.isHiddenAddressChoiceView()
        
    }
    
    //MARK: 加载楼盘
    /// 加载楼盘
    func loadHouseList(){
        
        houselistViewModel.loadHouseList() { (isSuccess) in
            
            self.tableView.reloadData()
            
            self.initLoadMoreFooterView()
        }
    }
    
    func initLoadMoreFooterView(){
    
        if tableView.mj_footer != nil {
            return
        }
        
        let footer = MJRefreshAutoGifFooter()
        footer.isAutomaticallyRefresh = false
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreHouseList))
        tableView?.mj_footer = footer
    
    
    }
    
    //上拉加载
    func loadMoreHouseList(){
        
        houselistViewModel.loadHouseList() { (isSuccess) in
            
            self.tableView.reloadData()
            self.tableView.mj_footer.endRefreshing()
            
        }
    }
    
    //MARK: 监听scrollView滚动 决定顶部广告的拉伸和 广告视图的滚动
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == tableView {
            
            let scrollY = scrollView.contentOffset.y
            
            searchView?.y = scrollY
            transparentView?.y = scrollY
            
            if scrollY > (150 - bannelViewHeight) {
                UIView.animate(withDuration: 0.2, animations: {
                    self.searchView?.alpha = 1
                    
                })
                
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.searchView?.alpha = 0
                    
                })
            }
            
            //计算缩放比例
            let scale = scrollY / -CGFloat(bannelViewHeight)
            
            if (scrollY < -bannelViewHeight) {
                
                //保证图片始终在最顶部（因为缩放回去的时候顶端会有一点空隙，所以往上移了一点）
                headScrollView?.y = scrollY - 10
                
                //按比例放大图片
                headScrollView?.transform = CGAffineTransform(scaleX: scale, y: scale)
                
            }
        }
    }
    
    //跳转传值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        (segue.destination as! JWHouseDetailController).fid = (sender as? JWHouseViewModel)?.houseModel.fid
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houselistViewModel.houseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : JWHomeHouseCell = tableView.dequeueReusableCell(withIdentifier: "JWHomeHouseCell", for: indexPath) as! JWHomeHouseCell
        
        cell.houseViewModel = houselistViewModel.houseList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: houselistViewModel.houseList[indexPath.row])
        
    }
}
