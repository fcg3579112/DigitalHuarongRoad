//
//  HR_SliderView.swift
//  DigitalHuarongRoad
//
//  Created by chuangao.feng on 2018/7/24.
//  Copyright © 2018年 com.csc. All rights reserved.
//

import UIKit

struct Coordinate: Hashable {
    var x: Int
    var y: Int
}
class HR_SliderView: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //坐标
    var coordinate: Coordinate!
    
    var row: Int!
    
    var count: Int!
    
    var width: Int!
    
    var titleLabel: UILabel!
    
    var isCorrect:Bool {
        if count % row == coordinate.x && count / row == coordinate.y {
            return true
        }
        return false
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.orange
        titleLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setTitle(title: Int) {
        titleLabel.text = String(title)
        count = title - 1
    }
    
    func updateCoordinate(coor: Coordinate) {
        coordinate = coor
        self.frame = CGRect(x: coor.x * width, y: coor.y * width, width: width, height: width)
    }
    /// 判断当前滑块上下左右4个方向是否有空白地方，然后朝空白地方滑过去
    func move(to destination: HR_SliderView) {
        if self.coordinate.x + 1 == destination.coordinate.x && self.coordinate.y == destination.coordinate.y{
            exchange(destination)
            return
        } else if self.coordinate.x - 1 == destination.coordinate.x && self.coordinate.y == destination.coordinate.y {
            exchange(destination)
            return
        }else if self.coordinate.x == destination.coordinate.x && self.coordinate.y + 1 == destination.coordinate.y {
            exchange(destination)
            return
        }else if self.coordinate.x == destination.coordinate.x && self.coordinate.y - 1 == destination.coordinate.y {
            exchange(destination)
            return
        }
    }
    func exchange(_ emtpy: HR_SliderView) {
        swap(&(emtpy.coordinate), &(self.coordinate))
        swap(&(emtpy.frame), &(self.frame))
    }
}

