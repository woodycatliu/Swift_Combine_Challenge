//
//  NeonSignViewModel.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/3/26.
//

import Foundation
import Combine


class NeonSignViewModel: Store<NeonSignState, NeonSignAction, NeonSignEnvironment> {}

extension NeonSignViewModel {
    
    func firstButtonAction() {
        send(action: .buttonDidTapped(.first))
    }
    
    func seconfButtonAction() {
        send(action: .buttonDidTapped(.second))
    }
    
    func thirdButtonAction() {
        send(action: .buttonDidTapped(.third))
    }
    
    func reset() {
        send(action: .cancelAll)
    }
}

