//
//  JWWebViewController.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/27.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class JWWebViewController: JWBaseViewController,WKNavigationDelegate{

    var JWWebView : WKWebView?
    
    var urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JWWebView = WKWebView(frame: view.frame);
        JWWebView?.navigationDelegate = self
        view.addSubview(JWWebView!)
        
    }
    
    /// 容错处理：有时候网页没加载出来就返回了，就把进度干掉
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
        
    }
    
    /// 父类实现加载网页
    ///
    /// - Parameter urlString: <#urlString description#>
    func loadUrlString(urlString: String){
        
        JWWebView?.load(URLRequest(url: URL(string: urlString)!))
        
    }
    
    /// 开始加载网页，开启进度
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        SVProgressHUD.show(withStatus: "加载中...")
        
    }
    
    /// 加载完成，干掉进度
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        SVProgressHUD.dismiss()
        
    }
    
    /// 网页加载错误提示
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertView(title: "请求错误", message: error.localizedDescription, delegate: self, cancelButtonTitle: "返回")
        alert.show()
    }

}
