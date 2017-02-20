//
//  Date.swift
//  BikeOrNot
//
//  Created by Joel Bell on 11/6/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation

extension Date {
    
    func generateDayShortUppercasedText() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self).uppercased()
        
    }
    
    func generateTimePeriodText() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter.string(from: self)
        
    }
    
    func generateTimeShortText() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh"
        let hour = formatter.string(from: self)
        
        if hour.characters.first == "0" {
            return hour.replacingOccurrences(of: "0", with: "")
        }
        
        return hour
        
    }
    
}
