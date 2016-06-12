//
//  chartContentCell.swift
//  FakeChart
//
//  Created by 三斗 on 6/8/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class chartContentCell: UITableViewCell {
  
  var headImageView = UIButton()
  var namelabel = UILabel()
  var messageLabel = UILabel()
  var imageHeightConstraint:NSLayoutConstraint!
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func layoutViews() {
    contentView.addSubview(headImageView)
    headImageView.snp_makeConstraints { (make) in
      make.top.equalTo(contentView).offset(8)
      make.left.equalTo(contentView).offset(8)
      make.height.width.equalTo(50)
      
    }
    
    contentView.addSubview(namelabel)
    namelabel.numberOfLines = 0
    namelabel.snp_makeConstraints { (make) in
      make.top.equalTo(contentView).offset(8)
      make.left.equalTo(headImageView.snp_right).offset(8)
      make.right.equalTo(contentView).offset(-8)
    }
    
    contentView.addSubview(messageLabel)
    messageLabel.numberOfLines = 0
    messageLabel.snp_makeConstraints { (make) in
      make.top.equalTo(namelabel.snp_bottom).offset(20)
      make.left.equalTo(headImageView.snp_right).offset(20)
      make.width.lessThanOrEqualTo(contentView).multipliedBy(0.6)
      make.bottom.equalTo(contentView).offset(-20)
    }
    
    let frameImageView = UIButton()
    contentView.insertSubview(frameImageView, belowSubview: messageLabel)
    frameImageView.clipsToBounds = true
    frameImageView.imageView?.contentMode = .ScaleAspectFit
    frameImageView.setBackgroundImage(UIImage(named: "leftChatForm"), forState: .Normal)
    frameImageView.snp_makeConstraints { (make) in
      make.left.equalTo(headImageView.snp_right).offset(0)
      make.right.equalTo(messageLabel).offset(8)
      make.top.equalTo(namelabel.snp_bottom).offset(8)
      make.bottom.equalTo(messageLabel.snp_bottom).offset(8)
    }
    imageHeightConstraint = NSLayoutConstraint(item: frameImageView,
                                               attribute: .Height,
                                               relatedBy: .LessThanOrEqual,
                                               toItem: nil,
                                               attribute: NSLayoutAttribute.NotAnAttribute,
                                               multiplier: 1,
                                               constant: 1000)
    imageHeightConstraint.priority = UILayoutPriorityRequired
    frameImageView.addConstraint(imageHeightConstraint)
    
  }
  
  func configWithData(dataArray:[String:String]){
    headImageView.setImage(UIImage(named: dataArray["imageUrl"]!), forState: .Normal)
    namelabel.text = dataArray["name"]
    messageLabel.text = dataArray["message"]
  }
  
}
