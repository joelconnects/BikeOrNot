//
//  File.swift
//  BikeOrNot
//
//  Created by Joel Bell on 10/2/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: Forecast

struct Forecast {
    
    let latitude: Double
    let longitude: Double
    let timezone: String
    var placemark: CLPlacemark?
    
    let currently: Currently
    let hourly: Hourly
    let daily: Daily
    
    init?(response: [String: Any], placemark: CLPlacemark?) {
        
        if let placemark = placemark {
            self.placemark = placemark
        }
        
        guard
            let latitude = response["latitude"] as? Double,
            let longitude = response["longitude"] as? Double,
            let timezone = response["timezone"] as? String,
            let current = response["currently"] as? [String: Any],
            let hour = response["hourly"] as? [String: Any],
            let day = response["daily"] as? [String: Any]
            else {return nil}
        
        self.latitude = latitude
        self.longitude = longitude
        self.timezone = timezone
        
        guard
            let currently = Currently(response: current),
            let hourly = Hourly(response: hour),
            let daily = Daily(response: day)
            else {return nil}
        
        self.currently = currently
        self.hourly = hourly
        self.daily = daily
        
    }
    
    // MARK: Currently
    
    struct Currently: DataPoint, DataPointCurrentlyOnly, DataPointNotDaily, DataPointNotMinutely {
        
        // Data Point
        var cloudCover: Double?
        var dewPoint: Double?
        var humidity: Double? // yes
        var icon: SummaryIconType? // yes
        var ozone: Double?
        var precipIntensity: Double?
        var precipProbability: Double?  // yes
        var precipType: PrecipType? // yes
        var pressure: Double?
        var summary: String?
        var time: Double // yes
        var visibility: Double? // yes
        var windBearing: Double? // yes
        var windSpeed: Double? // yes
        
        // Data Point (Currently Only)
        var nearestStormBearing: Double?
        var nearestStormDistance: Double?
        
        // Data Point (Not Daily)
        var apparentTemperature: Double?
        
        // Data Point (Not Minutely)
        var temperature: Double?
        
        init?(response: [String: Any]) {
            
            guard
                let apparentTemperature = response["apparentTemperature"] as? Double,
                let cloudCover = response["cloudCover"] as? Double,
                let dewPoint = response["dewPoint"] as? Double,
                let humidity = response["humidity"] as? Double,
                let icon = response["icon"] as? String,
                let nearestStormDistance = response["nearestStormDistance"] as? Double,
                let ozone = response["ozone"] as? Double,
                let precipIntensity = response["precipIntensity"] as? Double,
                let precipProbability = response["precipProbability"] as? Double,
                let pressure = response["pressure"] as? Double,
                let summary = response["summary"] as? String,
                let temperature = response["temperature"] as? Double,
                let time = response["time"] as? Double,
                let visibility = response["visibility"] as? Double,
                let windSpeed = response["windSpeed"] as? Double
                else {return nil}
        
            let precipType = response["precipType"] as? String ?? "none"
            let nearestStormBearing = response["nearestStormBearing"] as? Double
            let windBearing = response["windBearing"] as? Double
            
            self.apparentTemperature = apparentTemperature
            self.cloudCover = cloudCover
            self.dewPoint = dewPoint
            self.humidity = humidity
            self.icon = SummaryIconType.generateType(fromResponse: icon)
            self.nearestStormBearing = nearestStormBearing
            self.nearestStormDistance = nearestStormDistance
            self.ozone = ozone
            self.precipIntensity = precipIntensity
            self.precipProbability = precipProbability
            self.precipType = PrecipType.generateType(fromResponse: precipType)
            self.pressure = pressure
            self.summary = summary
            self.temperature = temperature
            self.time = time
            self.visibility = visibility
            self.windBearing = windBearing
            self.windSpeed = windSpeed
            
        }
        
    }
    
    // MARK: Hourly

    struct Hourly {

        let hours: [Hour]

        init?(response: [String: Any]) {

            var hoursResponse: [Hour] = []
            guard let dataBlock = response["data"] as? [[String: Any]] else {return nil}
            for hour in dataBlock {
                guard let completeHour = Hour(response: hour) else {return nil}
                hoursResponse.append(completeHour)
            }
            self.hours = hoursResponse

        }

        struct Hour: DataPoint, DataPointHourlyDailyOnly, DataPointNotMinutely, DataPointNotDaily {

            // Data Point
            var cloudCover: Double?
            var dewPoint: Double?
            var humidity: Double?
            var icon: SummaryIconType?
            var ozone: Double?
            var precipIntensity: Double?
            var precipProbability: Double?
            var precipType: PrecipType?
            var pressure: Double?
            var summary: String?
            var time: Double
            var visibility: Double?
            var windBearing: Double?
            var windSpeed: Double?
            
            // Data Point (Hourly & Daily Only)
            var precipAccumulation: Double?
            
            // Data Point (Not Daily)
            var apparentTemperature: Double?
            
            // Data Point (Not Minutely)
            var temperature: Double?

            init?(response: [String: Any]) {

                guard
                    let apparentTemperature = response["apparentTemperature"] as? Double,
                    let cloudCover = response["cloudCover"] as? Double,
                    let dewPoint = response["dewPoint"] as? Double,
                    let humidity = response["humidity"] as? Double,
                    let icon = response["icon"] as? String,
                    let ozone = response["ozone"] as? Double,
                    let precipIntensity = response["precipIntensity"] as? Double,
                    let precipProbability = response["precipProbability"] as? Double,
                    let pressure = response["pressure"] as? Double,
                    let summary = response["summary"] as? String,
                    let temperature = response["temperature"] as? Double,
                    let time = response["time"] as? Double,
                    let visibility = response["visibility"] as? Double,
                    let windSpeed = response["windSpeed"] as? Double
                    else {return nil}
                
                let precipAccumulation = response["precipAccumulation"] as? Double
                let precipType = response["precipType"] as? String ?? "none"
                let windBearing = response["windBearing"] as? Double
                
                self.apparentTemperature = apparentTemperature
                self.cloudCover = cloudCover
                self.dewPoint = dewPoint
                self.humidity = humidity
                self.icon = SummaryIconType.generateType(fromResponse: icon)
                self.ozone = ozone
                self.precipAccumulation = precipAccumulation
                self.precipIntensity = precipIntensity
                self.precipProbability = precipProbability
                self.precipType = PrecipType.generateType(fromResponse: precipType)
                self.pressure = pressure
                self.summary = summary
                self.temperature = temperature
                self.time = time
                self.visibility = visibility
                self.windBearing = windBearing
                self.windSpeed = windSpeed
                
            }
            
        }
        
    }
    
    // MARK: Daily
    
    struct Daily {

        let days: [Day]

        init?(response: [String: Any]) {

            var daysResponse: [Day] = []
            guard let dataBlock = response["data"] as? [[String: Any]] else {return nil}
            for day in dataBlock {
                guard let completeDay = Day(response: day) else {return nil}
                print(completeDay)
                daysResponse.append(completeDay)
            }
            self.days = daysResponse

        }

        struct Day: DataPoint, DataPointDailyOnly, DataPointNotMinutely, DataPointHourlyDailyOnly  {
            
            // Data Point
            var cloudCover: Double?
            var dewPoint: Double?
            var humidity: Double?
            var icon: SummaryIconType?
            var ozone: Double?
            var precipIntensity: Double?
            var precipProbability: Double?
            var precipType: PrecipType?
            var pressure: Double?
            var summary: String?
            var time: Double
            var visibility: Double?
            var windBearing: Double?
            var windSpeed: Double?
            
            // Data Point (Daily Only)
            var apparentTemperatureMax: Double?
            var apparentTemperatureMaxTime: Double?
            var apparentTemperatureMin: Double?
            var apparentTemperatureMinTime: Double?
            var moonPhase: Double?
            var precipIntensityMax: Double?
            var precipIntensityMaxTime: Double?
            var sunriseTime: Double?
            var sunsetTime: Double?
            var temperatureMax: Double?
            var temperatureMaxTime: Double?
            var temperatureMin: Double?
            var temperatureMinTime: Double?
            
            // Data Point (Hourly & Daily Only)
            var precipAccumulation: Double?
            
            // Data Point (Not Minutely)
            var temperature: Double?
            

            init?(response: [String: Any]) {

                guard
                    let apparentTemperatureMax = response["apparentTemperatureMax"] as? Double,
                    let apparentTemperatureMaxTime = response["apparentTemperatureMaxTime"] as? Double,
                    let apparentTemperatureMin = response["apparentTemperatureMin"] as? Double,
                    let apparentTemperatureMinTime = response["apparentTemperatureMinTime"] as? Double,
                    let cloudCover = response["cloudCover"] as? Double,
                    let dewPoint = response["dewPoint"] as? Double,
                    let humidity = response["humidity"] as? Double,
                    let icon = response["icon"] as? String,
                    let moonPhase = response["moonPhase"] as? Double,
                    let ozone = response["ozone"] as? Double,
                    let precipIntensity = response["precipIntensity"] as? Double,
                    let precipIntensityMax = response["precipIntensityMax"] as? Double,
                    let precipProbability = response["precipProbability"] as? Double,
                    let pressure = response["pressure"] as? Double,
                    let summary = response["summary"] as? String,
                    let sunriseTime = response["sunriseTime"] as? Double,
                    let sunsetTime = response["sunsetTime"] as? Double,
                    let temperatureMax = response["temperatureMax"] as? Double,
                    let temperatureMaxTime = response["temperatureMaxTime"] as? Double,
                    let temperatureMin = response["temperatureMin"] as? Double,
                    let temperatureMinTime = response["temperatureMinTime"] as? Double,
                    let time = response["time"] as? Double,
                    let windSpeed = response["windSpeed"] as? Double
                    else {return nil}
                
                let precipAccumulation = response["precipAccumulation"] as? Double
                let precipIntensityMaxTime = response["precipIntensityMaxTime"] as? Double
                let precipType = response["precipType"] as? String ?? "none"
                let visibility = response["visibility"] as? Double
                let windBearing = response["windBearing"] as? Double
                
                self.apparentTemperatureMax = apparentTemperatureMax
                self.apparentTemperatureMaxTime = apparentTemperatureMaxTime
                self.apparentTemperatureMin = apparentTemperatureMin
                self.apparentTemperatureMinTime = apparentTemperatureMinTime
                self.cloudCover = cloudCover
                self.dewPoint = dewPoint
                self.humidity = humidity
                self.icon = SummaryIconType.generateType(fromResponse: icon)
                self.moonPhase = moonPhase
                self.ozone = ozone
                self.precipAccumulation = precipAccumulation
                self.precipIntensity = precipIntensity
                self.precipIntensityMax = precipIntensityMax
                self.precipIntensityMaxTime = precipIntensityMaxTime
                self.precipProbability = precipProbability
                self.precipType = PrecipType.generateType(fromResponse: precipType)
                self.pressure = pressure
                self.summary = summary
                self.sunriseTime = sunriseTime
                self.sunsetTime = sunsetTime
                self.temperatureMax = temperatureMax
                self.temperatureMaxTime = temperatureMaxTime
                self.temperatureMin = temperatureMin
                self.temperatureMinTime = temperatureMinTime
                self.time = time
                self.visibility = visibility
                self.windBearing = windBearing
                self.windSpeed = windSpeed
                
            }
        }
        
    }
    
}
