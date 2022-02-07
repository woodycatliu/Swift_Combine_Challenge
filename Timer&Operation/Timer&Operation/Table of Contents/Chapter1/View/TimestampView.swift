//
//  TimestampView.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/7.
//

import UIKit
import Combine

class TimestampView: UIView {
    
    private var bag = Set<AnyCancellable>()
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height / 4
            setShadow(color: .white, alpha: 1, offset: .init(width: 2, height: 2), blur: 3)
        }
    }
    
    private let label: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    
    @Published
    var text: String? = "00:00.00"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurUI()
        bindding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configurUI() {
        addSubview(label)
        label.fillSuperview(padding: .init(top: 10, left: 17.5, bottom: 10, right: 17.5))
        backgroundColor = .white
    }
    
    private func bindding() {
        $text
            .assign(to: \.text, on: label)
            .store(in: &bag)
    }
}
