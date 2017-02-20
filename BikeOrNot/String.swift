//
//  String.swift
//  BikeOrNot
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import UIKit

extension String {
    
    func getTextFrameFrom(label: UILabel) -> CGRect? {
        
        let labelText = NSString(string: label.text!)
        
        return labelText.boundingRect(with: label.bounds.size,
                                      options: [.usesFontLeading, .usesDeviceMetrics],
                                      attributes: [NSFontAttributeName: label.font],
                                      context: nil)
    }
    
}
