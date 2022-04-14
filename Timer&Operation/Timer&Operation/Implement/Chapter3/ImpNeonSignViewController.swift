//
//  ImpNeonSignViewController.swift
//  Timer&Operation
//
//  Created by cm0678 on 2022/4/13.
//

import UIKit
import Combine

extension UIButton {
    var titleText: String? {
        get {
            title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
}

class ImpNeonSignViewController: NeonSignViewController {

    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButtonAction()
        combineTotalCount()
    }
    
    private func addButtonAction() {
        firstBtn.addTarget(self, action: #selector(firstBtnDidTap), for: .touchUpInside)
        secondBtn.addTarget(self, action: #selector(secondBtnDidTap), for: .touchUpInside)
        thirdBtn.addTarget(self, action: #selector(thirdBtnBtnDidTap), for: .touchUpInside)
    }
    
    
    private var firstEveryTime: Double = 2
    private var secondEveryTime: Double = 3
    private var thirdEveryTime: Double = 5
    
    @Published private var firstCount: Double = 0
    @Published private var secondCount: Double = 0
    @Published private var thirdCount: Double = 0
    
    private lazy var timerFirst = Timer.publish(every: firstEveryTime, on: .main, in: .common).autoconnect()
    private lazy var timerSecond = Timer.publish(every: secondEveryTime, on: .main, in: .common).autoconnect()
    private lazy var timerThird = Timer.publish(every: secondEveryTime, on: .main, in: .common).autoconnect()
    
    
    private func combineTotalCount() {
        
        Publishers.CombineLatest3($firstCount, $secondCount, $thirdCount)
            .sink { _ in
            } receiveValue: { [unowned self] (first, second, third) in
                print("\(first), \(second), \(third)")
                let totalCount = first + second + third
                NeonSignMaterial.FirstButton.setFlashColor(self.firstBtn, isFlash: totalCount.truncatingRemainder(dividingBy: firstEveryTime) == 0)
                NeonSignMaterial.SecondButton.setFlashColor(self.secondBtn, isFlash: totalCount.truncatingRemainder(dividingBy: secondEveryTime) == 0)
                NeonSignMaterial.ThirdButton.setFlashColor(self.thirdBtn, isFlash: totalCount.truncatingRemainder(dividingBy: thirdEveryTime) == 0)
                self.totalLabel.text = "\(totalCount)"
            }.store(in: &cancellables)
        
        func flashButtonIfNeeded(totalConunt: Int) {
            
        }
    }
    
    @objc
    private func firstBtnDidTap() {
        
//        timerFirst
//            .scan(firstCount, { accumulate, next in accumulate + 1 })
//            .map { String($0) }
//            .assign(to: \.titleText, on: firstBtn)
//            .store(in: &cancellables)
        
        timerFirst
            .scan(firstCount, { accumulate, next in accumulate + 1 })
            .sink(receiveValue: { [unowned self] count in
                self.firstCount = count
                self.firstBtn.titleText = "\(count)"
            }).store(in: &cancellables)
    }
    
    @objc
    private func secondBtnDidTap() {
        
//        timerSecond
//            .scan(secondCount, { accumulate, next in accumulate + 1 })
//            .map { String($0) }
//            .assign(to: \.titleText, on: secondBtn)
//            .store(in: &cancellables)
        
        timerSecond
            .scan(secondCount, { accumulate, next in accumulate + 1 })
            .sink(receiveValue: { [unowned self] count in
                self.secondCount = count
                self.secondBtn.titleText = "\(count)"
            }).store(in: &cancellables)
    }

    @objc
    private func thirdBtnBtnDidTap() {
        
//        timerThird
//            .scan(thirdCount, { accumulate, next in accumulate + 1 })
//            .map { String($0) }
//            .assign(to: \.titleText, on: thirdBtn)
//            .store(in: &cancellables)
        
        timerThird
            .scan(thirdCount, { accumulate, next in accumulate + 1 })
            .sink(receiveValue: { [unowned self] count in
                self.thirdCount = count
                self.thirdBtn.titleText = "\(count)"
            }).store(in: &cancellables)
    }
}
