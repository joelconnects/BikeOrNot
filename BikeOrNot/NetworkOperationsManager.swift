//
//  NetworkManager.swift
//  BikeOrNot
//
//  Created by Joel Bell on 10/17/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation
import CoreLocation

@objc protocol NetworkOperationsManager {
    var queue: OperationQueue { get }
}

enum OpState: String {
    case ready = "isReady"
    case executing = "isExecuting"
    case finished = "isFinished"
    
}

class OperationRequest: Operation {
    
    override var isAsynchronous: Bool {
        return true
    }
    
    var state = OpState.ready {
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    override func main() {
        
        if self.isCancelled {
            state = .finished
        } else {
            state = .executing
            executeMainTask()
        }
        
    }
    
    func executeMainTask() {}
    
}
