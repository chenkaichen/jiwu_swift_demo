//
//  JWHomeHouseCell.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/11.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWHomeHouseCell: UITableViewCell {

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
    
    var houseModel : HouseListModel? {
        
        didSet {
            
            //建筑图
            buildPathImageView.sd_setImage(with: URL(string : (houseModel?.buildPath)!))
            //建筑名
            titleLabel.text = houseModel?.bname
            //地址
            cityLabel.text = "\((houseModel?.cityName)!) - \(( houseModel?.districtName)!)"
            //价格
            priceLabel.text = houseModel?.priceRemark
            //佣金
            commissionLabel.text = "佣金:" + (houseModel?.commission)!
            //奖励说明
            if houseModel?.favorable == "" {
                commssionBaseView.isHidden = true
                maxMargin.constant = 20
                
            }else {
                commssionBaseView.isHidden = false
                maxMargin.constant = 60
                favorableLabel.text = "奖励说明：" + (houseModel?.favorable)!
            
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
