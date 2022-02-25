//
//  TimingDeviceModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/24.
//

import Foundation
import Combine

class TimingDeviceModel {
    @Published
    private(set) var currentTime: TimeInterval = 0
    
    @Published
    var status: TimingDeviceModel.Status = .close
    
    private var timerTask: AnyCancellable?
    
    private let everTimeInterval: TimeInterval = 0.01
    
    var bag = Set<AnyCancellable>()
    
    
    private func timeStart(_ duration: TimeInterval) {
        timerTask?.cancel()
        currentTime = duration
        
        timerTask =
        Timer.publish(every: everTimeInterval, on: .main, in: .common)
            .autoconnect()
            .map { [unowned self] _ in return self.everTimeInterval }
            .scan(currentTime, -)
            .assign(to: \.currentTime, weakOn: self)
    }
    
    private func restart() {
        timeStart(currentTime)
    }
    
    private func stop() {
        timerTask?.cancel()
    }
    
    private func close() {
        timerTask?.cancel()
        timerTask = nil
    }
    
    init() {
        bindding()
    }
    
    
}

extension TimingDeviceModel {
    
    func bindding() {
        let close: (Bool)-> () = { [weak self] stop in
            guard stop else { return }
            self?.status = .close
        }
        $currentTime.print().sink(receiveValue: { _ in }).store(in: &bag)
        $currentTime.dropFirst().filter { $0 <= 0 }.map { _ in true }.sink(receiveValue: close).store(in: &bag)
        $status.assign(to: TimingDeviceModel.didChangeStatus(_:), on: self).store(in: &bag)
    }
}

extension TimingDeviceModel {
    
    enum Status {
        case start(_ duration: TimeInterval?)
        case stop
        case close
    }
    
    private func didChangeStatus(_ status: Status) {
        switch status {
        case .start(let value):
            let duration = value ?? currentTime
            timeStart(duration)
        case .stop:
            stop()
        case .close:
            close()
        }
    }
}

