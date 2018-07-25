//
//  ViewController.swift
//  DigitalHuarongRoad
//
//  Created by chuangao.feng on 2018/7/24.
//  Copyright © 2018年 com.csc. All rights reserved.
//

import UIKit

class HR_RootViewController: UIViewController {

    @IBOutlet var buttonCollection: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        for btn in buttonCollection {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            btn.setTitleColor(UIColor.red, for: .normal)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func buttonClick(_ sender: Any) {
        let tag = (sender as! UIButton).tag
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "HR_PlaygroundViewController") as! HR_PlaygroundViewController
        detailVC.row = tag
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

