//
//  ViewController.swift
//  ciecchron
//
//  Created by s20171105137 on 2018/12/6.
//  Copyright © 2018 s20171105137. All rights reserved.
//

import UIKit

// 对于高度等参数采用宏定义
fileprivate let cRecordH: CGFloat = 40



class ViewController: UIViewController,UIScrollViewDelegate {

    
    
     func viewDidload(){
        super.viewDidLoad()
        let path = Bundle.main.path(forResource:"11",ofType:"png")
        let newImage = UIImage(contentsOfFile: path!)
        picture.image = newImage
        

        //  myView()
        
    }
    
    
    
    
    // 控件
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    var timer: Timer!
    
    
    
    // 数据变量
    var isStart: Bool = false
    var recordCnt: Int = 0
    var msCnt: Int = 0
    var cMaxLabelNum: Int!
    var cButtonH: CGFloat!
    var recordArray: [UILabel]!
    

    
    
    @IBOutlet weak var picture: UIImageView!
    
    
    


    
    
    @IBAction func rightAction(_ sender: UIButton) {//按钮控件
        if !isStart {
            
            isStart = true
            self.setButtonState(leftButton, isEnabled: true)
            self.leftButton.setTitle("记录", for: .normal)
            self.rightButton.setTitle("停止", for: .normal)
            
          self.timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector:#selector(updateTime), userInfo: nil, repeats: true)
            
        }
        else {
            
            isStart = false
            
            self.leftButton.setTitle("复位", for: .normal)
            self.rightButton.setTitle("继续", for: .normal)
            
            self.timer.invalidate()
        }
    }
    
    
    func setButtonState(_ button: UIButton, isEnabled: Bool) {//按钮判断更新函数
        if isEnabled {
            button.isEnabled = true
            button.alpha = 1.0
        }
        else {
            button.isEnabled = false
            button.alpha = 0.5
        }
    }
    
    
    
    
    
    
    @objc func updateTime() {//时间更新函数
        if !isStart {
            let timeStr = String(format: "%02d:%02d:%02d", 0, 0, 0)
            self.timeLabel.text = timeStr
        }
        else {
            msCnt += 1
            let timeStr = String(format: "%02d:%02d:%02d", msCnt/6000, (msCnt/100)%60, msCnt%100)
            self.timeLabel.text = timeStr
        }
    }
    
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return scrollView.subviews[0]
        
    }

    
    
    
    
    
    @IBAction func leftAction(_ sender: UIButton) {//Button和显示记录函数
        if !isStart {
            
            // 重置所有数据
            msCnt = 0
            recordCnt = 0
            updateTime()
            
            self.setButtonState(leftButton, isEnabled: false)
            self.leftButton.setTitle("记录", for: .normal)
            self.rightButton.setTitle("开始", for: .normal)
            
            // 清空所有记录
            for record in recordArray {
                NSLog("%@ removed for superview", record.text!)
                record.removeFromSuperview()
            }
            recordArray.removeAll()
        }
        else {
            
            
            let recordLabel = UILabel()
            recordCnt += 1
            recordLabel.frame = CGRect(x:10, y: self.view.frame.height/4 + CGFloat(recordCnt)*cRecordH, width: self.view.frame.width, height: cRecordH)
            recordLabel.text = String(format:"Record %d:  %@", recordCnt, self.timeLabel.text!)
            recordLabel.font = UIFont.systemFont(ofSize: 20)
            recordLabel.textColor = UIColor.white
            self.view.addSubview(recordLabel)
            recordArray.append(recordLabel)
            NSLog("Record %d", recordCnt)
            if recordCnt==cMaxLabelNum {
                self.leftButton.isEnabled = false
            }
        }
    }
 
    
    
}


let scrollView = UIScrollView()








extension ViewController {//界面style函数
    
    func myView() {
        
        
        // 由于采用深色背景，状态栏设置浅色
        UIApplication.shared.statusBarStyle = .lightContent
        
        // 初始化数据变量
        isStart = false
        cMaxLabelNum = Int(self.view.frame.height/5*2 / cRecordH)
        recordCnt = 0
        msCnt = 0
        recordArray = [UILabel]()
        cButtonH = self.leftButton.frame.width
        
        // 设置按钮形状为圆形
      //  self.rightButton.layer.cornerRadius = cButtonH / 2
      //  self.leftButton.layer.cornerRadius = cButtonH / 2
        
        // 初始化控件属性
        self.updateTime()
        self.setButtonState(leftButton, isEnabled: false)
        self.leftButton.setTitle("记录", for: .normal)
        self.rightButton.setTitle("开始", for: .normal)
    }
    
}

    














    
    
    







