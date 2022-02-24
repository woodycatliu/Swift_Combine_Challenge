//
//  TimingDeviceViewModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import Foundation
import Combine

class TimingDeviceViewModel {
    
    typealias Timestamp = Int
    /// 選定的定時時間Cache
    var timeCache: [TimePickType: Timestamp] = [:]
  
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

