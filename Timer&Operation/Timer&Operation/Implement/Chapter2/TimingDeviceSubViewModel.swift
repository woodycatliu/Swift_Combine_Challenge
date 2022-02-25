//
//  TimingDeviceSubViewModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/24.
//

import Foundation
import Combine

private let greaterThanHoursFormatterString: String = TimeDeviceMaterial.countdownTimeDateFormaterGreaterThanHours
private let smallerThanHoursFormatterString: String = TimeDeviceMaterial.countdownTimeDateFormaterSmallerThanHours

class TimingDeviceSubViewModel: TimingDeviceViewModel {
    private var bag: Set<AnyCancellable> = []
    
    private let timeDeviceModel: TimingDeviceModel = TimingDeviceModel()
    
    @Published
    private(set) var timeStamp: TimeInterval = 0
    
    private(set) var status: CurrentValueSubject<Status, Never> = .init(.close)
    
    private func startTime(dration: TimeInterval) {
        timeDeviceModel.status = .start(dration)
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
    
    override init() {
        super.init()
        self.timeDeviceModel.$currentTime
            .assign(to: \.timeStamp, weakOn: self)
            .store(in: &bag)
        
        self.timeDeviceModel.$status
            .map { Status.transformStatus($0)}
            .sink(receiveValue: { [unowned self] in self.status.send($0) })
            .store(in: &bag)
    }
}

extension TimingDeviceViewModel.Status {
    static func transformStatus(_ status: TimingDeviceModel.Status)-> Self {
        switch status {
        case .start(_):
            return .start
        case .stop:
            return .stop
        case .close:
            return .close
        }
        
    }
}
