//
//  TimingDeviceSubViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/24.
//

import Foundation
import Combine

class TimingDeviceSubViewController: TimingDeviceViewController {
    private var bag: Set<AnyCancellable> = []
    
    var subViewModel: TimingDeviceSubViewModel? {
        return viewModel as? TimingDeviceSubViewModel
    }
    
    override func viewDidLoad() {
        viewModel = TimingDeviceSubViewModel()
        super.viewDidLoad()
        countdownViewContainer.isHidden = true
        bindingViewModel()
        cancelBtn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        playBtn.addTarget(self, action: #selector(playAction), for: .touchUpInside)
    }
    
    func bindingViewModel() {
        subViewModel?.$timeStamp
            .receive(on: DispatchQueue.main)
            .assign(to: timingCountdownView.updateCurrent(_:))
            .store(in: &bag)
            
        subViewModel?.status
            .map { $0 == .close }
            .receive(on: DispatchQueue.main)
            .assign(to: TimingDeviceSubViewController.showTimingDeviceView, on: self)
            .store(in: &bag)
        
        subViewModel?.status
            .map { $0 != .close }
            .assign(to: \.isEnabled, on: cancelBtn)
            .store(in: &bag)
        
        subViewModel?.status
            .assign(to: TimingDeviceSubViewController.updatePlayButtonStyle, on: self)
            .store(in: &bag)
        
        subViewModel?.$timeCache
            .map { $0.totalDuration }
            .receive(on: DispatchQueue.main)
            .assign(to: timingCountdownView.updateMaxTimeInterval(_:))
            .store(in: &bag)
    }
    
}

extension TimingDeviceSubViewController {
    
    func updatePlayButtonStyle(_ status: TimingDeviceViewModel.Status) {
        switch status {
        case .start:
            TimeDeviceMaterial.ButtonStyle.StopButton.setButton(playBtn)
        case .stop:
            TimeDeviceMaterial.ButtonStyle.ContinueButton.setButton(playBtn)
        case .close:
            TimeDeviceMaterial.ButtonStyle.StartButton.setButton(playBtn)
        }
    }
    
    func showTimingDeviceView(_ isHidden: Bool) {
        countdownViewContainer.isHidden = isHidden
    }
    
    @objc func cancelAction() {
        subViewModel?.close()
    }
    
    @objc func playAction() {
        subViewModel?.playBtnAction()
    }
}