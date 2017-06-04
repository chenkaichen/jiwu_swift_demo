//
//  JWDynamicCell.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

@objc protocol JWDynamicDelegate {
    
    @objc optional func showAllButtonIsClick(cell: JWDynamicCell)
    
}

class JWDynamicCell: UITableViewCell {
    
    var viewModel : JWDynamicViewModel?{
        
        didSet {
            
            headImageView.ckc_setHeadImage(urlString: viewModel?.dynamicModel.personpath, placeholdImage: UIImage(named: "默认头像"))
            
            tureNameLabel.text = viewModel?.dynamicModel.truename
            roleNameLabel.text = viewModel?.dynamicModel.rolename
            timeLabel.text = viewModel?.dynamicModel.ctime
            contentLabel.text = viewModel?.dynamicModel.content
            showAllButton.isHidden = (viewModel?.isHiddenShowAllBtn)!
            
            showAllButton.setTitle(viewModel?.showAllButtonTitle, for: .normal)
            
            contentLabel.numberOfLines = (viewModel?.contentRows)!
            
        }
        
    }
    
    /// 显示或收起内容
    @IBOutlet weak var showAllButton: UIButton!
    /// 头像
    @IBOutlet weak var headImageView: UIImageView!
    /// 昵称
    @IBOutlet weak var tureNameLabel: UILabel!
    /// 角色
    @IBOutlet weak var roleNameLabel: UILabel!
    /// 正文
    @IBOutlet weak var contentLabel: UILabel!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    
    public weak var delegate : JWDynamicDelegate?
    
    /// 查看全部按钮点击事件
    @IBAction func showAllButtonClick(_ sender: UIButton) {
        
        let temp = !(viewModel?.isShowAll)!
        
        viewModel?.isShowAll = temp
        
        delegate?.showAllButtonIsClick?(cell: self)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let headClick = UITapGestureRecognizer(target: self, action: #selector(headImageClick))
        
        headImageView.addGestureRecognizer(headClick)
        
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
    
    func headImageClick(){
    
        print("点击了头像按钮")
        
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
