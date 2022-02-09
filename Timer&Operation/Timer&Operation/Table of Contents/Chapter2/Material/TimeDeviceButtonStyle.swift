//
//  ButtonStyle.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/9.
//

import Foundation
import UIKit

extension TimeDeviceMaterial {
    struct ButtonStyle {
        struct StartButton {
            static let backgroundColor: UIColor = .green.withAlphaComponent(0.15)
            static let highlightlyBackgrounColor: UIColor = .green.withAlphaComponent(0.1)
            static let title: String = "開始"
            static let titleColor: UIColor = .green.withAlphaComponent(0.7)
        }
        
        struct ContinueButton {
            static let backgroundColor: UIColor = .green.withAlphaComponent(0.15)
            static let highlightlyBackgrounColor: UIColor = .green.withAlphaComponent(0.1)
            static let title: String = "繼續"
            static let titleColor: UIColor = .green.withAlphaComponent(0.7)
        }
        
        struct StopButton {
            private static let orange: UIColor = .init(red: 255/255, green: 148/255, blue: 16/255, alpha: 1)
            static let backgroundColor: UIColor = Self.orange.withAlphaComponent(0.15)
            static let highlightlyBackgrounColor: UIColor = Self.orange.withAlphaComponent(0.1)
            static let title: String = "暫停"
            static let titleColor: UIColor = .orange
        }
        
        struct CancelButton {
            static let backgroundColor: UIColor = .systemGray4.withAlphaComponent(0.9)
            static let highlightlyBackgrounColor: UIColor = .systemGray4.withAlphaComponent(0.3)
            static let title: String = "取消"
            static let titleColor: UIColor = .white
            static let disableTitleColor: UIColor = .systemGray3
        }
    }
}
