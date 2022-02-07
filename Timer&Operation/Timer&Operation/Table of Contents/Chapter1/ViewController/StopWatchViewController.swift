//
//  StopWatchViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/7.
//

import UIKit
class ViewController: UIViewController {

//class StopWatchViewController: UIViewController {
    private let playBtn: UIButton = UIButton()
    private let resetBtn: UIButton = UIButton()
    private let timestampView: TimestampView = TimestampView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureButton()
    }
    
    private func configure() {
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(timestampView)
        timestampView.centerInSuperview(yConstant: -UIScreen.height / 10)
        let layguid = UILayoutGuide()
        view.addLayoutGuide(layguid)
        NSLayoutConstraint.activate([
            layguid.topAnchor.constraint(equalTo: timestampView.bottomAnchor),
            layguid.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            layguid.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            layguid.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.addSubview(playBtn)
        playBtn.centerXTo(layguid.centerXAnchor)
        playBtn.centerYTo(layguid.centerYAnchor)
        
        view.addSubview(resetBtn)
        resetBtn.centerXTo(layguid.centerXAnchor)
        resetBtn.anchor(top: nil, leading: nil, bottom: layguid.bottomAnchor, trailing: nil)
    }
    
    private func configureButton() {
        StopWatchMaterial.ButtonStyle.PlayBtn.setButton(playBtn)
        StopWatchMaterial.ButtonStyle.PlayBtn.Start.setButton(playBtn)
        
        StopWatchMaterial.ButtonStyle.ResetBtn.setButton(resetBtn)
        StopWatchMaterial.ButtonStyle.ResetBtn.Reset.setButton(resetBtn)
    }
}

