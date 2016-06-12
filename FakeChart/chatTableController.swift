//
//  chatTableController.swift
//  FakeChart
//
//  Created by 三斗 on 6/8/16.
//  Copyright © 2016 com.streamind. All rights reserved.
//

import UIKit
import SnapKit

class chatTableController: UIViewController, UITableViewDelegate,UITextViewDelegate{
  let chartTableView = UITableView()
  let chartTextView = UITextView()
  var inputViewConstraint = NSLayoutConstraint()
  var dataArray = [["name":"ljsandou","message":"如果从第一页滑动到第三页，那么第二页也会快速闪过。这样会导致用户体验比较差。我的思路是首先在第二页的位置上覆盖一个和第一页一模一样的UIView，然后不加动画的切换到第二页。这一瞬间用户感觉不到任何变化。然后再有动画的滑动到第三页。滑动完成之后需要移除这个临时添加的UIView.","imageUrl":"more"],["name":"陈杏红","message":"实际操作远比这个复杂。因为要实现UIViewController的重用，所以在scrollViewDidScroll这个代理方法中需要时刻监听滑动状态并加载下一页。在点击Label的时候需要禁掉这个特性。","imageUrl":"first"],["name":"酷炫狂霸卢机智","message":"UIScrollView调优","imageUrl":"location"]]
  
  var toolBar = UIView()
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutSubView()
    print(dataArray.count)
    chartTableView.delegate = self
    chartTableView.dataSource = self
    chartTextView.delegate = self
    chartTableView.estimatedRowHeight = 100
    chartTableView.rowHeight = UITableViewAutomaticDimension
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(chatTableController.keyboardFrameChanged(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
  }
  override func viewDidDisappear(animated: Bool) {
    super.viewDidAppear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  func layoutSubView(){
    view.addSubview(chartTableView)
    chartTableView.separatorStyle = .None
    chartTableView.snp_makeConstraints { (make) in
      make.top.left.right.equalTo(view)
    }
    
    view.addSubview(toolBar)
    inputViewConstraint = NSLayoutConstraint(item: toolBar,
                                             attribute: .Bottom,
                                             relatedBy: .Equal,
                                             toItem: view,
                                             attribute: .Bottom,
                                             multiplier: 1,
                                             constant: 0)
    
    view.addConstraint(inputViewConstraint)
    toolBar.backgroundColor = UIColor.groupTableViewBackgroundColor()
    toolBar.snp_makeConstraints { (make) in
      make.height.equalTo(40)
      make.width.equalTo(view)
      make.top.equalTo(chartTableView.snp_bottom)
    }
    
    toolBar.addSubview(chartTextView)
    chartTextView.backgroundColor = UIColor.whiteColor()
    chartTextView.layer.masksToBounds = true
    chartTextView.layer.cornerRadius = 4
    chartTextView.returnKeyType = .Send
    chartTextView.snp_makeConstraints { (make) in
      make.left.equalTo(view).offset(20)
      make.right.equalTo(view).offset(-20)
      make.centerY.equalTo(toolBar.snp_centerY)
      make.height.equalTo(30)
    }
  }
  
  func keyboardFrameChanged(notification:NSNotification){
    let dict = NSDictionary(dictionary: notification.userInfo!)
    let keyboardValue = dict.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
    let constant = view.frame.size.height - keyboardValue.CGRectValue().origin.y
    let time = Double(dict.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
    UIView.animateWithDuration(time, animations: {
      self.inputViewConstraint.constant = -constant
      self.view.layoutIfNeeded()
    }) { (finish) in
      let indexPath = NSIndexPath(forRow: self.dataArray.count - 1, inSection: 0)
      self.chartTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
  }
  
  func textViewDidChange(textView: UITextView) {
    
  }
  
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if text == "\n"{
      let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
      let textString = textView.text.stringByTrimmingCharactersInSet(whitespace)
      if textString.characters.count > 0{
        sendMessage(textString)
      }
    }
    return true
  }
  
  func sendMessage(textString:String){
    let oneData = ["name": "ljsandou","message":textString,"imageUrl":"more"]
    dataArray.append(oneData)
    let indexPath = NSIndexPath(forRow: dataArray.count - 1, inSection: 0)
    chartTableView.reloadData()
    self.chartTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
    self.chartTextView.text = ""
  }
}

extension chatTableController:UITableViewDataSource{
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let data = dataArray[indexPath.row]
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? chartContentCell
    if cell == nil{
      cell = chartContentCell(style: .Default, reuseIdentifier: "cell")
    }
    cell?.selectionStyle = .None
    cell?.configWithData(data)
    return cell!
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    view.endEditing(true)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArray.count
  }
}
extension UIScrollView {
  
  func scrollToBottom(animation animation:Bool) {
    let visibleBottomRect = CGRectMake(0, contentSize.height-bounds.size.height, 1, bounds.size.height)
    UIView.animateWithDuration(animation ? 0.2 : 0.01) { () -> Void in
      self.scrollRectToVisible(visibleBottomRect, animated: true)
    }
  }
}