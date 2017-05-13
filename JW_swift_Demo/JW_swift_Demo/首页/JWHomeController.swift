//
//  JWHomeController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import SDWebImage

class JWHomeController: UITableViewController {
    
    var headScrollView : UIScrollView?
    var pageControl : UIPageControl?
    
    var searchView : JWSearchView?
    
    var transparentView : UIView?
    
    
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
        
        loadBannel()
        
        loadSearchView()
        
        loadHouseList()
    }
    
    //MARK: 加载广告
    func loadBannel(){
        //加载视图
        tableView.register(UINib.init(nibName: "JWHomeHouseCell", bundle: nil), forCellReuseIdentifier: "JWHomeHouseCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        headScrollView = UIScrollView(frame: CGRect(x: 0, y: -bannelViewHeight, width: viewWidth, height: bannelViewHeight))
        
        headScrollView?.delegate = self
        headScrollView?.showsHorizontalScrollIndicator = false
        headScrollView?.isPagingEnabled = true
        tableView.contentInset = UIEdgeInsets(top: bannelViewHeight, left: 0, bottom: 50, right: 0)
        tableView.addSubview(headScrollView!)
        
        //从网络请求数据
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
            
            self.tableView.insertSubview(self.pageControl!, belowSubview: self.searchView!)
            self.addTimer()
            
        }
    }
    
    //加载搜索视图
    func loadSearchView(){
        
        //        let queue = DispatchQueue(label: "addSearchView")
        //
        //        queue.async {
        
        
        transparentView = UIView()
        transparentView?.x = 0
        transparentView?.width = viewWidth
        transparentView?.height = tableView.height
        transparentView?.y = -bannelViewHeight
        
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
        
        
        //        }
        
    }
    
    func transparentViewClick(sender : UITapGestureRecognizer){
        
        self.tableView.isScrollEnabled = true
        sender.view?.isHidden = true
        self.transparentView?.alpha = 0
        searchView?.isHiddenAddressChoiceView()
        
    }
    
    //MARK: 加载楼盘
    func loadHouseList(){
        
        houselistViewModel.loadHouseList(page: 0, isLoadUp: true) { (isSuccess) in
            
            self.tableView.reloadData()
            
        }
    }
    
    //下一页广告
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
                
                //保证图片始终在最顶部
                headScrollView?.y = scrollY - 10
                
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
}
