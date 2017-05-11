//
//  JWHomeController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/10.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import SDWebImage

class JWHomeController: UITableViewController {

    var headScrollView : UIScrollView?
    var pageControl : UIPageControl?
    
    var timer : Timer?
    var page : Int = 0
    
    // 获取屏幕宽度
    let viewWidth = UIScreen.main.bounds.width
    // 获取屏幕高度
    let viewHeight = UIScreen.main.bounds.height
    //定义广告视图高度
    let bannelViewHeight : CGFloat = CGFloat(400)
    
    let bannelViewModel = BannelViewModel()
    let houselistViewModel = HouseListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "JWHomeHouseCell", bundle: nil), forCellReuseIdentifier: "JWHomeHouseCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        headScrollView = UIScrollView(frame: CGRect(x: 0, y: -bannelViewHeight, width: viewWidth, height: bannelViewHeight))
        
        headScrollView?.delegate = self
        headScrollView?.showsHorizontalScrollIndicator = false
        headScrollView?.isPagingEnabled = true
        tableView.contentInset = UIEdgeInsets(top: bannelViewHeight, left: 0, bottom: 50, right: 0)
        tableView.addSubview(headScrollView!)
        
        loadBannel()
        
        loadHouseList()
    }
    
    //MARK: 加载楼盘
    func loadHouseList(){
    
    houselistViewModel.loadHouseList(page: 0, isLoadUp: true) { (isSuccess) in
        
        self.tableView.reloadData()
        
        }
    }

    //MARK: 加载广告
    func loadBannel(){
        
        bannelViewModel.loadBannelList { (isSuccess) in
            
            for i in 0 ..< self.bannelViewModel.bannelList.count {
                
                let imageView = UIImageView(frame: CGRect(x: self.viewWidth * CGFloat(i), y: 0, width: self.viewWidth, height: self.bannelViewHeight))
                
                imageView.sd_setImage(with: URL(string: self.bannelViewModel.bannelList[i].indexBanner!))
                
                self.headScrollView?.addSubview(imageView)
                
            }
            
            self.headScrollView?.contentSize = CGSize(width: Int(self.viewWidth) * self.bannelViewModel.bannelList.count, height: 0)
            
            self.pageControl = UIPageControl(frame: CGRect(x: 0, y: -200, width: self.viewWidth, height: 50))
            
            self.pageControl?.numberOfPages = self.bannelViewModel.bannelList.count
            self.pageControl?.currentPageIndicatorTintColor = UIColor.white
            
            self.tableView.insertSubview(self.pageControl!, aboveSubview: self.tableView)
            self.addTimer()
            
        }
    }
    
    func nextBannel(){
        
        page = (pageControl?.currentPage)!
        
        if page == (bannelViewModel.bannelList.count - 1) {
            
            page = 0
            
        }else{
            page += 1
        
        }
        
        headScrollView?.setContentOffset(CGPoint(x: CGFloat(page) * (headScrollView?.bounds.width)!, y: 0), animated: true)
        
    }
    
    //MARK: 定时器相关
    func addTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextBannel), userInfo: nil, repeats: true)
        
    }
    
    func removeTimer(){
        timer?.invalidate()
        
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
        
    }
    
    //MARK: 监听scrollView滚动 决定顶部广告的拉伸和 广告视图的滚动
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == tableView {
            
            let scrollY = scrollView.contentOffset.y
            
            //计算缩放比例
            let scale = scrollY / -CGFloat(bannelViewHeight)
            
            if (scrollY < -bannelViewHeight) {
                
                //保证图片始终在最顶部
                var frame = headScrollView?.frame
                frame?.origin.y = scrollY - 10;
                headScrollView?.frame = frame!;
                
                //按比例放大图片
                headScrollView?.transform = CGAffineTransform(scaleX: scale, y: scale)
                
            }
        }
        
        if scrollView == headScrollView {
            pageControl?.currentPage = Int((headScrollView?.contentOffset.x)!) / Int(viewWidth)
            
        }
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }

}
