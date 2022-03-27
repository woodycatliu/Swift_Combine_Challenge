//
//  CancellableCollection.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/3/27.
//

import Foundation
import Combine

public protocol CancellablesStorableStorable: AnyObject {
    var storage: [String: Set<AnyCancellable>] { get set }
}

class CancellablesCollection: CancellablesStorableStorable {
    private let lock: NSLock = NSLock()
    var storage: [String: Set<AnyCancellable>] {
        set  {
            lock.lock()
            defer {
                lock.unlock()
            }
            _storage = newValue
        }
        
        get {
            return _storage
        }
    }
    
    private var _storage: [String: Set<AnyCancellable>] = [:]
    
    public func cancel(id: String) {
        storage[id]?.forEach {
            $0.cancel()
        }
        storage[id] = nil
    }
}
