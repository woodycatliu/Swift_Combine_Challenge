//
//  TimerExtension.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/25.
//

import Foundation
import Combine

extension Timer {
    private class TimingSubscription<SubscriberType: Subscriber>: Subscription where SubscriberType.Input == TimeInterval{
        private var subscriber: SubscriberType?
        private let duration: TimeInterval
        
        private var timeTask: AnyCancellable?
        
        private let everTimeInterval: TimeInterval
        
        private var bag: Set<AnyCancellable> = []
        
        init(every: TimeInterval = 0.01, _ duration: TimeInterval, _ subscriber: SubscriberType) {
            self.duration = duration
            self.subscriber = subscriber
            self.everTimeInterval = every
            start()
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber?.receive(completion: .finished)
            bag = []
            subscriber = nil
        }
        
        func start() {
            let cancel: (Bool)-> () = { [weak self] bool in
                guard bool else { return }
                self?.cancel()
            }
            
            let every = everTimeInterval
            
            let task = Timer.publish(every: every, on: .main, in: .common)
                .autoconnect()
                .map { _ in return every }
                .scan(duration, -)
                .share()
            task.sink(receiveValue: { [weak self] in
                _ = self?.subscriber?.receive($0 > 0 ? $0 : 0)
                                         }).store(in: &bag)
            task.map { $0 <= 0 }.sink(receiveValue: cancel).store(in: &bag)
        }
    }
    
    struct TimingPublisher: Combine.Publisher {
    
        typealias Output = TimeInterval
        
        typealias Failure = Never
        
        let duration: TimeInterval
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, TimeInterval == S.Input {
            let scr = TimingSubscription(duration, subscriber)
            subscriber.receive(subscription: scr)
        }
        
       
    }
    
    static func timingPublish(_ duration: TimeInterval)-> TimingPublisher {
        return TimingPublisher(duration: duration)
    }
    
}

