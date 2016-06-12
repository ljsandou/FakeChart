//
//  fakeCommentTimeLineCell.swift
//  FakeChart
//
//  Created by 三斗 on 6/10/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit

class fakeCommentTimeLineCell: UITableViewCell {
  
  let headImageView = UIImageView()
  let nameLabel = UILabel()
  let commentlabel = UILabel()
  let commentContentLabel = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func setUpLayout(){
    let topLineLabel = UILabel()
    topLineLabel.backgroundColor = UIColor.lightGrayColor()
    contentView.addSubview(topLineLabel)
    topLineLabel.snp_makeConstraints { (make) in
      make.top.equalTo(contentView)
      make.width.equalTo(1)
      make.height.equalTo(20)
      make.left.equalTo(contentView).offset(25)
    }
    
    contentView.addSubview(headImageView)
    headImageView.snp_makeConstraints { (make) in
      make.top.equalTo(topLineLabel.snp_bottom)
      make.width.height.equalTo(30)
      make.left.equalTo(contentView).offset(10)
    }
    
    
    contentView.addSubview(nameLabel)
    nameLabel.snp_makeConstraints { (make) in
      make.centerY.equalTo(headImageView.snp_centerY)
      make.left.equalTo(contentView).offset(50)
      make.right.equalTo(contentView)
    }
    
    contentView.addSubview(commentlabel)
    commentlabel.snp_makeConstraints { (make) in
      make.left.equalTo(nameLabel)
      make.top.equalTo(nameLabel.snp_bottom).offset(8)
      make.right.equalTo(contentView)
    }
    
    contentView.addSubview(commentContentLabel)
    commentContentLabel.numberOfLines = 0
    commentContentLabel.backgroundColor = UIColor.groupTableViewBackgroundColor()
    commentContentLabel.layer.masksToBounds = true
    commentContentLabel.layer.cornerRadius = 3
    commentContentLabel.snp_makeConstraints { (make) in
      make.top.equalTo(commentlabel.snp_bottom).offset(8)
      make.left.equalTo(nameLabel)
      make.width.lessThanOrEqualTo(contentView).multipliedBy(0.8)
      make.bottom.equalTo(contentView).offset(8)
    }
    
    let bottomLineLabel = UILabel()
    bottomLineLabel.backgroundColor = UIColor.lightGrayColor()
    contentView.addSubview(bottomLineLabel)
    bottomLineLabel.snp_makeConstraints { (make) in
      make.top.equalTo(headImageView.snp_bottom)
      make.left.width.equalTo(topLineLabel)
      make.bottom.equalTo(commentContentLabel.snp_bottom).priorityLow()
    }
    
  }
}
