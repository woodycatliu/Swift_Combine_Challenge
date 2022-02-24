//
//  TimingDeviceViewModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import Foundation
import Combine

private let greaterThanHoursFormatterString: String = TimeDeviceMaterial.countdownTimeDateFormaterGreaterThanHours
private let smallerThanHoursFormatterString: String = TimeDeviceMaterial.countdownTimeDateFormaterSmallerThanHours

class TimingDeviceViewModel {
    private var bag: Set<AnyCancellable> = []

    typealias Timestamp = Int
    /// 選定的定時時間Cache
    private var timeCache: [TimePickType: Timestamp] = [:]
    
    private let timeDeviceModel: TimingDeviceModel = TimingDeviceModel()
    
    @Published
    private(set) var timeStamp: String = "00:00.00"
    
    private(set) var status: CurrentValueSubject<Status, Never> = .init(.close)
    
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
    
    init() {
        let timeFormaterString: (TimeInterval)-> String = { time -> String in
            let formatter = time.isGreaterThanHours ? greaterThanHoursFormatterString : smallerThanHoursFormatterString
            return time.dateString(formatter)
        }
        
        self.timeDeviceModel.$currentTime
            .map { timeFormaterString($0) }
            .assign(to: \.timeStamp, weakOn: self)
            .store(in: &bag)
    }
}

extension TimingDeviceViewModel {
    var numberOfComponents: Int {
        return TimePickType.allCases.count
    }
    func pickerViewModel(in component: Int)-> TimePickerViewModel? {
        return TimePickType.init(rawValue: component)?.viewModel
    }
}

extension TimingDeviceViewModel {
    
    /// 定時時間
    var timing: TimeInterval {
        return timeCache.timeInterval(.hr) + timeCache.timeInterval(.min) + timeCache.timeInterval(.sec)
    }
    
    func selected(in component: Int, row: Int) {
        guard let viewModel = pickerViewModel(in: component) else { return }
        timeCache[viewModel.type] = viewModel.value(row)
    }
}

extension TimingDeviceViewModel {
    enum Status {
        case start
        case stop
        case close
    }
}

extension TimingDeviceViewModel.Timestamp {
    func timeInterval(_ type: TimePickType)-> TimeInterval {
        let muti: Double
        switch type {
        case .hr:
            muti = 60 * 60
        case .min:
            muti = 60
        case .sec:
            muti = 1
        }
        return Double(self) * muti
    }
}

extension Dictionary where Self.Key == TimePickType, Self.Value == TimingDeviceViewModel.Timestamp {
    
    func timeInterval(_ type: TimePickType)-> TimeInterval {
        return self[type]?.timeInterval(type) ?? 0
    }
    
    var totalDration: TimeInterval {
        return self.timeInterval(.hr) + self.timeInterval(.min) + self.timeInterval(.sec)
    }
    
}

extension TimeInterval {
    var isGreaterThanHours: Bool {
        return self >= 3600
    }
}

