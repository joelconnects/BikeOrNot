//
//  DataPoint.swift
//  BikeOrNot
//
//  Created by Joel Bell on 2/1/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import Foundation

protocol DataPoint {
    var cloudCover: Double? { get }
    var dewPoint: Double? { get }
    var humidity: Double? { get }
    var icon: SummaryIconType? { get }
    var ozone: Double? { get }
    var precipIntensity: Double? { get }
    var precipProbability: Double?  { get }
    var precipType: PrecipType? { get } // will not be defined if precipIntensity is zero
    var pressure: Double? { get }
    var summary: String? { get }
    var time: Double { get }
    var visibility: Double? { get }
    var windBearing: Double? { get } // will not be defined if windSpeed is zero
    var windSpeed: Double? { get }
}

protocol DataPointNotDaily {
    var apparentTemperature: Double? { get }
}

protocol DataPointHourlyDailyOnly {
    var precipAccumulation: Double? { get } // will not be defined if snowfall expected
}

protocol DataPointNotMinutely {
    var temperature: Double? { get }
}

protocol DataPointCurrentlyOnly {
    var nearestStormBearing: Double? { get } // will not be defined if nearestStormDistance is zero
    var nearestStormDistance: Double? { get }
}

protocol DataPointDailyOnly {
    var apparentTemperatureMax: Double? { get }
    var apparentTemperatureMaxTime: Double? { get }
    var apparentTemperatureMin: Double? { get }
    var apparentTemperatureMinTime: Double? { get }
    var moonPhase: Double? { get }
    var precipIntensityMax: Double? { get }
    var precipIntensityMaxTime: Double? { get }
    var sunriseTime: Double? { get }
    var sunsetTime: Double? { get }
    var temperatureMax: Double? { get }
    var temperatureMaxTime: Double? { get }
    var temperatureMin: Double? { get }
    var temperatureMinTime: Double? { get }
}

enum SummaryIconType {
    
    case clearDay, clearNight, cloudy, fog, hail, partlyCloudyDay, partlyCloudyNight, rain, sleet, snow, thunderstorm, tornado, wind
    
    static func generateType(fromResponse response: String) -> SummaryIconType? {
        
        switch response {
        case "clear-day":
            return .clearDay
        case "clear-night":
            return .clearNight
        case "rain":
            return .rain
        case "snow":
            return .snow
        case "sleet":
            return .sleet
        case "wind":
            return .wind
        case "fog":
            return .fog
        case "cloudy":
            return .cloudy
        case "partly-cloudy-day":
            return .partlyCloudyDay
        case "partly-cloudy-night":
            return .partlyCloudyNight
        case "hail":
            return .hail
        case "thunderstorm":
            return .thunderstorm
        case "tornado":
            return .tornado
        case "wind":
            return .wind
        default:
            return nil
        }
        
    }
}

enum PrecipType {
    
    case rain, snow, sleet, none
    
    static func generateType(fromResponse response: String) -> PrecipType? {
        
        switch response {
        case "rain":
            return .rain
        case "snow":
            return .snow
        case "sleet":
            return .sleet
        case "none":
            return .none
        default:
            return nil
        }
    }
}

