//
//  UIImage+extension.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/26.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

extension UIImage{
    
    /// 切圆形头像
    ///
    /// - Parameters:
    ///   - size: 图片大小
    ///   - backGroundColor: 图片背景颜色
    ///   - lineColor: 头像边框颜色
    /// - Returns: 切好的头像
    func ckc_headImageClip(size: CGSize?, backGroundColor: UIColor = UIColor.white, lineColor: UIColor = UIColor.black) -> UIImage?{
        
        var size = size
        
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        //1 图像上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        //2 填充背景颜色
        backGroundColor.setFill()
        UIRectFill(rect)
        
        //3 绘制圆形
        //(1)获得剪切路径
        let path = UIBezierPath(ovalIn: rect)
        //(2)剪切
        path.addClip()
        
        //4 绘图
        self.draw(in: rect)
        
        //5 设置切好的图的边框
        lineColor.setStroke()
        path.lineWidth = 0.5
        path.stroke()
        
        //5 取得图像
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //6 关闭上下文
        UIGraphicsEndImageContext()
        
        //7 返回结果
        return resultImage
          
    }
    
    /// 切圆楼盘图
    ///
    /// - Parameters:
    ///   - size: 图片大小
    ///   - backGroundColor: 背景颜色
    /// - Returns: 切好的图片
    func ckc_houseImageClip(size: CGSize?, backGroundColor: UIColor = UIColor.white) -> UIImage?{
        
        var size = size
        
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        //1 图像上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        //2 填充背景颜色
        backGroundColor.setFill()
        UIRectFill(rect)
        
        //3 绘制圆角为5
        //(1)获得剪切路径
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 3)
        //(2)剪切
        path.addClip()
        
        //4 绘图
        self.draw(in: rect)
        
        //5 取得图像
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //6 关闭上下文
        UIGraphicsEndImageContext()
        
        //7 返回结果
        return resultImage
        
    }
    
    /// 优化图片
    ///
    /// - Parameters:
    ///   - size: 图片大小
    ///   - backGroundColor: 背景颜色
    /// - Returns: 优化的图片
    func ckc_image(size: CGSize?, backGroundColor: UIColor = UIColor.white) -> UIImage?{
        
        var size = size
        
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        //1 图像上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        //2 填充背景颜色
        backGroundColor.setFill()
        UIRectFill(rect)
        
        //3 绘图
        self.draw(in: rect)
        
        //4 取得图像
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //5 关闭上下文
        UIGraphicsEndImageContext()
        
        //6 返回结果
        return resultImage
        
    }
}
