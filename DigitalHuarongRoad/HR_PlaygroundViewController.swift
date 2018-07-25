//
//  HR_PlaygroundViewController.swift
//  DigitalHuarongRoad
//
//  Created by chuangao.feng on 2018/7/24.
//  Copyright © 2018年 com.csc. All rights reserved.
//

import UIKit
import SnapKit
class HR_PlaygroundViewController: UIViewController {
    var row: Int!
    var itemDictionary = [String:HR_SliderView]()
    var itemWidth: Int!
    var emptyBlock: HR_SliderView!
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemWidth = (Int(view.frame.size.width) - 8) / row
        containerView.snp.makeConstraints { (make) in
            make.width.height.equalTo(Float(itemWidth) * Float(row))
            make.center.equalTo(view)
        }
        for index in 1...Int(row * row) {
            let item = HR_SliderView.init(frame: CGRect(x: (index - 1) % row * itemWidth, y: (index - 1) / row * itemWidth, width: itemWidth, height: itemWidth))
            item.setTitle(title: index)
            item.width = itemWidth
            item.row = row
            item.updateCoordinate(coor: Coordinate(x: (index - 1) % row, y: (index - 1) / row))
            containerView.addSubview(item)
            let key = String(item.coordinate.x) + "_" + String(item.coordinate.y)
            itemDictionary[key] = item
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGusture(gesture:)))
            item.addGestureRecognizer(tap)
            let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeGesutre(gesture:)))
            item.addGestureRecognizer(swipe)
            if index == row * row {
                item.alpha = 0
                emptyBlock = item;
            }
        }
        //随机打乱
        randomSort()
    }
    
    /// 随机排列
    func randomSort() {
        for _ in 0...row * row * 100 {
            let index = Int(arc4random() % UInt32(row * row))
            let key = String(index % row) + "_" + String(index / row)
            let item = itemDictionary[key]!
            moveEmptyBlock(item)
        }
    }
    @objc func swipeGesutre(gesture: UISwipeGestureRecognizer) {
        handleGusture(gesture: gesture)
    }
    @objc func tapGusture(gesture: UITapGestureRecognizer) {
        handleGusture(gesture: gesture)
    }
    func handleGusture(gesture: UIGestureRecognizer) {
        let item = gesture.view as! HR_SliderView
        if item != emptyBlock {
            moveEmptyBlock(item)
            checkisSuccessed()
        }
    }
    func findItemWithCoordinate(cor: Coordinate) -> HR_SliderView {
        let key = converCoordinateToKey(cor)
        return itemDictionary[key]!
    }
    func exchangeInfo(pre: Coordinate,next: Coordinate) {
        let preItem = findItemWithCoordinate(cor: pre)
        let nextItem = findItemWithCoordinate(cor: next)
        swap(&(preItem.coordinate), &(nextItem.coordinate))
        swap(&(preItem.frame), &(nextItem.frame))
        itemDictionary[converCoordinateToKey(nextItem.coordinate)] = nextItem
        itemDictionary[converCoordinateToKey(preItem.coordinate)] = preItem
    }
    func converCoordinateToKey(_ cor: Coordinate) -> String {
        return String(cor.x) + "_" + String(cor.y)
    }
    func moveEmptyBlock(_ item: HR_SliderView)  {
        // 点击的块与空块在竖直轴上
        guard item.coordinate.x == emptyBlock.coordinate.x || item.coordinate.y == emptyBlock.coordinate.y else {
            return
        }
        if item.coordinate.x == emptyBlock.coordinate.x {
            var minY = 0
            var maxY = 0
            if item.coordinate.y > emptyBlock.coordinate.y { // 空白块向下移动
                minY = emptyBlock.coordinate.y
                maxY = item.coordinate.y
                for y in minY ..< maxY {
                    exchangeInfo(pre: Coordinate(x: item.coordinate.x, y: y), next: Coordinate(x: item.coordinate.x, y: y + 1))
                }
            } else { //空白块向上移动
                minY = item.coordinate.y
                maxY = emptyBlock.coordinate.y
                for y in 0 ..< maxY - minY {
                    let p = Coordinate(x: item.coordinate.x, y: maxY - y)
                    let n = Coordinate(x: item.coordinate.x, y: maxY - y - 1)
                    exchangeInfo(pre: p, next: n)
                }
            }
        }
        // 点击的块与空块在水平轴上
        if item.coordinate.y == emptyBlock.coordinate.y {
            var minX = 0
            var maxX = 0
            if item.coordinate.x > emptyBlock.coordinate.x { // 空白块向右移动
                minX = emptyBlock.coordinate.x
                maxX = item.coordinate.x
                for x in minX ..< maxX {
                    exchangeInfo(pre: Coordinate(x: x, y: item.coordinate.y), next: Coordinate(x: x + 1, y: item.coordinate.y))
                }
            } else { //空白块向左移动
                minX = item.coordinate.x
                maxX = emptyBlock.coordinate.x
                for x in 0 ..< maxX - minX {
                    exchangeInfo(pre: Coordinate(x: maxX - x, y: item.coordinate.y), next: Coordinate(x: maxX - x - 1, y: item.coordinate.y))
                }
            }
        }
        
    }
    func checkisSuccessed() {
        if (emptyBlock.coordinate.x == row - 1 && emptyBlock.coordinate.y == row - 1) {
            var successed = true
            for item in itemDictionary.values {
                if item.isCorrect == false {
                    successed = false
                    break
                }
            }
            if successed {
                print("恭喜你成功了")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
