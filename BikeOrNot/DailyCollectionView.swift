//
//  DailyView.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/25/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class DailyCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var flowLayout: UICollectionViewFlowLayout!
    let borderThickness: CGFloat = 0.5
    
    var placeholders = [Int](1...8)
    let spacing: CGFloat = 1
    
    // MARK: Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = UIColor.appColorBlue()
        self.layer.cornerRadius = 5
        self.register(DailyCell.self, forCellWithReuseIdentifier: "dailyCell")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemWidth = (frame.size.width / 7) - ((spacing * 6) / 7)
        
        flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: itemWidth, height: frame.height)
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = 0
        
    }

}

// MARK: DataSource

extension DailyCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeholders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath) as! DailyCell
        
        cell.backgroundColor = UIColor.appColorGreen()
        cell.dayLabel.text = "MON"
        cell.iconView.image = #imageLiteral(resourceName: "bikeStatusIcon")
        
        return cell
    }
    
}

