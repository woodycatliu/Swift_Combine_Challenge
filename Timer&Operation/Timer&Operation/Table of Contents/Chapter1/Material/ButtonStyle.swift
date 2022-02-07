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
    static func setButton(_ button: UIButton)
}

extension ButtonStyleParameter {
    
    static func setButton(_ button: UIButton) {
        button.setTitleColor(Self.titleColor, for: .normal)
        button.setTitleColor(Self.highlightedColor, for: .highlighted)
        button.setTitle(Self.title, for: .normal)
        button.setTitle(Self.title, for: .highlighted)
    }
}

extension StopWatchMaterial {
    struct ButtonStyle {
        struct PlayBtn {
            static let font: UIFont = .systemFont(ofSize: 30, weight: .semibold)
            static let backgroundColor: UIColor = .clear
            struct Start: ButtonStyleParameter {
                static var title: String = "START"
                static var titleColor: UIColor = .white
                static var highlightedColor: UIColor = .systemGray2
            }
            struct Close: ButtonStyleParameter {
                static var title: String = "STOP"
                static var titleColor: UIColor = .white
                static var highlightedColor: UIColor = .systemGray2
            }
            static func setButton(_ buttn: UIButton) {
                buttn.backgroundColor = Self.backgroundColor
                buttn.titleLabel?.font = Self.font
            }
        }
        
        struct ResetBtn {
            static let font: UIFont = .systemFont(ofSize: 20, weight: .semibold)
            static let backgroundColor: UIColor = .clear
            struct Reset: ButtonStyleParameter {
                static var title: String = "RESET"
                static var titleColor: UIColor = .systemGray
                static var highlightedColor: UIColor = .black.withAlphaComponent(0.8)
            }
            static func setButton(_ buttn: UIButton) {
                buttn.backgroundColor = Self.backgroundColor
                buttn.titleLabel?.font = Self.font
            }
        }
    }
}
