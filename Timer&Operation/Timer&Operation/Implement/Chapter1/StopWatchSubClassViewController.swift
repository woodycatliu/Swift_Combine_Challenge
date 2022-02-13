//
//  StopWatchSubClassViewController.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import Foundation
import Combine

class StopWatchSubClassViewController: StopWatchViewController {
    private var bag: Set<AnyCancellable> = []
    private let viewModel: Ch1ViewModel = Ch1ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        binding()
    }
    
    private func configureButton() {
        playBtn.addTarget(viewModel, action: #selector(viewModel.startAction), for: .touchUpInside)
        resetBtn.addTarget(viewModel, action: #selector(viewModel.closeAction), for: .touchUpInside)
    }
    
    private func binding() {
        viewModel.$timeStamp
            .receive(on: DispatchQueue.main)
            .map { $0 }
            .assign(to: \.text, on: timestampView)
            .store(in: &bag)
        
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .assign(to: StopWatchSubClassViewController.playButtonConfigure, on: self)
            .store(in: &bag)
    }
}

extension StopWatchSubClassViewController {
    private func playButtonConfigure(_ state: Ch1ViewModel.TimerState) {
        state.playButtonStyle.setButton(playBtn)
    }
}
