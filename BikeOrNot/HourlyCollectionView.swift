//
//  HourlyView.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/24/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class HourlyCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var flowLayout: UICollectionViewFlowLayout!
    let borderThickness: CGFloat = 0.5
    
    var placeholders = [Int](1...48)
    let spacing: CGFloat = 1
    
    // MARK: Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor.appColorBlue()
        self.layer.cornerRadius = 5
        self.register(HourlyCell.self, forCellWithReuseIdentifier: "hourlyCell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemWidth = (frame.size.width / 12) - ((spacing * 11) / 12)
        
        flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: itemWidth, height: frame.height)
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = 0
        
    }
    
}

// MARK: DataSource

extension HourlyCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeholders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCell
        
        cell.backgroundColor = UIColor.appColorGreen()
        cell.hourLabel.text = String(placeholders[indexPath.item])
        cell.timePeriodLabel.text = "PM"
        
        return cell
    }
    
}
