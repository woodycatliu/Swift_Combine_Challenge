//
//  ViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .dark
        let subVC = TimingDeviceViewController()
        self.addChild(subVC)
        view.addSubview(subVC.view)
        subVC.view.fillSuperview()
    }
}
