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
    
    var headScrollView : JWCarouselScrollView?
    
    var searchView : JWSearchView?
    
    var homePage : Int64 = 0
    
    //搜索透明视图
    var transparentView : UIView?
    // 获取屏幕宽度
    let viewWidth = UIScreen.main.bounds.width
    // 获取屏幕高度
    let viewHeight = UIScreen.main.bounds.height
    //定义广告视图高度
    let bannelViewHeight : CGFloat = CGFloat(400)
    
    let bannelViewModel = BannelViewModel()
    let houselistViewModel = HouseListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBannel()
        
        loadSearchView()
        
        loadHouseList()
        
        let footer = MJRefreshAutoGifFooter()
        tableView.mj_footer = footer
        footer.isAutomaticallyRefresh = false
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadDownHouseList))
    }
    
    //MARK: 加载广告
    func loadBannel(){
        //加载楼盘列表视图
        tableView.register(UINib.init(nibName: "JWHomeHouseCell", bundle: nil), forCellReuseIdentifier: "JWHomeHouseCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // 广告轮播
        headScrollView = JWCarouselScrollView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: bannelViewHeight))
        headScrollView?.blockWithClick = {(clickIndex : Int)->() in
        
            print(clickIndex)
        
        }
        
        
        tableView.contentInset = UIEdgeInsets(top: bannelViewHeight, left: 0, bottom: 0, right: 0)
        tableView.addSubview(headScrollView!)
        
        //从网络请求数据
        bannelViewModel.loadBannelList { (isSuccess) in
            
            var tempArr = [String]()
            
            for i in 0 ..< self.bannelViewModel.bannelList.count {
                
                tempArr.append(self.bannelViewModel.bannelList[i].indexBanner!)
                tempArr.append(self.bannelViewModel.bannelList[i].indexBanner!)
                
            }
            
            self.headScrollView?.imageArray = tempArr
            self.headScrollView?.isAutoScroll = true
            
        }
    }
    
    //加载搜索视图
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
    func loadHouseList(){
        
        houselistViewModel.loadHouseList(page: homePage) { (isSuccess) in
            
            self.tableView.reloadData()
            
        }
    }
    
    //上拉加载
    func loadDownHouseList(){
        
        homePage += 1
        
        houselistViewModel.loadHouseList(page: homePage) { (isSuccess) in
            
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
        
        (segue.destination as! JWHouseDetailController).fid = (sender as? HouseListModel)?.fid
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houselistViewModel.houseList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : JWHomeHouseCell = tableView.dequeueReusableCell(withIdentifier: "JWHomeHouseCell", for: indexPath) as! JWHomeHouseCell
        
        cell.houseModel = houselistViewModel.houseList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: houselistViewModel.houseList[indexPath.row])
        
    }
}
