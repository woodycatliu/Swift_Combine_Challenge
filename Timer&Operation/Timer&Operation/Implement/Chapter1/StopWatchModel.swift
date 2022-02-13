//
//  StopWatchModel.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import Foundation
import Combine

class StopWatchModel {
    @Published
    private(set) var currentTime: TimeInterval = 0
    private var timerTask: AnyCancellable?
    private let everTimeInterval: TimeInterval = 0.01
    var bag = Set<AnyCancellable>()
    func timeStart() {
        timerTask?.cancel()
        timerTask =
        Timer.publish(every: everTimeInterval, on: .main, in: .common)
            .autoconnect()
            .map { [unowned self] _ in return self.everTimeInterval }
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

extension StopWatchModel {
    func bindding() {
        $currentTime.sink(receiveValue: { print($0) }).store(in: &bag)
    }
}

