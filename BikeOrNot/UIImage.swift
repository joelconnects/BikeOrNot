//
//  UIImage.swift
//  BikeOrNot
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import UIKit

extension UIImage {
    
    func tint(color: UIColor) -> UIImage? {
        
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: drawRect, mask: self.cgImage!)
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: .overlay, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
        
    }
    
    func ratio() -> CGFloat {
        
        if self.size.width == self.size.height {
            return 1
        } else if self.size.width > self.size.height {
            return self.size.width / self.size.height
        } else {
            return self.size.height / self.size.width
        }
        
    }
    
    
}
