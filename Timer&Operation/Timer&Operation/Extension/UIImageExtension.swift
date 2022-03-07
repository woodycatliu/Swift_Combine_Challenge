//
//  UIImageExtension.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import UIKit

extension UIImage {
    static func concentricCircleImage(bounds: CGRect, color: UIColor) -> UIImage? {
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.fillColor = UIColor.clear.cgColor
        
        let outerRing = CAShapeLayer()
        outerRing.frame = bounds
        outerRing.strokeColor = color.cgColor
        outerRing.lineWidth = 2
        
        let outBezierPath = UIBezierPath(ovalIn: bounds.insetBy(dx: 1, dy: 1))
        outerRing.path = outBezierPath.cgPath
        
        let innerCircle = CAShapeLayer()
        innerCircle.frame = bounds

        let innerBezierPath = UIBezierPath(ovalIn: bounds.insetBy(dx: 3, dy: 3))

        innerCircle.path = innerBezierPath.cgPath
        innerCircle.fillColor = color.cgColor

        layer.addSublayer(outerRing)
        layer.addSublayer(innerCircle)
        
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
