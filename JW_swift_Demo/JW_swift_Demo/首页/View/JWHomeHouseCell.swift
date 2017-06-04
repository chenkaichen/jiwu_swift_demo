//
//  JWHomeHouseCell.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWHomeHouseCell: UITableViewCell {
    
    var houseViewModel : JWHouseViewModel?{
        
        didSet{
            //建筑图
            buildPathImageView.ckc_setHouseImage(urlString: houseViewModel?.houseModel.buildPath, placeholdImage: UIImage(named: "楼盘默认图"))
            
            //建筑名
            titleLabel.text = houseViewModel?.houseModel.bname
            //地址
            cityLabel.text = houseViewModel?.cityText
            //价格
            priceLabel.text = houseViewModel?.houseModel.priceRemark
            //佣金
            commissionLabel.text = houseViewModel?.commissionText
            //自动拉伸决定行高
            maxMargin.constant = (houseViewModel?.maxMargin)!
            //是否显示奖励说明
            commssionBaseView.isHidden = (houseViewModel?.isHiddenCommissionView)!
            
            favorableLabel.text = houseViewModel?.favorableText
            
        }
    }

    //决定行高的约束
    @IBOutlet weak var maxMargin: NSLayoutConstraint!
    //楼盘图
    @IBOutlet weak var buildPathImageView: UIImageView!
    // 楼盘名
    @IBOutlet weak var titleLabel: UILabel!
    /**
     *  用来装楼盘类型的View
     *  动态长度，每增加一个楼盘类型的label就跟着增长
     */
    @IBOutlet weak var buildTypeView: UIView!
    //地址
    @IBOutlet weak var cityLabel: UILabel!
    // 价格
    @IBOutlet weak var priceLabel: UILabel!
    //佣金
    @IBOutlet weak var commissionLabel: UILabel!
    //奖励说明
    @IBOutlet weak var favorableLabel: UILabel!
    //奖励说明背景视图
    @IBOutlet weak var commssionBaseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        // cell 优化，要尽量减少图层的数量，相当于就只有一层！
        // 停止滚动之后，可以接收监听
        self.layer.shouldRasterize = true
        
        // 使用 `栅格化` 必须注意指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
