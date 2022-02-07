//
//  ButtonStyle.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/7.
//

import UIKit
protocol ButtonStyleParameter {
    static var title: String { get }
    static var titleColor: UIColor { get }
    static var highlightedColor: UIColor { get }
}

extension StopWatchMaterial {
    struct ButtonStyle {
        static let font: UIFont = .systemFont(ofSize: 30, weight: .semibold)
        static let backgroundColor: UIColor = .clear
        struct Start: ButtonStyleParameter {
            static var title: String = "START"
            static var titleColor: UIColor = .white
            static var highlightedColor: UIColor = .systemGray2
        }
        struct Close: ButtonStyleParameter {
            static var title: String = "START"
            static var titleColor: UIColor = .white
            static var highlightedColor: UIColor = .systemGray2
        }
    }
}
