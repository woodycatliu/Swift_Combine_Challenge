//
//  TimePickViewModel.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import Foundation
import UIKit

protocol TimePicker {
    var timestampLabel: String { get }
    var range: ClosedRange<Int> { get }
}

extension TimePicker {
    var list: [Int] {
        return Array(range)
    }
    var count: Int {
        return list.count
    }
    
    func value(_ row: Int)-> Int {
        return list[row]
    }
    
    func timeText(_ row: Int)-> String {
        if row < 10 {
            return "  \(row)"
        }
        return String(value(row))
    }
}

struct TimePickerViewModel: TimePicker {
    var timestampLabel: String
    var range: ClosedRange<Int>
    var type: TimePickType
}

extension TimePickerViewModel {
    func text(_ row: Int)-> String {
        let text: String
        switch type {
        case .hr:
            text = "     \(timeText(row))"
        case .min:
            text = "     \(timeText(row))"
        case .sec:
            text = "      \(timeText(row))"
        }
        return text
    }
}

extension TimePickerViewModel {
    static let hour: Self = .init(timestampLabel: "hr", range: 0...23, type: .hr)
    static let min: Self = .init(timestampLabel: "min", range: 0...59, type: .min)
    static let sec: Self = .init(timestampLabel: "sec", range: 0...59, type: .sec)
}

enum TimePickType: Int, CaseIterable {
    case hr, min, sec
}

extension TimePickType {
    
    var viewModel: TimePickerViewModel {
        switch self {
        case .hr:
            return .hour
        case .min:
            return .min
        case .sec:
            return .sec
        }
    }
}
