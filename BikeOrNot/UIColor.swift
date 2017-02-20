//
//  UIColor.swift
//  BikeOrNot
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func appColorGreen() -> UIColor { return UIColor(colorLiteralRed: 66/255, green: 1, blue: 0, alpha: 1) }
    class func appColorYellow() -> UIColor { return UIColor(colorLiteralRed: 207/255, green: 1, blue: 0, alpha: 1) }
    class func appColorOrange() -> UIColor { return UIColor(colorLiteralRed: 1, green: 174/255, blue: 0, alpha: 1) }
    class func appColorPink() -> UIColor { return UIColor(colorLiteralRed: 242/255, green: 19/255, blue: 130/255, alpha: 1) }
    class func appColorBlue() -> UIColor { return UIColor(colorLiteralRed: 0, green: 187/255, blue: 228/255, alpha: 1) }
    
    enum AppColors {
        
        case green, yellow, orange, pink, blue
        
        var color: UIColor {
            
            switch self {
            case .green:
                return UIColor(colorLiteralRed: 66/255, green: 1, blue: 0, alpha: 1)
            case .yellow:
                return UIColor(colorLiteralRed: 207/255, green: 1, blue: 0, alpha: 1)
            case .orange:
                return UIColor(colorLiteralRed: 1, green: 174/255, blue: 0, alpha: 1)
            case .pink:
                return UIColor(colorLiteralRed: 242/255, green: 19/255, blue: 130/255, alpha: 1)
            case .blue:
                return UIColor(colorLiteralRed: 0, green: 187/255, blue: 228/255, alpha: 1)
            }
            
        }
        
    }
    
}
