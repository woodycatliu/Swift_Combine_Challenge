//
//  TimeDeviceSubViewModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/24.
//

import Foundation

class TimingDeviceSubViewModel: TimingDeviceModel {
    
    let timeDeviceModel: TimingDeviceModel = TimingDeviceModel()
    
    private func startTime(dration: TimeInterval) {
        timeDeviceModel.status = .start(dration)
    }
    
    func startTime() {
        let dration = timeCache.totalDration
        startTime(dration: dration)
    }
    
    func restart() {
        timeDeviceModel.status = .start(nil)
    }
    
    func stop() {
        timeDeviceModel.status = .stop
    }
    
    func close() {
        timeDeviceModel.status = .close
    }
    
}
