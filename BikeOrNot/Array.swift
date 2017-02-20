//
//  Array.swift
//  BikeOrNot
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation

extension Array where Element: Operation {
    func onFinish(block: @escaping () -> Void) {
        let doneOperation = BlockOperation(block: block)
        self.forEach { [unowned doneOperation] in doneOperation.addDependency($0) }
        OperationQueue().addOperation(doneOperation)
    }
    
}
