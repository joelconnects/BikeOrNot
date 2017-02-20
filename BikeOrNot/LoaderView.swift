//
//  LoaderView.swift
//  BikeOrNot
//
//  Created by Joel Bell on 1/27/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import UIKit

final class LoaderView: UIView {
    
    fileprivate var cityLineViewOne: CityLineView!
    fileprivate var cityLineViewTwo: CityLineView!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCityLineViews()
    
        let multiplier: CGFloat = 0.4
        let loaderWidth = frame.width * multiplier
        let ratio = #imageLiteral(resourceName: "bikeStatusMainIcon").size.height / #imageLiteral(resourceName: "bikeStatusMainIcon").size.width
        let loaderIconContainer = UIView(frame: CGRect(x: 0, y: 0, width: loaderWidth, height: loaderWidth * ratio))
        self.addSubview(loaderIconContainer)
        
        let yConstant = frame.height * 0.1
        
        loaderIconContainer.translatesAutoresizingMaskIntoConstraints = false
        loaderIconContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loaderIconContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -yConstant).isActive = true
        loaderIconContainer.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
        loaderIconContainer.heightAnchor.constraint(equalTo: loaderIconContainer.widthAnchor, multiplier: ratio).isActive = true
        
        configureLoader(wheel: .left, inContainerView: loaderIconContainer)
        configureLoader(wheel: .right, inContainerView: loaderIconContainer)
        
        let loaderIconView = UIImageView()
        
        loaderIconView.image = #imageLiteral(resourceName: "bikeStatusMainIcon").withRenderingMode(.alwaysTemplate)
        loaderIconView.tintColor = UIColor.AppColors.pink.color
        
        loaderIconView.layer.shadowColor = UIColor.black.cgColor
        loaderIconView.layer.shadowOpacity = 1
        loaderIconView.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        loaderIconView.layer.shadowRadius = 0
        loaderIconView.layer.shouldRasterize = true
        
        loaderIconContainer.addSubview(loaderIconView)
        
        loaderIconView.translatesAutoresizingMaskIntoConstraints = false
        loaderIconView.topAnchor.constraint(equalTo: loaderIconContainer.topAnchor).isActive = true
        loaderIconView.leadingAnchor.constraint(equalTo: loaderIconContainer.leadingAnchor).isActive = true
        loaderIconView.widthAnchor.constraint(equalTo: loaderIconContainer.widthAnchor).isActive = true
        loaderIconView.heightAnchor.constraint(equalTo: loaderIconContainer.heightAnchor).isActive = true
        
        let loaderLabelBlue = UILabel.generateLabel(appFont: .bold(size: .twenty), appColor: .blue, text: "Checking the latest weather conditions...")
        loaderLabelBlue.lineBreakMode = .byWordWrapping
        loaderLabelBlue.numberOfLines = 0
        loaderLabelBlue.textAlignment = .center
        
        self.addSubview(loaderLabelBlue)
        
        loaderLabelBlue.translatesAutoresizingMaskIntoConstraints = false
        loaderLabelBlue.topAnchor.constraint(equalTo: loaderIconContainer.bottomAnchor, constant: 8).isActive = true
        loaderLabelBlue.centerXAnchor.constraint(equalTo: loaderIconContainer.centerXAnchor).isActive = true
        loaderLabelBlue.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        
        let loaderLogoView = UIImageView(image: #imageLiteral(resourceName: "logoMainIcon"))
        self.addSubview(loaderLogoView)
        
        loaderLogoView.translatesAutoresizingMaskIntoConstraints = false
        loaderLogoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loaderLogoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        loaderLogoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        loaderLogoView.heightAnchor.constraint(equalTo: loaderLogoView.widthAnchor, multiplier: #imageLiteral(resourceName: "logoMainIcon").size.height / #imageLiteral(resourceName: "logoMainIcon").size.width).isActive = true
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    

    

    
}

// MARK: Configure Views

extension LoaderView {
    
    fileprivate func configureCityLineViews() {
        
        let height = frame.height * 0.25
        let width = height * #imageLiteral(resourceName: "cityLine").ratio()
        let constant = width + (width - frame.width)
        
        cityLineViewOne = generateCityLineView()
        cityLineViewTwo = generateCityLineView()

        cityLineViewTwo.trailingConstraint = cityLineViewTwo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constant)
        cityLineViewTwo.trailingConstraint?.isActive = true
        
        cityLineViewOne.jointConstraint = cityLineViewOne.trailingAnchor.constraint(equalTo: cityLineViewTwo.leadingAnchor)
        cityLineViewOne.jointConstraint?.isActive = true
        
    }
    
    fileprivate func generateCityLineView() -> CityLineView {
        
        let cityLineView = CityLineView(frame: CGRect.zero)
        cityLineView.image = #imageLiteral(resourceName: "cityLine").withRenderingMode(.alwaysTemplate)
        cityLineView.tintColor = UIColor.AppColors.yellow.color
        self.addSubview(cityLineView)
        
        cityLineView.translatesAutoresizingMaskIntoConstraints = false
        cityLineView.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.height * 0.2).isActive = true
        cityLineView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        cityLineView.widthAnchor.constraint(equalTo: cityLineView.heightAnchor, multiplier: #imageLiteral(resourceName: "cityLine").ratio())
        
        return cityLineView
    
    }
    
    fileprivate func generateContainerView() {
        
        
        
    }
    
    fileprivate enum LoaderWheel {
        
        case left, right
        
        var multiplier: CGRect {
            
            switch self {
            case .left:
                return CGRect(x: 0.026981450252951, y: 0.554, width: 0.3490725126, height: 0.414)
            case .right:
                return CGRect(x: 0.6239460371, y: 0.554, width: 0.3490725126, height: 0.414)
            }
            
        }
    }
    
    fileprivate func configureLoader(wheel: LoaderWheel, inContainerView container: UIView) {
        
        let width = container.bounds.width * wheel.multiplier.width
        let height = container.bounds.height * wheel.multiplier.height
        let x = container.bounds.width * wheel.multiplier.origin.x
        let y = container.bounds.height * wheel.multiplier.origin.y
        
        let wheelView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        wheelView.image = #imageLiteral(resourceName: "loaderSpokes").withRenderingMode(.alwaysTemplate)
        wheelView.tintColor = UIColor.AppColors.blue.color
        
        container.addSubview(wheelView)
        
        UIView.animate(withDuration: 0.8, delay: 0, options: [.repeat, .curveLinear], animations: {
            
            wheelView.transform = wheelView.transform.rotated(by: CGFloat(M_PI))
            
        }) { _ in }
        
    }

}

// MARK: Animation 

extension LoaderView {
    
    func animateCityLineViews(duration: Double) {
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: {
            
            self.cityLineViewTwo.trailingConstraint?.constant = 0
            self.layoutIfNeeded()
            
        }) { _ in
            
            self.removeConstraint(self.cityLineViewOne.jointConstraint!)
            self.removeConstraint(self.cityLineViewTwo.trailingConstraint!)
            
            self.cityLineViewOne.alpha = 0
            
            self.cityLineViewOne.trailingConstraint = self.cityLineViewOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.cityLineViewOne.bounds.width)
            self.cityLineViewOne.trailingConstraint?.isActive = true
            
            self.cityLineViewTwo.jointConstraint = self.cityLineViewTwo.trailingAnchor.constraint(equalTo: self.cityLineViewOne.leadingAnchor)
            self.cityLineViewTwo.jointConstraint?.isActive = true
            
            self.layoutIfNeeded()
            
            self.cityLineViewOne.alpha = 1
            
            swap(&self.cityLineViewOne, &self.cityLineViewTwo)
            
            self.animateCityLineViews(duration: 4.0)
        }
        
        
    }
    
}

// MARK: Image View for Loader View Animation

final class CityLineView: UIImageView {
    
    fileprivate var jointConstraint: NSLayoutConstraint?
    fileprivate var trailingConstraint: NSLayoutConstraint?
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
