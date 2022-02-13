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
    }
    
    private var bag: Set<AnyCancellable> = []
    
    private let dateFormatterString: String = StopWatchMaterial.stopWatchDateFormater
    
    @Published
    private(set) var timeStamp: String = "00:00.00"
    
    @Published
    private var state: TimerState = .close
    
    private let stopWatch: StopWatchModel = StopWatchModel()
    
    init() {
        stopWatch.$currentTime
            .map { $0.dateString(self.dateFormatterString) }
            .assign(to: \.timeStamp, weakOn: self)
            .store(in: &bag)
        
        $state
            .assign(to: Ch1ViewModel.stateChangeAction(_:), on: self)
            .store(in: &bag)
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
    func StartAction() {
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


class StopWatchModel {
    @Published
    private(set) var currentTime: TimeInterval = 0
    private var timerTask: AnyCancellable?
    private let everTimeInterval: TimeInterval = 0.01
    
    func timeStart() {
        timerTask?.cancel()
        timerTask = Timer.publish(every: everTimeInterval, tolerance: nil, on: .current, in: .common, options: nil)
            .map { $0.timeIntervalSinceNow }
            .scan(currentTime, +)
            .assign(to: \.currentTime, weakOn: self)
    }
    
    func stop() {
        timerTask?.cancel()
    }
    
    func close() {
        timerTask?.cancel()
        currentTime = 0
    }
    
}
