//
//  JWHouseDetailController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//  楼盘详情

import UIKit
import WebKit

class JWHouseDetailController: UIViewController,WKNavigationDelegate,UIScrollViewDelegate {

    @IBOutlet weak var buildImage: UIImageView!
    @IBOutlet weak var navigationBaseView: UIView!
    //楼盘详情Id
    var fid : String?
    
    var pages : Int64 = 0
    
    var tempOffsetY : CGFloat = 0.0
    
    let houseDetailViewModel = JWHouseDetailViewModel()
    
    var deTailwebView : WKWebView?
    
    var tempArr = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backUp))
        
        deTailwebView = WKWebView(frame: view.frame)
        deTailwebView?.navigationDelegate = self
        deTailwebView?.scrollView.delegate = self
        
        view.insertSubview(deTailwebView!, belowSubview: navigationBaseView)
        
        // 1、设置导航栏标题属性：设置标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        // 2、设置导航栏背景图片为透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        // 3、设置导航栏阴影图片（去掉黑色分割线）
        navigationController?.navigationBar.shadowImage = UIImage()
        
        houseDetailViewModel.loadHouseHouseDetail(fid: fid!) { (isSuccess) in
            
            self.navigationItem.title = self.houseDetailViewModel.houseDetailModel.bname!
            
//            self.buildImage.setImageWith(URL(string: self.houseDetailViewModel.houseDetailModel.path!)!)
            
            self.deTailwebView?.load(URLRequest(url: URL(string: self.houseDetailViewModel.houseDetailModel.buildpath!)!))
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WKWebView代理
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        let alert = UIAlertView(title: "请求错误", message: error.localizedDescription, delegate: self, cancelButtonTitle: "返回")
        alert.show()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("temptop = document.getElementsByClassName('top-pop')[0];temptop.parentNode.removeChild(temptop);", completionHandler: nil)
        
        webView.evaluateJavaScript("tempNav = document.getElementsByTagName('nav')[0]; tempNav.parentElement.removeChild(tempNav);", completionHandler: nil)
        
        if tempArr.contains((webView.url?.absoluteString)!) == false{
            tempArr.append((webView.url?.absoluteString)!)
            pages += 1
            
            if pages > 1 {
                navigationBaseView.alpha = 1
                webView.scrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            }
        }
        
    }
    
    func backUp(){
        
        if pages > 1 {
            pages -= 1
            deTailwebView?.goBack()
        
            if pages == 1 {
                deTailwebView?.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
            }
            navigationBaseView.alpha = tempOffsetY / 64.0
            
        }else{
            
            self.navigationController?.popViewController(animated: true)
        
        }
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
