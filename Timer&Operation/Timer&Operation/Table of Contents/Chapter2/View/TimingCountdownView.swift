//
//  TimingCountdownView.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/9.
//

import UIKit

class TimingCountdownView: UIView {
    
    fileprivate typealias Bounds = CGRect
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.amSymbol = "上午"
        df.pmSymbol = "下午"
        return df
    }()
    private var lineWidth: CGFloat = 9.5
    private var maxTimeInterval: TimeInterval = 0
    
    private var bellImage: UIImage? = .init(systemName: "bell.fill")?.withTintColor(.gray.withAlphaComponent(0.8))
    
    lazy var font: UIFont = {
        return UIFont.systemFont(ofSize: bounds.height / 5, weight: .ultraLight)
    }()
    
    private var currentTiming: TimeInterval = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var lineColor: UIColor = .init(red: 255/255, green: 148/255, blue: 16/255, alpha: 1)
    private var pathShadowColor: UIColor = .init(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        ctx.clear(bounds)
        ctx.saveGState()
        drawCircle(ctx)
        ctx.restoreGState()
        drawTimestamp()

    }
    
    private func drawCircle(_ ctx: CGContext) {
        let circleBounds: Bounds = bounds.insetBy(dx: lineWidth, dy: lineWidth)
        let radius: CGFloat = circleBounds.width / 2
        ctx.setLineWidth(lineWidth)
        ctx.setLineCap(.round)

        ctx.addArc(center: bounds.center, radius: radius, startAngle: -0.00001, endAngle: 0, clockwise: true)
        pathShadowColor.setStroke()
        ctx.strokePath()
        
        let diff = currentTiming / maxTimeInterval * .pi * 2
        ctx.addArc(center: bounds.center, radius: radius, startAngle: 3 / 2 * .pi - diff, endAngle: -.pi / 2 - 0.0000001 * .pi, clockwise: true)
        lineColor.setStroke()
        ctx.strokePath()
    }
    
    private func drawTimestamp() {
        let diff = maxTimeInterval - currentTiming
        let realDiff = diff >= 0 ? diff : maxTimeInterval - Double(Int(currentTiming) % Int(maxTimeInterval))
        let formater: String = realDiff >= 60 ? TimeDeviceMaterial.countdownTimeDateFormaterGreaterThanHours : TimeDeviceMaterial.countdownTimeDateFormaterSmallerThanHours
        let date = Date(timeIntervalSince1970: realDiff)
        dateFormatter.dateFormat = formater
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let dict: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: style,
            .foregroundColor: UIColor.white
        ]
        
        let timeString = NSString(string: dateFormatter.string(from: date))
        let timeSize = timeString.size(withAttributes: dict)
        let timeOrigin: CGPoint = .init(x: bounds.center.x - timeSize.width / 2, y: bounds.center.y - timeSize.height / 2)
        
        NSString(string: dateFormatter.string(from: date)).draw(at: timeOrigin, withAttributes: dict)
        
        var subTimeOrigin: CGPoint = .init(x: bounds.center.x - 57, y: timeSize.height * 2 / 3.3 + bounds.center.y)
        
        bellImage?.draw(in: .init(origin: subTimeOrigin, size: .init(width: 21.5, height: 21.5)))
        
        subTimeOrigin.x += 25
        
        dateFormatter.dateFormat = "aaa hh:mm"
        
        let overTimeDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + maxTimeInterval)
        
        NSString(string: dateFormatter.string(from: overTimeDate)).draw(at: subTimeOrigin, withAttributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.gray.withAlphaComponent(0.9)])

    }
    

}

extension TimingCountdownView {
    
    @discardableResult
    func maxTimeInterval(_ time: TimeInterval)-> TimingCountdownView {
        maxTimeInterval = time
        return self
    }
    
    @discardableResult
    func setCurrentTiming(_ time: TimeInterval)-> TimingCountdownView {
        currentTiming = time
        return self
    }
    
    @discardableResult
    func setLineWidth(_ width: CGFloat)-> TimingCountdownView {
        self.lineWidth = width
        return self
    }
}

extension TimingCountdownView.Bounds {
    var center: CGPoint {
        return .init(x: self.width / 2, y: self.height / 2)
    }
}
