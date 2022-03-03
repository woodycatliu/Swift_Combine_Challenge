//
//  StopWatchViewModel.swift
//  Timer&Operation
//
//  Created by cm0678 on 2022/2/24.
//

import Foundation
import Combine

class StopWatchViewModel {
    
    @Published
    var time: TimeInterval = 0
    var isActive: Bool = false {
        didSet {
            if isActive {
                startCounting()
            } else {
                stopCounting()
            }
        }
    }
    private var cancellable: AnyCancellable?
    
    private func startCounting() {
        cancellable = Timer.publish(every: 0.01, tolerance: nil, on: .main, in: .common, options: nil)
            .autoconnect()
            .sink(receiveValue: { [weak self] date in
                self?.time += 0.01
        })
    }
        
    private func stopCounting() {
        cancellable?.cancel()
    }
        
    func resetCount() {
        time = 0
        stopCounting()
    }
}
