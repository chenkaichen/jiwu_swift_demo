//
//  JWDynamicCell.swift
//  JW_swift_Demo
//
//  Created by 陈开琛 on 2017/5/18.
//  Copyright © 2017年 陈开琛. All rights reserved.
//

import UIKit

class JWDynamicCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var tureNameLabel: UILabel!
    @IBOutlet weak var roleNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model : JWDynamicModel?{
    
        didSet{
            
            headImageView.sd_setImage(with: URL(string: (model?.personpath)!), placeholderImage: UIImage(named: "默认头像"))
            
            tureNameLabel.text = model?.truename
                roleNameLabel.text = model?.rolename
            timeLabel.text = model?.ctime
            contentLabel.text = model?.content
        
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
