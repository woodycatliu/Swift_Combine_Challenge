//
//  Effect.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/3/27.
//

import Foundation
import Combine

public struct Effect<Output, Failure: Error>: Publisher {
    public let upstream: AnyPublisher<Output, Failure>

    public init<P: Publisher>(_ publisher: P) where P.Output == Output, P.Failure == Failure {
        self.upstream = publisher.eraseToAnyPublisher()
      }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        self.upstream.subscribe(subscriber)
    }
    
    func cancellable(id: String, in collectionCancellables: CancellablesStorableStorable)-> Effect {
        let cancellableSubject = PassthroughSubject<Void, Never>()
        var cancellationCancellable: AnyCancellable!
        cancellationCancellable = AnyCancellable { [weak collectionCancellables] in
            cancellableSubject.send(())
            cancellableSubject.send(completion: .finished)
            collectionCancellables?.storage[id]?.remove(cancellationCancellable)
            if collectionCancellables?.storage[id]?.isEmpty == .some(true) {
                collectionCancellables?.storage[id] = nil
            }
        }
        
        return
            Deferred { () -> Publishers.HandleEvents<Publishers.PrefixUntilOutput<Self, PassthroughSubject<Void, Never>>> in
                
                return self.prefix(untilOutputFrom: cancellableSubject)
                    .handleEvents(receiveSubscription: { [weak collectionCancellables] _ in
                        if collectionCancellables?.storage[id] == nil {
                            collectionCancellables?.storage[id] = []
                        }
                        collectionCancellables?.storage[id]?.insert(cancellationCancellable)
                    }, receiveCompletion: { _ in cancellationCancellable.cancel() }, receiveCancel: cancellationCancellable.cancel)
            }.eraseToEffect()
        
    }
    
    
}

extension Publisher {
    public func eraseToEffect() -> Effect<Output, Failure> {
        Effect(self)
      }
}
