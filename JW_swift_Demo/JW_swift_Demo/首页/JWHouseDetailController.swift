//
//  JWHouseDetailController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//  楼盘详情

import UIKit
import WebKit
import SVProgressHUD

class JWHouseDetailController: JWWebViewController,UIScrollViewDelegate {

    var navigationBaseView : UIView!
    
    @IBOutlet weak var buildImage: UIImageView!
    //楼盘详情Id
    var fid : String?
    
    var pages : Int64 = 0
    
    var tempOffsetY : CGFloat = 0.0
    
    let houseDetailViewModel = JWHouseDetailViewModel()
    
    var tempArr = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        for tempView in (navigationController?.navigationBar.subviews)! {
            if tempView.isMember(of: UIView.self) {
                
                navigationBaseView = tempView
                navigationBaseView.alpha = 0
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLeftButton()
        
        JWWebView?.scrollView.delegate = self
        
        houseDetailViewModel.loadHouseHouseDetail(fid: fid!) { (isSuccess) in
            
            self.navigationItem.title = self.houseDetailViewModel.houseDetailModel.bname!
            
            // 加载网页
            self.loadUrlString(urlString: self.houseDetailViewModel.houseDetailModel.buildpath!)
            
//            let data = NSData.init(contentsOf: URL(string: self.houseDetailViewModel.houseDetailModel.buildpath!)!)
//            
//            let html = String.init(data: data! as Data, encoding: .utf8)
//            
//            self.JWWebView?.loadHTMLString(html!, baseURL: nil)
            
        }
    }
    
    //MARK: WKWebView代理
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        super.webView(webView, didFinish: navigation)
        
        webView.evaluateJavaScript("temptop = document.getElementsByClassName('top-pop')[0];temptop.parentNode.removeChild(temptop);", completionHandler: nil)
        
        webView.evaluateJavaScript("tempNav = document.getElementsByTagName('nav')[0]; tempNav.parentElement.removeChild(tempNav);", completionHandler: nil)
        
        if tempArr.contains((webView.url?.absoluteString)!) == false{
            tempArr.append((webView.url?.absoluteString)!)
            pages += 1
            
            if pages > 1 {
                navigationBaseView?.alpha = 1
                webView.scrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            }
        }
        
    }
    
    override func leftBtnClick(){
        
        if pages > 1 {
            pages -= 1
            JWWebView?.goBack()
        
            if pages == 1 {
                navigationBaseView?.alpha = tempOffsetY / 64.0
                JWWebView?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
            }else{
                navigationBaseView?.alpha = 1
            
            }
            
        }else{
            
            self.navigationController?.popViewController(animated: true)
        
        }
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 在详情第一页滚动时隐藏和显示navigationBar的背景
        if pages  == 1 {
            
            tempOffsetY = scrollView.contentOffset.y
            navigationBaseView.alpha = tempOffsetY / 64.0
        }
        
    }
    
    
    //MARK: UIWebView代理
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        
//        
//        webView.stringByEvaluatingJavaScript(from: "temptop = document.getElementsByClassName('top-pop')[0];temptop.parentNode.removeChild(temptop);")
//        
////        webView.stringByEvaluatingJavaScript(from: "guanggao = document.getElementsByTagName('script')[17];guanggao.parentElement.removeChild(guanggao);")
//        
//        webView.stringByEvaluatingJavaScript(from: "tempNav = document.getElementsByTagName('nav')[0]; tempNav.parentElement.removeChild(tempNav);")
//        
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
