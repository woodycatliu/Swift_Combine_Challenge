//
//  ButtonStyle.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/9.
//

import Foundation
import UIKit

class TimingDeviceStyle {
    struct ButtonStyle {
        struct StartButton {
            static let backgroundColor: UIColor = .green.withAlphaComponent(0.9)
            static let highlightlyBackgrounColor: UIColor = .green.withAlphaComponent(0.3)
            static let title: String = "開始"
            static let titleColor: UIColor = .green
        }
        
        struct ContinueButton {
            static let backgroundColor: UIColor = .green.withAlphaComponent(0.9)
            static let highlightlyBackgrounColor: UIColor = .green.withAlphaComponent(0.3)
            static let title: String = "繼續"
            static let titleColor: UIColor = .green
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
