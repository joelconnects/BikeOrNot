//
//  MainViewController.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/15/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    let temporaryBorderWidth: CGFloat = 0 // temporary
    
    fileprivate var wallpaperView: UIImageView!
    fileprivate var loaderView: LoaderView!
    fileprivate var nowView: NowView!
    fileprivate var conditionsView: ConditionsCollectionView!
    fileprivate var hourlyLabel: UILabel!
    fileprivate var hourlyView: HourlyCollectionView!
    fileprivate var dailyLabel: UILabel!
    fileprivate var dailyView: DailyCollectionView!
    fileprivate var footerView: UIView!
    
    fileprivate var headerConstant: CGFloat {
        let lowResolution = CGSize(width: 320, height: 568)
        if lowResolution == UIScreen.main.bounds.size {
            return UIScreen.main.bounds.height * 0.019
        }
        return UIScreen.main.bounds.height * 0.022
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
    
    }

}

// MARK: Layout

extension MainViewController {
    
    fileprivate enum Margin: CGFloat {
        
        case top = 25
        case bottom = 8, left, right
        
    }
    
    fileprivate enum HeightMultiplier: CGFloat {
        
        case now = 0.34
        case conditions = 0.135
        case hourly = 0.08
        case daily = 0.13
        case header = 0.085
        
    }
    
    fileprivate func generateViewRect(_ heightMultiplier: HeightMultiplier) -> CGRect {
        
        let viewWidth = UIScreen.main.bounds.width - (Margin.left.rawValue + Margin.right.rawValue)
        let viewHeight = UIScreen.main.bounds.height * heightMultiplier.rawValue
        return CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        
    }
    
}

// MARK: Configure Views

extension MainViewController {
    
    fileprivate func configureViews() {
        
        configureWallpaperView()
        configureStatusBarView()
        configureNowView()
        configureConditionsView()
        configureHourlyLabel()
        configureHourlyView()
        configureDailyLabel()
        configureDailyView()
        configureFooterView()
        
    }
    
    fileprivate func configureStatusBarView() {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 20.0))
        view.backgroundColor = UIColor.appColorBlue()
        self.view.addSubview(view)
        
    }
    
    fileprivate func configureLoaderView() {
        
        loaderView = LoaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.addSubview(loaderView)
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loaderView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    fileprivate func configureWallpaperView() {
    
        wallpaperView = UIImageView(image: #imageLiteral(resourceName: "mainWallpaper"))
        view.addSubview(wallpaperView)
        
        wallpaperView.translatesAutoresizingMaskIntoConstraints = false
        wallpaperView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        wallpaperView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        wallpaperView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        wallpaperView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    fileprivate func configureNowView() {
        
        nowView = NowView()
        nowView.layer.borderColor = UIColor.darkGray.cgColor // temporary
        nowView.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(nowView)
        
        nowView.translatesAutoresizingMaskIntoConstraints = false
        nowView.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.top.rawValue).isActive = true
        nowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        nowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right.rawValue).isActive = true
        nowView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: HeightMultiplier.now.rawValue).isActive = true
        
    }
    
    fileprivate func configureConditionsView() {
        
        conditionsView = ConditionsCollectionView(frame: generateViewRect(.conditions), collectionViewLayout: UICollectionViewFlowLayout()) // UIView()
        conditionsView.layer.borderColor = UIColor.darkGray.cgColor // temporary
        conditionsView.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(conditionsView)
        
        conditionsView.translatesAutoresizingMaskIntoConstraints = false
        conditionsView.topAnchor.constraint(equalTo: nowView.bottomAnchor).isActive = true
        conditionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        conditionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right.rawValue).isActive = true
        conditionsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: HeightMultiplier.conditions.rawValue).isActive = true
        
    }
    
    fileprivate func configureHourlyLabel() {
        
        hourlyLabel = UILabel.generateLabel(appFont: .bold(size: .fortySix), appColor: .blue, text: "HOURLY")
        hourlyLabel.layer.borderColor = UIColor.darkGray.cgColor // temporary
        hourlyLabel.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(hourlyLabel)
        
        hourlyLabel.translatesAutoresizingMaskIntoConstraints = false
        hourlyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        hourlyLabel.topAnchor.constraint(equalTo: conditionsView.bottomAnchor, constant: headerConstant).isActive = true
        hourlyLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: HeightMultiplier.header.rawValue).isActive = true
        
    }
    
    fileprivate func configureHourlyView() {
        
        hourlyView = HourlyCollectionView(frame: generateViewRect(.hourly), collectionViewLayout: UICollectionViewFlowLayout()) // UIView()
        hourlyView.layer.borderColor = UIColor.darkGray.cgColor // temporary
        hourlyView.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(hourlyView)
        
        hourlyView.translatesAutoresizingMaskIntoConstraints = false
        hourlyView.topAnchor.constraint(equalTo: hourlyLabel.bottomAnchor).isActive = true
        hourlyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        hourlyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right.rawValue).isActive = true
        hourlyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: HeightMultiplier.hourly.rawValue).isActive = true
        
    }
    
    fileprivate func configureDailyLabel() {
    
        dailyLabel = UILabel.generateLabel(appFont: .bold(size: .fortySix), appColor: .blue, text: "DAILY")
        dailyLabel.layer.borderColor = UIColor.darkGray.cgColor // temporary
        dailyLabel.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(dailyLabel)
        
        dailyLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        dailyLabel.topAnchor.constraint(equalTo: hourlyView.bottomAnchor, constant: headerConstant).isActive = true
        dailyLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: HeightMultiplier.header.rawValue).isActive = true
    
    }
    
    fileprivate func configureDailyView() {
        
        dailyView = DailyCollectionView(frame: generateViewRect(.daily), collectionViewLayout: UICollectionViewFlowLayout())
        dailyView.layer.borderColor = UIColor.darkGray.cgColor // temporary
        dailyView.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(dailyView)
        
        dailyView.translatesAutoresizingMaskIntoConstraints = false
        dailyView.topAnchor.constraint(equalTo: dailyLabel.bottomAnchor).isActive = true
        dailyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        dailyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right.rawValue).isActive = true
        dailyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: HeightMultiplier.daily.rawValue).isActive = true
        
    }

    fileprivate func configureFooterView() {
        
        footerView = UIView()
        footerView.layer.borderColor = UIColor.darkGray.cgColor // temporary
        footerView.layer.borderWidth = temporaryBorderWidth // temporary
        view.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.topAnchor.constraint(equalTo: dailyView.bottomAnchor).isActive = true
        footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left.rawValue).isActive = true
        footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right.rawValue).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Margin.bottom.rawValue).isActive = true
        
        let logoView = UIImageView(image: #imageLiteral(resourceName: "logoMainIcon"))
        footerView.addSubview(logoView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        logoView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        logoView.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 0.5).isActive = true
        logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: #imageLiteral(resourceName: "logoMainIcon").ratio()).isActive = true
        
    }
}

