//
//  ButtonStyle.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/9.
//

import Foundation
import UIKit

extension TimeDeviceMaterial {
    typealias ButtonParameter = ButtonStyleParameter
    struct ButtonStyle {
        struct StartButton: ButtonParameter {
            static var highlightedColor: UIColor = .green.withAlphaComponent(0.1)
            static var backgroundColor: UIColor = .green.withAlphaComponent(0.15)
            static var title: String = "開始"
            static var titleColor: UIColor = .green.withAlphaComponent(0.7)
            
        }
        
        struct ContinueButton: ButtonParameter {
            static var highlightedColor: UIColor = .green.withAlphaComponent(0.1)
            static let backgroundColor: UIColor = .green.withAlphaComponent(0.15)
            static let title: String = "繼續"
            static let titleColor: UIColor = .green.withAlphaComponent(0.7)
        }
        
        struct StopButton: ButtonStyleParameter {
            private static let orange: UIColor = .init(red: 255/255, green: 148/255, blue: 16/255, alpha: 1)
            static var highlightedColor: UIColor = Self.orange.withAlphaComponent(0.1)
            static let backgroundColor: UIColor = Self.orange.withAlphaComponent(0.15)
            static let title: String = "暫停"
            static let titleColor: UIColor = .orange
        }
        
        struct CancelButton: ButtonStyleParameter {
            static var highlightedColor: UIColor = .systemGray4.withAlphaComponent(0.3)
            static let backgroundColor: UIColor = .systemGray4.withAlphaComponent(0.9)
            static let title: String = "取消"
            static let titleColor: UIColor = .white
            static let disableTitleColor: UIColor = .systemGray3
            
            static func setButton(_ button: ConcentricCircleStyleButton) {
                button.setTitleColor(Self.titleColor, for: .normal)
                button.circileHighlightedColor = self.highlightedColor
                button.circleColor = self.backgroundColor
                button.setTitle(Self.title, for: .normal)
                button.setTitle(Self.title, for: .highlighted)
                button.setTitleColor(disableTitleColor, for: .disabled)
            }
        }
    }
}

extension TimeDeviceMaterial.ButtonParameter  {
    
    static func setButton(_ button: ConcentricCircleStyleButton) {
        button.setTitleColor(Self.titleColor, for: .normal)
        button.circileHighlightedColor = self.highlightedColor
        button.circleColor = self.backgroundColor
        button.setTitle(Self.title, for: .normal)
        button.setTitle(Self.title, for: .highlighted)
    }
}
