//
//  JWCarouselScrollView.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/22.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWCarouselScrollView: UIView,UIScrollViewDelegate {
    
    private var scrollViewSize : CGSize?
    
    private var scrollImageView : UIScrollView?
    
    private var pageControl : UIPageControl?
    
    /// 重用的三个ImageView
    private var leftImageView , middleImageView , rightImageView : UIImageView?
    /// 当前图片标示
    private var currentIndex : Int = 0
    /// 定时器
    private var timer : Timer?
    
    var blockWithClick : ((Int) -> ())?
    
    /// 设定自动滚动间隔(不能小于0.5)
    var autoScrollDeley : TimeInterval = 0{
        
        didSet{
            self.removeTimer()
            self.setUpTimer()
            
        }
    }
    
    /// 自动轮播，默认三秒
    var isAutoScroll : Bool?{
        
        didSet{
            if isAutoScroll == true{
                autoScrollDeley = 3
                
            }
        }
    }
    
    /// 装图片URL的数组
    var imageArray : [String]? {
        
        didSet{
            pageControl?.numberOfPages = (imageArray?.count)!
            self.changeImage(left: imageArray!.count - 1, middle: currentIndex, right: 1)
            
        }
    }
    
    /// 重写init
    override init(frame : CGRect){
        
        super.init(frame: frame)
        
        scrollViewSize = frame.size
        
        /// 加载重用的imaegView
        loadImageViews()
        
    }
    
    func loadImageViews(){
        /// 初始化scrollView
        scrollImageView = UIScrollView(frame: self.frame)
        scrollImageView?.isPagingEnabled = true
        scrollImageView?.showsHorizontalScrollIndicator = false
        scrollImageView?.delegate = self
        scrollImageView?.contentSize = CGSize(width: (scrollViewSize?.width)! * 3.0, height: 0)
        
        /// 三个重用的imageView
        leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: (scrollViewSize?.width)!, height: (scrollViewSize?.height)!))
        middleImageView = UIImageView(frame: CGRect(x: (scrollViewSize?.width)!, y: 0, width: (scrollViewSize?.width)!, height: (scrollViewSize?.height)!))
        rightImageView = UIImageView(frame: CGRect(x: (scrollViewSize?.width)! * 2.0, y: 0, width: (scrollViewSize?.width)!, height: (scrollViewSize?.height)!))
        
        /// 分页控制
        pageControl = UIPageControl(frame: CGRect(x: 0, y: (scrollViewSize?.height)! -  16, width: (scrollViewSize?.width)!, height: 16))
        pageControl?.center = (scrollImageView?.center)!
//        pageControl?.pageIndicatorTintColor = UIColor.white
        pageControl?.currentPageIndicatorTintColor = UIColor.white
        pageControl?.currentPage = currentIndex
        
        /// 给屏幕中的图片加上点击事件
        middleImageView?.isUserInteractionEnabled = true
        middleImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageClick)))
        
        scrollImageView?.addSubview(leftImageView!)
        scrollImageView?.addSubview(middleImageView!)
        scrollImageView?.addSubview(rightImageView!)
        self.addSubview(scrollImageView!)
        self.addSubview(pageControl!)
    }
    
    /// 图片点击
    func imageClick(){
        blockWithClick?(currentIndex)
        
    }
    
    //MARK: 定时器
    func setUpTimer(){
        
        if autoScrollDeley < 0.5 || isAutoScroll == nil{
            return
            
        }
        
        timer = Timer(timeInterval: autoScrollDeley, target: self, selector: #selector(scrollScroll), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
        
    }
    
    func removeTimer(){
        
        timer?.invalidate()
        timer = nil
        
    }
    
    func scrollScroll(){
        
        //往后翻一页
        scrollImageView?.setContentOffset(CGPoint(x:(scrollImageView?.contentOffset.x)! + (scrollViewSize?.width)!,y:0), animated: true)
        
    }
    
    //MARK: scrollViewDelegate
    /// 开始用手滚动时干掉定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    /// 用手滚动结束时重新添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (autoScrollDeley >= 0.5 && isAutoScroll != nil){
            
            setUpTimer()
        }
        
    }
    
    ///滚动时计算scrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        
        if offsetX >= (scrollImageView?.width)! * 2{
            
            currentIndex += 1
            
            if currentIndex == imageArray?.count {
                
                currentIndex = 0
                self.changeImage(left: (imageArray?.count)! - 1, middle: 0, right: 1)
                
            }else if currentIndex == (imageArray?.count)! - 1{
                self.changeImage(left: currentIndex - 1, middle: (imageArray?.count)! - 1, right: 0)
                
            }else{
                self.changeImage(left: currentIndex - 1, middle:currentIndex, right: currentIndex + 1)
                
            }
        }
        
        if offsetX <= 0 {
            
            currentIndex -= 1
            
            if currentIndex == -1 {
                currentIndex = (imageArray?.count)! - 1
                self.changeImage(left: currentIndex - 1, middle: currentIndex, right: 0)
                
            }else if currentIndex == 0{
                self.changeImage(left:(imageArray?.count)! - 1, middle: 0, right: 1)
                
            }else{
                self.changeImage(left: currentIndex - 1, middle: currentIndex, right:currentIndex + 1)
                
            }
        }
        pageControl?.currentPage = currentIndex
    }
    
    func changeImage(left : Int , middle : Int , right : Int){
        //给重用的三个imageView附上图片
        leftImageView?.sd_setImage(with: URL(string: imageArray![left]))
        middleImageView?.sd_setImage(with: URL(string: imageArray![middle]))
        rightImageView?.sd_setImage(with: URL(string: imageArray![right]))
        
        //为了方便计算，显示在屏幕的其实是第二张图片
        scrollImageView?.setContentOffset(CGPoint(x:(scrollImageView?.width)!,y:0), animated: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
