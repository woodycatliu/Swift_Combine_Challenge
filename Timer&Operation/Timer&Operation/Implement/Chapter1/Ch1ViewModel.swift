//
//  Ch1ViewModel.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import Foundation
import Combine

class Ch1ViewModel {
    enum TimerState {
        case close, stop, start
        
        var playButtonStyle: ButtonStyleParameter.Type {
            switch self {
            case .close:
                return StopWatchMaterial.ButtonStyle.PlayBtn.Start.self
            case .stop:
                return StopWatchMaterial.ButtonStyle.PlayBtn.Start.self
            case .start:
                return StopWatchMaterial.ButtonStyle.PlayBtn.Close.self
            }
        }
    }
        
    private var bag: Set<AnyCancellable> = []
    
    private let dateFormatterString: String = StopWatchMaterial.stopWatchDateFormater
    
    @Published
    private(set) var timeStamp: String = "00:00.00"
    
    @Published
    private(set) var state: TimerState = .close
    
    private let stopWatch: StopWatchModel = StopWatchModel()
    
    init() {
        binding()
    }
    
    func stop() {
        state = .stop
    }
    
    func close() {
        state = .close
    }
    
    func start() {
        state = .start
    }
    
    @objc
    func startAction() {
        switch state {
        case .close:
            start()
        case .stop:
            start()
        case .start:
            stop()
        }
    }
    
    @objc
    func closeAction() {
        close()
    }
}

extension Ch1ViewModel {
    
    private func binding() {
        stopWatch.$currentTime
            .map { $0.dateString(self.dateFormatterString) }
            .assign(to: \.timeStamp, weakOn: self)
            .store(in: &bag)
        
        $state
            .assign(to: Ch1ViewModel.stateChangeAction(_:), on: self)
            .store(in: &bag)
    }
    
    
    private func stateChangeAction(_ state: TimerState) {
        switch state {
        case .close:
            stopWatch.close()
        case .stop:
            stopWatch.stop()
        case .start:
            stopWatch.timeStart()
        }
    }
    
    
}
