//
//  ConcentricCircleStyleButton.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import UIKit

/// 自帶雙圈圖案Button
/// circleColor: normal 狀態顏色
/// circileHighlightedColor: highlighted 狀態顏色
class ConcentricCircleStyleButton: UIButton {
    override var bounds: CGRect {
        didSet {
            setBackgroundImage(UIImage.concentricCircleImage(bounds: bounds, color: circleColor), for: .normal)
            setBackgroundImage(UIImage.concentricCircleImage(bounds: bounds, color: circileHighlightedColor), for: .highlighted)
        }
    }
    var circleColor: UIColor = .green
    var circileHighlightedColor: UIColor = UIColor.systemGray3.withAlphaComponent(0.8)
    internal override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
    }
}
