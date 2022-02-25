//
//  TimingDeviceSubViewModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/24.
//

import Foundation
import Combine
import ImageIO

class TimingDeviceSubViewModel: TimingDeviceViewModel {
    private var bag: Set<AnyCancellable> = []

    @Published
    private(set) var timeStamp: TimeInterval = 0
    
    private(set) var status: CurrentValueSubject<Status, Never> = .init(.close)
    
    private var timingTask: AnyCancellable? {
        didSet {
            if timingTask != nil { status.send(.start)}
        }
    }
    
    private func startTime(duration: TimeInterval) {
        let completion: (Subscribers.Completion<Never>)-> () = { [weak self] in
            guard case Subscribers.Completion<Never>.finished = $0 else { return }
            self?.close()
        }
        
        let receiveValue: (TimeInterval)-> Void = { [weak self] in
            self?.timeStamp = $0
        }
        
        timingTask = Timer.TimingPublisher(duration: duration)
            .print()
            .sink(receiveCompletion: completion, receiveValue: receiveValue)
            
    }
    
    func playBtnAction() {
        switch status.value {
        case .start:
            stop()
        case .stop:
            restart()
        case .close:
            startTime()
        }
    }
    
    func startTime() {
        startTime(duration: timeCache.totalDuration)
    }
    
    func restart() {
        startTime(duration: timeStamp)
    }
    
    func stop() {
        cancel()
        status.send(.stop)
    }
    
    func close() {
        timeStamp = 0
        cancel()
        status.send(.close)
    }
    
    private func cancel() {
        timingTask?.cancel()
        timingTask = nil
    }
    
}


