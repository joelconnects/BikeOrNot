//
//  ConditionsCell.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/24/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class ConditionCell: UICollectionViewCell {
    
    var iconView: UIImageView!
    var conditionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        let borderThickness: CGFloat = 0.8
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.appColorBlue().cgColor
        borderLayer.frame = CGRect(x: 0, y: self.bounds.height - borderThickness, width: self.bounds.width, height: borderThickness)
        self.layer.addSublayer(borderLayer)
        
        iconView = UIImageView()
        self.contentView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        iconView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        iconView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.65).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
        
        conditionLabel = UILabel.generateLabel(appFont: .regular(size: .eighteen), appColor: .yellow, text: nil)
        self.contentView.addSubview(conditionLabel)
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10).isActive = true
        conditionLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        conditionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
    }
    
}
