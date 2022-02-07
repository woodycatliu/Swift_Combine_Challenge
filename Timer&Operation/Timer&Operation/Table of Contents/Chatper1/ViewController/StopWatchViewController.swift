//
//  StopWatchViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/7.
//

import UIKit

class StopWatchViewController: UIViewController {
    let button: UIButton = UIButton()
    let timestampView: TimestampView = TimestampView()
    
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
        view.addSubview(button)
        button.centerXTo(layguid.centerXAnchor)
        button.centerYTo(layguid.centerYAnchor)
    }
    
    private func configureButton() {
        button.withSize(.init(width: 80, height: 35))
        button.backgroundColor = StopWatchMaterial.ButtonStyle.backgroundColor
        button.setTitle(StopWatchMaterial.ButtonStyle.Start.title, for: .normal)
        button.setTitleColor(StopWatchMaterial.ButtonStyle.Start.titleColor, for: .normal)
        button.setTitleColor(StopWatchMaterial.ButtonStyle.Start.highlightedColor, for: .highlighted)
    }
}

