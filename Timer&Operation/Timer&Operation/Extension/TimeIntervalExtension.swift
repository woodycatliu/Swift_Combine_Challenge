//
//  TimeIntervalExtension.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import Foundation
import UIKit

extension TimeInterval {
    fileprivate class DateFormatterCatch {
        static let shared: DateFormatterCatch = DateFormatterCatch()
        private init() {}
        let dateFormatter: DateFormatter = DateFormatter()
    }
    func dateString(_ formatterString: String)-> String {
        let dateFormatter = DateFormatterCatch.shared.dateFormatter
        dateFormatter.dateFormat = formatterString
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
