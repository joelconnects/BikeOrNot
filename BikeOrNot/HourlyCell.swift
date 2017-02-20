//
//  HourlyCell.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/25/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class HourlyCell: UICollectionViewCell {
    
    var hourLabel: UILabel!
    var timePeriodLabel: UILabel!
    
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
        
        self.contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        hourLabel = UILabel.generateLabel(appFont: .condensedBlack(size: .eighteen), appColor: nil, text: nil)
        hourLabel.textAlignment = .center
        stackView.addArrangedSubview(hourLabel)
        
        timePeriodLabel = UILabel.generateLabel(appFont: .condensedBlack(size: .thirteen), appColor: nil, text: nil)
        timePeriodLabel.textAlignment = .center
        stackView.addArrangedSubview(timePeriodLabel)
        
    }
    
}
