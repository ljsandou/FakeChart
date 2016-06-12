//
//  fakeCommentTimeLine.swift
//  FakeChart
//
//  Created by 三斗 on 6/10/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit
import SnapKit

class fakeCommentTimeLine: UIViewController {
  
  var tableView = UITableView()
  var dynamicArray: [String] = ["他才华横溢能力出众，人生的蓝图早已规划，凭什么还要将就这样的你","","I Love Girl","2015中国控制与决策年会的见闻，综合分析了近年来中国在学术领域取得的突破性进展和国际影响，并着重阐述了在东北大学流程工业综合自动化国家重点实验室的参观经历和感受，对柴天佑院士带领实验室取得的研究成果给予了极高的评价和肯定。",""]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    setUpLayout()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  func setUpLayout(){
    view.addSubview(tableView)
    tableView.separatorStyle = .None
    tableView.snp_makeConstraints { (make) in
      make.center.equalTo(view.snp_center)
      make.width.height.equalTo(view)
    }
  
  }
  
}

extension fakeCommentTimeLine:UITableViewDataSource,UITableViewDelegate{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? fakeCommentTimeLineCell
    if cell == nil{
      cell = fakeCommentTimeLineCell.init(style: .Default, reuseIdentifier: "cell")
      cell?.selectionStyle = .None
    }
    cell?.commentContentLabel.text = dynamicArray[indexPath.row]
    cell?.nameLabel.text = "七月上"
    cell?.commentlabel.text = "评论了你的《不曾错付的时光》"
    cell?.headImageView.image = UIImage(named: "location")
    return cell!
  }

}