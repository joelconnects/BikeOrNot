//
//  NowView.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/15/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

class NowView: UIView {
    
    // MARK: Layout 
    
    fileprivate let tempViewHeightMultiplier: CGFloat = 0.28
    
    // MARK: Views
    
    var tempView: UIView!
    
    // MARK: Labels
    
    var conditionLabel: UILabel!
    var locationLabel: UILabel!
    
    var temp: UILabel!
    var feltTempLabel: UILabel!
    var highTempLabel: UILabel!
    var lowTempLabel: UILabel!
    
    // MARK: Icons
    
    var conditionIcon: UIImageView!
    var bikeStatusIcon: UIImageView!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConditionLabel()
        configureConditionIcon()
        configureLocationLabel()
        configureBikeStatusIcon()
        configureTempView()
        constrainBikeStatusIcon()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
    }
    
}

// MARK: Configure Views

extension NowView {
    
    fileprivate func configureConditionLabel() {
        
        conditionLabel = UILabel.generateLabel(appFont: .light(size: .twenty), appColor: .blue, text: "Partly Cloudy")
        self.addSubview(conditionLabel)
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        conditionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        conditionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        
    }
    
    fileprivate func configureConditionIcon() {
        
        conditionIcon = UIImageView(image: #imageLiteral(resourceName: "clearIcon"))
        self.addSubview(conditionIcon)
        
        conditionIcon.translatesAutoresizingMaskIntoConstraints = false
        conditionIcon.leadingAnchor.constraint(equalTo: conditionLabel.trailingAnchor, constant: 5).isActive = true
        conditionIcon.centerYAnchor.constraint(equalTo: conditionLabel.centerYAnchor).isActive = true
        conditionIcon.heightAnchor.constraint(equalTo: conditionLabel.heightAnchor, multiplier: 1.0).isActive = true
        conditionIcon.widthAnchor.constraint(equalTo: conditionIcon.heightAnchor).isActive = true
        
    }

    fileprivate func configureLocationLabel() {
        
        locationLabel = UILabel.generateLabel(appFont: .light(size: .twenty), appColor: .blue, text: "Brooklyn, NY")
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.numberOfLines = 0
        locationLabel.textAlignment = .right
        self.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        locationLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        
    }
    
    fileprivate func configureBikeStatusIcon() {
        
        bikeStatusIcon = UIImageView(image: #imageLiteral(resourceName: "bikeStatusMainIcon").tint(color: UIColor.appColorGreen()))
        self.addSubview(bikeStatusIcon)
        
    }
    
    fileprivate func constrainBikeStatusIcon() {
        
        bikeStatusIcon.translatesAutoresizingMaskIntoConstraints = false
        bikeStatusIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bikeStatusIcon.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 5).isActive = true
        bikeStatusIcon.bottomAnchor.constraint(equalTo: tempView.topAnchor, constant: -5).isActive = true
        bikeStatusIcon.widthAnchor.constraint(equalTo: bikeStatusIcon.heightAnchor, multiplier: #imageLiteral(resourceName: "bikeStatusMainIcon").ratio()).isActive = true
        
    }
    
    fileprivate func configureTempView() {
        
        tempView = UIView()
//        tempView.backgroundColor = UIColor.appColorYellow()
        self.addSubview(tempView)
        
        tempView.translatesAutoresizingMaskIntoConstraints = false
        tempView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tempView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tempView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tempView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: tempViewHeightMultiplier).isActive = true
        
        configureTempLabel()
        
        let tempStackView = generateTempStackView()
        let feltTempStackView = generateTempSubStackView()
        let highLowTempStackView = generateTempSubStackView()
        
        let feltTempDescriptor = generateDescriptorLabel()
        feltTempDescriptor.text = "Feels like"
        
        feltTempLabel = generateTempsLabel()
        feltTempLabel.text = "75°"
        
        let highTempDescriptor = generateDescriptorLabel()
        highTempDescriptor.text = "H"
        
        highTempLabel = generateTempsLabel()
        highTempLabel.text = "75°"
        
        let lowTempDescriptor = generateDescriptorLabel()
        lowTempDescriptor.text = "L"
        
        lowTempLabel = generateTempsLabel()
        lowTempLabel.text = "75°"
        
        feltTempStackView.addArrangedSubview(feltTempDescriptor)
        feltTempStackView.addArrangedSubview(feltTempLabel)
        
        highLowTempStackView.addArrangedSubview(highTempDescriptor)
        highLowTempStackView.addArrangedSubview(highTempLabel)
        highLowTempStackView.addArrangedSubview(lowTempDescriptor)
        highLowTempStackView.addArrangedSubview(lowTempLabel)
        
        tempStackView.addArrangedSubview(feltTempStackView)
        tempStackView.addArrangedSubview(highLowTempStackView)
        
        constrainTemps(label: feltTempDescriptor)
        constrainTemps(label: feltTempLabel)
        constrainTemps(label: highTempDescriptor)
        constrainTemps(label: highTempLabel)
        constrainTemps(label: lowTempDescriptor)
        constrainTemps(label: lowTempLabel)
        
        configureTempIcon(usingStackView: tempStackView)
        
    }
    
    fileprivate func configureTempLabel() {
        
        temp = UILabel.generateLabel(appFont: .bold(size: .fiftySix), appColor: .blue, text: "75°")
//        temp.backgroundColor = UIColor.appColorOrange()
//        temp.adjustsFontSizeToFitWidth = true
//        temp.baselineAdjustment = .alignCenters
        tempView.addSubview(temp)
        
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: tempView.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
//        temp?.widthAnchor.constraint(equalTo: tempView.widthAnchor, multiplier: 0.35).isActive = true
        
    }
    
    fileprivate func generateTempStackView() -> UIStackView {
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        tempView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: tempView.centerYAnchor).isActive = true

        
        return stackView
        
    }
    
    fileprivate func generateTempSubStackView() -> UIStackView {
        
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.spacing = 5
        return stackView
        
    }
    
    fileprivate func generateDescriptorLabel() -> UILabel {
        
        let label = UILabel.generateLabel(appFont: .light(size: .twenty), appColor: .blue, text: nil)
//                label.backgroundColor = UIColor.appColorPink()
        label.textAlignment = .right
        return label
        
    }
    
    fileprivate func generateTempsLabel() -> UILabel {
        
        let label = UILabel.generateLabel(appFont: .bold(size: .twenty), appColor: .blue, text: nil)
//                label.backgroundColor = UIColor.appColorGreen()
        label.textAlignment = .right
        return label
        
    }
    
    fileprivate func constrainTemps(label: UILabel) {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: tempView.heightAnchor, multiplier: 0.4).isActive = true
        
    }
    
    fileprivate func configureTempIcon(usingStackView stackView: UIStackView) {
        
        let tempIcon = UIImageView(image: #imageLiteral(resourceName: "tempIcon"))
        
        let tempIconMultiplier = tempIcon.bounds.width / tempIcon.bounds.height
        
        tempView.addSubview(tempIcon)
        
        tempIcon.translatesAutoresizingMaskIntoConstraints = false
        tempIcon.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -5).isActive = true
        tempIcon.centerYAnchor.constraint(equalTo: tempView.centerYAnchor).isActive = true
        tempIcon.heightAnchor.constraint(equalTo: tempView.heightAnchor, multiplier: 0.7).isActive = true
        tempIcon.widthAnchor.constraint(equalTo: tempIcon.heightAnchor, multiplier: tempIconMultiplier).isActive = true
        
    }
    
}
