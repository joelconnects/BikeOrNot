//
//  UIFont.swift
//  BikeOrNot
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func helveticaNeue(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue", size: size)! }
    class func helveticaNeueMedium(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue-Medium", size: size)! }
    class func helveticaNeueBold(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue-Bold", size: size)! }
    class func helveticaNeueLight(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue-Light", size: size)! }
    class func helveticaNeueUltraLight(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue-UltraLight", size: size)! }
    class func helveticaNeueLightItalic(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue-LightItalic", size: size)! }
    class func helveticaNeueCondensedBlack(size: CGFloat) -> UIFont { return UIFont(name: "HelveticaNeue-CondensedBlack", size: size)! }
    
    enum HelveticaNeue {
        
        case regular(size: Size)
        case medium(size: Size)
        case bold(size: Size)
        case light(size: Size)
        case ultraLight(size: Size)
        case lightItalic(size: Size)
        case condensedBlack(size: Size)
        
        var font: UIFont {
            
            let lowResolution = CGSize(width: 320, height: 568)
            var adjustment: CGFloat = 0
            if lowResolution == UIScreen.main.bounds.size {
                adjustment = 4
            }
            
            switch self {
            case .regular(let size):
                return UIFont(name: "HelveticaNeue", size: size.rawValue - adjustment)!
            case .medium(let size):
                return UIFont(name: "HelveticaNeue-Medium", size: size.rawValue - adjustment)!
            case .bold(let size):
                return UIFont(name: "HelveticaNeue-Bold", size: size.rawValue - adjustment)!
            case .light(let size):
                return UIFont(name: "HelveticaNeue-Light", size: size.rawValue - adjustment)!
            case .ultraLight(let size):
                return UIFont(name: "HelveticaNeue-UltraLight", size: size.rawValue - adjustment)!
            case .lightItalic(let size):
                return UIFont(name: "HelveticaNeue-LightItalic", size: size.rawValue - adjustment)!
            case .condensedBlack(let size):
                return UIFont(name: "HelveticaNeue-CondensedBlack", size: size.rawValue - adjustment)!
            }
        
        }
        
    }
    
    enum Size: CGFloat {
        
        case twelve = 12
        case thirteen = 13
        case fourteen = 14
        case sixteen = 16
        case eighteen = 18
        case twenty = 20
        case fortySix = 46
        case fortyEight = 48
        case fifty = 50
        case fiftyTwo = 52
        case fiftyFour = 54
        case fiftySix = 56
        case fiftyEight = 58
        case sixty = 60
        
    }
    
    /*
     Font Family Name = [Helvetica Neue]
     Font Names = [["HelveticaNeue-Italic", "HelveticaNeue-Bold", "HelveticaNeue-UltraLight", "HelveticaNeue-CondensedBlack", "HelveticaNeue-BoldItalic", "HelveticaNeue-CondensedBold", "HelveticaNeue-Medium", "HelveticaNeue-Light", "HelveticaNeue-Thin", "HelveticaNeue-ThinItalic", "HelveticaNeue-LightItalic", "HelveticaNeue-UltraLightItalic", "HelveticaNeue-MediumItalic", "HelveticaNeue"]]
     
     // MARK: Print font families
     
     
     */
    
//    func printFonts() {
//        let fontFamilyNames = UIFont.familyNames
//        for familyName in fontFamilyNames {
//            print("------------------------------")
//            print("Font Family Name = [\(familyName)]")
//            let names = UIFont.fontNames(forFamilyName: familyName)
//            print("Font Names = [\(names)]")
//        }
//    }
    
}
