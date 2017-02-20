//
//  UILabel.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/26/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

extension UILabel {
    
    class func generateLabel(appFont: UIFont.HelveticaNeue, appColor: UIColor.AppColors?, text: String?) -> UILabel {
        
        let label = UILabel()
        label.font = appFont.font
        label.textColor = appColor?.color
        label.text = text
        return label
        
    }
    
}
