//
//  DailyCell.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/25/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class DailyCell: UICollectionViewCell {
    
    var iconView: UIImageView!
    var dayLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        
        self.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        dayLabel = UILabel.generateLabel(appFont: .condensedBlack(size: .eighteen), appColor: nil, text: nil)
        dayLabel.textAlignment = .center
        stackView.addArrangedSubview(dayLabel)
        
        iconView = UIImageView()
        stackView.addArrangedSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.6).isActive = true
        iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor, multiplier: #imageLiteral(resourceName: "bikeStatusIcon").ratio()).isActive = true
        
    }
    
}


