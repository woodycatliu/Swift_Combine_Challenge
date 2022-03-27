//
//  ReduxComponents.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/3/26.
//

import Combine
import Foundation
import SwiftUI

typealias Reduce<State, Action, Environment> = (inout State, Action, Environment)-> AnyPublisher<Action, Never>?

final class Reducer<State, Action, Environment> {
    let reduce: Reduce<State, Action, Environment>
    init(_ reduce: @escaping Reduce<State, Action, Environment>) {
        self.reduce = reduce
    }
}

class Store<State, Action, Environment> {
    var publisher: CurrentValueSubject<State, Never>
    private var void:  Reducer<State, Action, Environment>
    private var bag: Set<AnyCancellable> = []
    private var environment: Environment
    
    init(state: State, environment: Environment , reducer: Reducer<State, Action, Environment>) {
        publisher = CurrentValueSubject(state)
        self.void = reducer
        self.environment = environment
    }
    
    
    deinit {
        print("\(Self.self) is deinit")
    }
    
    func send(action: Action) {
        guard let effect = void.reduce(&publisher.value, action, environment) else { return }
        effect
            .sink(receiveValue: send)
            .store(in: &bag)
    }
    
    func viewStore()-> ViewStore<State, Action> {
        let child = ViewStore(value: publisher.value, root: {
            [weak self] action in
            self?.send(action: action)
        })
        
        child.cancelable = publisher
            .dropFirst()
            .sink(receiveValue: { [weak child] in
                child?.value = $0
            })
        
        return child
    }
}


class ViewStore<State, Action> {
    var cancelable: AnyCancellable?
    var publisher: CurrentValueSubject<State, Never>
    private var root: ((Action)-> Void)?
    
    init(value: State, root: @escaping (Action)-> Void) {
        self.publisher = CurrentValueSubject(value)
        self.root = root
    }
    
    func send(action: Action) {
        root?(action)
    }
    
    deinit {
        print("\(Self.self) is deinit")
    }
}

extension ViewStore {
    var value: State {
        get {
            self.publisher.value
        }
        
        set {
            self.publisher.send(newValue)
        }
    }
}


