//
//  StopWatchSubClassViewController.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import Foundation
import Combine
import UIKit

class StopWatchSubClassViewController: StopWatchViewController {
    private var bag: Set<AnyCancellable> = []
    private let viewModel: Ch1ViewModel = Ch1ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        binding()
    }
    
    private func configureButton() {
        playBtn.addTarget(viewModel, action: #selector(viewModel.startAction), for: .touchUpInside)
        resetBtn.addTarget(viewModel, action: #selector(viewModel.closeAction), for: .touchUpInside)
    }
    
    private func binding() {
        /// 將標籤與字串綁定與 View 做綁定
        viewModel.$timeStamp
            .receive(on: DispatchQueue.main)
            .map { $0 }
            .assign(to: \.text, on: timestampView)
            .store(in: &bag)
        
        /// 碼表狀態 -> map ButtonStyle
        /// Style 與 UIButton 做綁定
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .map { $0.playButtonStyle }
            .assign(to: UIButton.setButton, on: playBtn)
            .store(in: &bag)
    }
}


extension UIButton {
    
    /// 訪問者模式
    /// - Parameter style: ButtonStyleParameter.Type
    func setButton(_ style: ButtonStyleParameter.Type) {
        style.setButton(self)
    }
}
