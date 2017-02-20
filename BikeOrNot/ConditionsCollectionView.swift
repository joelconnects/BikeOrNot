//
//  ConditionsCollectionView.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/18/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class ConditionsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var flowLayout: UICollectionViewFlowLayout!
    let borderThickness: CGFloat = 0.8
    
    let columns = 2
    let rows = 3
    
    // MARK: Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        self.register(ConditionCell.self, forCellWithReuseIdentifier: "conditionCell")
        
        self.backgroundColor = .clear

        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.appColorBlue().cgColor
        borderLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderThickness)
        self.layer.addSublayer(borderLayer)
        
        flowLayout = layout as! UICollectionViewFlowLayout
        
        let spacing = frame.size.width * 0.04
        let itemWidth = frame.size.width / CGFloat(columns) - (spacing/CGFloat(columns))
        let itemHeight = frame.size.height / CGFloat(rows)
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = spacing
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

// MARK: DataSource

extension ConditionsCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns * rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conditionCell", for: indexPath) as! ConditionCell
        
        switch indexPath.item {
        case 0:
            cell.iconView.image = #imageLiteral(resourceName: "rainMainIcon")
            cell.conditionLabel.text = "80%"
        case 1:
            cell.iconView.image = #imageLiteral(resourceName: "windMainIcon")
            cell.conditionLabel.text = "NNW 10 mph"
        case 2:
            cell.iconView.image = #imageLiteral(resourceName: "visibilityMainIcon")
            cell.conditionLabel.text = "10 mi"
        case 3:
            cell.iconView.image = #imageLiteral(resourceName: "humidityMainIcon")
            cell.conditionLabel.text = "80%"
        case 4:
            cell.iconView.image = #imageLiteral(resourceName: "sunriseIcon")
            cell.conditionLabel.text = "8:00 AM"
        case 5:
            cell.iconView.image = #imageLiteral(resourceName: "sunsetIcon")
            cell.conditionLabel.text = "8:00 PM"
        default:
            break
        }

        return cell
    }
    
}
