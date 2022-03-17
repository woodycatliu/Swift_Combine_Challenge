//
//  ImpTimingDeviceViewController.swift
//  Timer&Operation
//
//  Created by cm0678 on 2022/3/9.
//

import UIKit
import Combine

class ImpTimingDeviceViewController: TimingDeviceViewController {

    typealias PauseStyle = TimeDeviceMaterial.ButtonStyle.StopButton
    
    private var cancellables = Set<AnyCancellable>()
    
    private var timerCancellable: AnyCancellable?
    
    @Published
    private var timeRemaining: TimeInterval = 0
    
    private var currentPlayState: PlayState = .start
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        observed()
    }
    
    private func setupUI() {
        timeRemaining = viewModel.timing
        countdownViewContainer.isHidden = true
        playBtn.addTarget(self, action: #selector(playBtnDidTap), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtnDidTap), for: .touchUpInside)
    }
    
    private func observed() {
        
        viewModel.$timeCache.sink { [unowned self] timeCache in
            let timeRemaining = timeCache.timeInterval(.hr) + timeCache.timeInterval(.min) + timeCache.timeInterval(.sec)
            self.timeRemaining = timeRemaining
            self.timingCountdownView
                .setCurrentTiming(timeRemaining)
                .maxTimeInterval(timeRemaining)
        }.store(in: &cancellables)
    }
    
    @objc
    private func playBtnDidTap() {
        guard timeRemaining > 0 else { return }
        update(state: currentPlayState)
    }
    
    @objc
    private func cancelBtnDidTap() {
        update(state: .cancel)
    }
    
    private func startTimer() {
        
        let countDownTime = 1.0
        
        timerCancellable = Timer.publish(every: countDownTime, tolerance: nil, on: .main, in: .common, options: nil)
            .autoconnect()
            .scan(timeRemaining, { accumulate, next in accumulate - countDownTime })
            .sink(receiveValue: { [weak self] timeRemaining in
                self?.timeRemaining = timeRemaining
                self?.timingCountdownView.updateCurrent(timeRemaining)
                if timeRemaining <= 0 {
                    self?.update(state: .cancel)
                }
        })
    }
    
    private func stopTimer() {
        timerCancellable?.cancel()
    }
}

extension ImpTimingDeviceViewController {
    
    enum PlayState {
        case start, playback, pause, cancel
    }
    
    private func playAction() {
        countdownViewContainer.isHidden = false
        cancelBtn.isEnabled = true
        ContinueStyle.setButton(playBtn)
        currentPlayState = .pause
        startTimer()
    }
    
    private func pauseAction() {
        PauseStyle.setButton(playBtn)
        currentPlayState = .playback
        stopTimer()
    }
    
    private func cancelAction() {
        countdownViewContainer.isHidden = true
        cancelBtn.isEnabled = false
        StartStyle.setButton(playBtn)
        currentPlayState = .start
        stopTimer()
        timeRemaining = viewModel.timing
        timingCountdownView
            .setCurrentTiming(viewModel.timing)
            .maxTimeInterval(viewModel.timing)
    }
    
    private func update(state: PlayState) {
        switch state {
        case .start, .playback:
            playAction()
        case .pause:
            pauseAction()
        case .cancel:
            cancelAction()
        }
    }
}
