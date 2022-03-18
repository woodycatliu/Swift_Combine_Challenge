//
//  NeonSignViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/3/18.
//

import Foundation
import UIKit
import SwiftUI

class NeonSignViewController: UIViewController {
    private let totalLabel: UILabel = UILabel()
    private let firstBtn: UIButton = UIButton()
    private let secondBtn: UIButton = UIButton()
    private let thirdBtn: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(totalLabel)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.font = .systemFont(ofSize: 100, weight: .heavy)
        totalLabel.numberOfLines = 1
        totalLabel.textColor = .white
        totalLabel.textAlignment = .center
        totalLabel.text = "0"
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            totalLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalLabel.heightAnchor.constraint(equalTo: totalLabel.widthAnchor)
        ])
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        let arr = [firstBtn, secondBtn, thirdBtn]
        arr.forEach {
            $0.widthAnchor.constraint(equalTo: $0.heightAnchor).isActive = true
            $0.layer.cornerRadius = 42.5
            stackView.addArrangedSubview($0)
            $0.setTitle("0", for: .normal)
            $0.setTitle("0", for: .highlighted)
            $0.setTitleColor(.black, for: .normal)
        }
        NeonSignMaterial.FirstButton.setButton(firstBtn)
        NeonSignMaterial.SecondButton.setButton(secondBtn)
        NeonSignMaterial.ThirdButton.setButton(thirdBtn)
    }
    
    
    
}






struct  NeonSignViewController_Preview: PreviewProvider {
    static var previews: some View {
        return ViewControllerProvider.init(NeonSignViewController())
    }
}
