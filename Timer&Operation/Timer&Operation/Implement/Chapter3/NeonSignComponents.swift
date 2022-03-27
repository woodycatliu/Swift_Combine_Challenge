//
//  NeonSignComponents.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/3/26.
//

import Foundation
import Combine

struct NeonSignState {
    var first: Int = 0
    var second: Int = 0
    var third: Int = 0
}

enum NeonSignAction {
    case buttonDidTapped(_ type: NeonSignType)
    case start(_ type: NeonSignType)
    case cancel(_ type: NeonSignType)
    case addState(_ type: NeonSignType)
    case resetState(_ type: NeonSignType, value: Int)
    case resetAllState
    case cancelAll
}

enum NeonSignType: String {
    case first, second, third
    
    var count: Double {
        switch self {
        case .first:
            return 0.2
        case .second:
            return 0.3
        case .third:
            return 0.5
        }
    }
}

let AddStateClosure: (NeonSignType)-> (inout NeonSignState) -> () = { type in
    return { state in
        switch type {
        case .first:
            state.first += 1
        case .second:
            state.second += 1
        case .third:
            state.third += 1
        }
    }
}

let UpdateStateClosure: (NeonSignType, Int)-> (inout NeonSignState)-> () = { type, value in
    return { state in
        switch type {
        case .first:
            state.first = value
        case .second:
            state.second = value
        case .third:
            state.third = value
        }
    }
}

class NeonSignEnvironment: CancellablesCollection {}

let NeonSignReducer = Reducer<NeonSignState, NeonSignAction, NeonSignEnvironment> { state, action, environment in
    switch action {
    case let .cancel(type):
        environment.cancel(id: type.rawValue)
        return Just(NeonSignAction.resetState(type, value: 0)).eraseToAnyPublisher()
    case .cancelAll:
        environment.cancel(id: NeonSignType.first.rawValue)
        environment.cancel(id: NeonSignType.second.rawValue)
        environment.cancel(id: NeonSignType.third.rawValue)
        return Just(NeonSignAction.resetAllState).eraseToAnyPublisher()
    case let .start(type):
        environment.cancel(id: type.rawValue)
        return Timer.publish(every: type.count, tolerance: nil, on: .current, in: .common, options: nil)
            .autoconnect()
            .flatMap { _ in return Just(NeonSignAction.addState(type)) }
            .eraseToEffect()
            .cancellable(id: type.rawValue, in: environment)
            .eraseToAnyPublisher()
    case let .addState(type):
        AddStateClosure(type)(&state)
        return .none
    case .resetAllState:
        state = NeonSignState()
        return .none
    case let .resetState(type, value):
        UpdateStateClosure(type, value)(&state)
        return .none
    case let .buttonDidTapped(type):
        let timerIsExisting = environment.storage[type.rawValue] != nil
        return timerIsExisting ? Just(NeonSignAction.cancel(type)).eraseToAnyPublisher() : Just(NeonSignAction.start(type)).eraseToAnyPublisher()
    }
}

