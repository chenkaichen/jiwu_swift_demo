//
//  UIImage+extension.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/26.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import SDWebImage

extension UIImageView{
    
    func ckc_setImage(urlString: String?, placeholdImage: UIImage? = nil){
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                
                image = placeholdImage?.ckc_image(size: self.bounds.size)
                return
        }
        
        sd_setImage(with: url, placeholderImage: placeholdImage, options: [], progress: nil) { (image, _, _, _) in
            
            self.image = image?.ckc_image(size: self.bounds.size)
            
        }
    }

    /// 设置圆形头像
    ///
    /// - Parameters:
    ///   - urlString: url
    ///   - placeholdImage: 默认头像
    func ckc_setHeadImage(urlString: String?, placeholdImage: UIImage?){
    
        guard let urlString = urlString,
             let url = URL(string: urlString) else {
            
            image = placeholdImage?.ckc_headImageClip(size: self.bounds.size)
            return
        }
        
    sd_setImage(with: url, placeholderImage: placeholdImage, options: [], progress: nil) { (image, _, _, _) in
        
           self.image = image?.ckc_headImageClip(size: self.bounds.size)
        
        }
    }
    
    /// 设置切圆楼盘图
    ///
    /// - Parameters:
    ///   - urlString: url
    ///   - placeholdImage: 默认图像
    func ckc_setHouseImage(urlString: String?, placeholdImage: UIImage?){
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                
                image = placeholdImage?.ckc_houseImageClip(size: self.bounds.size)
                return
        }
        
        sd_setImage(with: url, placeholderImage: placeholdImage, options: [], progress: nil) { (image, _, _, _) in
            
            self.image = image?.ckc_houseImageClip(size: self.bounds.size)
            
        }
    }
}
