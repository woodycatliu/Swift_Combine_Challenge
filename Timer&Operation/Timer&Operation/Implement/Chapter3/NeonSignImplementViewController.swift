//
//  NeonSignImplementViewController.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/3/26.
//

import Combine
import UIKit

class NeonSignImplementViewController: NeonSignViewController {
    var bag: Set<AnyCancellable> = []
    var viewModel: NeonSignViewModel = NeonSignViewModel(state: .init(), environment: .init(), reducer: NeonSignReducer)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindding(viewModel)
        configureBtnAction()
    }
}

extension NeonSignImplementViewController {
    
    func bindding(_ viewModel: NeonSignViewModel) {
        let updateButton: (NeonSignState)-> () = { [weak self] state in
            self?.firstBtn.setTitle("\(state.first)", for: .normal)
            self?.secondBtn.setTitle("\(state.second)", for: .normal)
            self?.thirdBtn.setTitle("\(state.third)", for: .normal)
        }
        
        let updateTotalLabel: (Int)-> () = { [weak self] value in
            self?.totalLabel.text = "\(value)"
        }
        
        let buttonShiny: (Int)-> () = { [weak self] value in
            guard let self = self else { return }
            let isMultiOf2 = value % 2 == 0 && value != 0
            let isMultiOf3 = value % 3 == 0 && value != 0
            let isMultiOf5 = value % 4 == 0 && value != 0
            
            NeonSignMaterial.FirstButton.setFlashColor(self.firstBtn, isFlash: isMultiOf2)
            NeonSignMaterial.SecondButton.setFlashColor(self.secondBtn, isFlash: isMultiOf3)
            NeonSignMaterial.ThirdButton.setFlashColor(self.thirdBtn, isFlash: isMultiOf5)
        }
        
        
        viewModel.publisher
            .receive(on: RunLoop.main, options: nil)
            .sink(receiveValue: updateButton)
            .store(in: &bag)
        
        let totalPublisher = viewModel.publisher
            .map { return $0.first + $0.second + $0.third }
            .receive(on: RunLoop.main, options: nil)
            .share()
        
        totalPublisher
            .sink(receiveValue: updateTotalLabel)
            .store(in: &bag)
        
        totalPublisher
            .sink(receiveValue: buttonShiny)
            .store(in: &bag)
    }
    
}


extension NeonSignImplementViewController {
    
    fileprivate func configureBtnAction() {
        firstBtn.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)
        secondBtn.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
        thirdBtn.addTarget(self, action: #selector(thirdButtonAction), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(resetButtonAction), for: .touchUpInside)
    }
    
    @objc
    private func firstButtonAction() {
        viewModel.firstButtonAction()
    }
    
    @objc
    private func secondButtonAction() {
        viewModel.seconfButtonAction()
    }
    
    @objc
    private func thirdButtonAction() {
        viewModel.thirdButtonAction()
    }
    
    @objc
    private func resetButtonAction() {
        viewModel.reset()
    }
}
 
