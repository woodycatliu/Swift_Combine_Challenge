//
//  StopWatchViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/7.
//

import UIKit
import Combine

class StopWatchViewController: UIViewController {
    
    let playBtn: UIButton = UIButton()
    let resetBtn: UIButton = UIButton()
    let timestampView: TimestampView = TimestampView()
    
    private let viewModel = StopWatchViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        configure()
        configureButton()
        observed()
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
        playBtn.addTarget(self, action: #selector(playBtnDidTap), for: .touchUpInside)
        
        view.addSubview(resetBtn)
        resetBtn.centerXTo(layguid.centerXAnchor)
        resetBtn.anchor(top: nil, leading: nil, bottom: layguid.bottomAnchor, trailing: nil)
        resetBtn.addTarget(self, action: #selector(resetBtnDidTap), for: .touchUpInside)
    }
    
    private func configureButton() {
        StopWatchMaterial.ButtonStyle.PlayBtn.setButton(playBtn)
        StopWatchMaterial.ButtonStyle.PlayBtn.Start.setButton(playBtn)
        
        StopWatchMaterial.ButtonStyle.ResetBtn.setButton(resetBtn)
        StopWatchMaterial.ButtonStyle.ResetBtn.Reset.setButton(resetBtn)
    }
    
    @objc
    private func playBtnDidTap() {
        viewModel.isActive.toggle()
        let playBtnTitle = viewModel.isActive ? "STOP" : "START"
        playBtn.setTitle(playBtnTitle, for: .normal)
    }
    
    @objc
    private func resetBtnDidTap() {
        viewModel.resetCount()
    }
    
    private func observed() {
        
        viewModel.$time.sink { [weak self] time in
            self?.timestampView.text = self?.formatDate(timeInterval: time)
        }.store(in: &cancellables)
    }
    
    private func formatDate(timeInterval: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss.SS"
        return dateFormatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
}

/*
 RunLoop.main vs DispatchQueue.main: The differences explained
 https://www.avanderlee.com/combine/runloop-main-vs-dispatchqueue-main/
 */
