//
//  ForecastDataStore.swift
//  BikeOrNot
//
//  Created by Joel Bell on 10/8/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation
import CoreLocation


//struct ForecastViewModel {
//    
//    var temperature: String
//    
//    init(_ completion: () -> ()) {
//        self.temperature = "test"
//        completion()
//        
//        let stageManager = StateManager { () -> NetworkProvider in
//            return NetworkProvider()
//        }
//        
//    }
//    
//}
//
//class NetworkProvider {
//    init(_ urlString: String) {
//        
//    }
//}
//
//class StateManager {
//    let networkProvider: NetworkProvider
//    
//    init(
//        networkProviderCreator: () -> NetworkProvider = StateManager.defaultNetworkCreator()
//        ) {
//        networkProvider = networkProviderCreator()
//    }
//    
//    class func defaultNetworkCreator() -> (() -> NetworkProvider) {
//        return {
//            NetworkProvider("https://api.wherever.com")
//        }
//    }
//}


//import Foundation
//import CoreLocation
//
//struct ForecastViewModel {
//    
//    var currently: Currently?
//    var hourly: Hourly?
//    var daily: Daily?
//    
//    static func getInitialForecast(at location: CLLocation, completionHandler: @escaping (ForecastViewModel?, Error?) -> ()) {
//        
//        let networkManager = NetworkManager()
//        networkManager.getInitialForecast(at: location) { response, placemark, error in
//            
//            // TO DO: handle possible nil values
//            
//            let forecast = Forecast(response: response!, placemark: placemark)
//            var forecastViewModel = ForecastViewModel()
//            forecastViewModel.currently = Currently(model: forecast!)
//            forecastViewModel.hourly = Hourly(model: forecast!)
//            forecastViewModel.daily = Daily(model: forecast!)
//            
//            completionHandler(forecastViewModel, nil)
//            
//        }
//    }
//    
//    struct Currently {
//        
//        let displayTemperature: String
//        let displayPlace: String
//        let displaySummary: String
//        let displayPrecipProbability: String
//        let displayWindSpeed: String
//        let displayVisibility: String
//        let displayHumidity: String
//        let displayApparentTemp: String
//        let displayHiLoTemp: String
//        
//        init(model: Forecast) {
//            
//            if
//                let subLocality = model.placemark?.addressDictionary?["SubLocality"],
//                let state = model.placemark?.addressDictionary?["State"] {
//                displayPlace = "\(subLocality), \(state)"
//            } else {
//                displayPlace = "Undetermined locality"
//            }
//            
//            displayTemperature = "\(Int(round(model.currently.temperature)))°"
//            displaySummary = model.currently.summary
//            displayPrecipProbability = "\(Int(model.currently.precipProbability * 100))" + "%"
//            displayWindSpeed = "\(Int(round(model.currently.windSpeed)))" + " mph"
//            displayVisibility = "\(Int(round(model.currently.visibility)))" + " mi"
//            displayHumidity = "\(Int(model.currently.humidity * 100))" + "%"
//            displayApparentTemp = "\(Int(round(model.currently.apparentTemperature)))°"
//            
//            let displayMinTemp = "\(Int(round(model.daily.days.first!.temperatureMin)))°"
//            var displayMaxTemp: String
//            
//            if model.currently.time > (model.daily.days.first?.sunsetTime)! {
//                displayMaxTemp = "--°"
//            } else {
//                displayMaxTemp = "\(Int(round(model.daily.days.first!.temperatureMax)))°"
//            }
//            
//            displayHiLoTemp = displayMaxTemp + "/" + displayMinTemp
//            
//        }
// 
//    }
//    
//    struct Hourly {
//        
//        let hours: [Any]
//        
//        init(model: Forecast) {
//            
//            var displayHours: [Any] = []
//            
//            for (index, hour) in model.hourly.hours.enumerated() {
//                
//                let displayHour = Hour(modelHour: hour)
//                
//                let isMidnight = displayHour.displayTimeShort == "12" && displayHour.displayTimePeriod == "AM"
//                
//                if
//                    isMidnight &&
//                    index != model.hourly.hours.startIndex {
//                    
//                    displayHours.append(displayHour.displayDayShort)
//                    displayHours.append(displayHour)
//                    
//                } else {
//                    
//                    displayHours.append(displayHour)
//                    
//                }
//                
//            }
//            
//            hours = displayHours
//            
//        }
//        
//        struct Hour {
//            
//            let displayApparentTemperature: String
//            let displayCloudCover: String
//            let displayDayShort: String
//            let displayDewPoint: String
//            let displayHumidity: String
//            let displayIcon: String
//            let displayOzone: String
//            let displayPrecipIntensity: String
//            let displayPrecipProbability: String
//            let displayPressure: String
//            let displaySummary: String
//            let displayTemperature: String
//            let displayTimeShort: String
//            let displayTimePeriod: String
//            let displayVisibility: String
//            let displayWindSpeed: String
//            
//            let displayPrecipAccumulation: String?
//            let displayPrecipType: String?
//            let displayWindBearing: String?
//            
//            init(modelHour: Forecast.Hourly.Hour) {
//               
//                displayApparentTemperature = "\(Int(round(modelHour.apparentTemperature)))°"
//                displayHumidity = "\(Int(modelHour.humidity * 100))" + "%"
//                displayPrecipProbability = "\(Int(modelHour.precipProbability * 100))" + "%"
//                displaySummary = modelHour.summary
//                displayTemperature = "\(Int(round(modelHour.temperature)))°"
//                displayVisibility = "\(Int(round(modelHour.visibility)))" + " mi"
//                displayWindSpeed = "\(Int(round(modelHour.windSpeed)))" + " mph"
//                displayDayShort = Date(timeIntervalSince1970: modelHour.time).generateDayShortUppercasedText()
//                displayTimePeriod = Date(timeIntervalSince1970: modelHour.time).generateTimePeriodText()
//                displayTimeShort = Date(timeIntervalSince1970: modelHour.time).generateTimeShortText()
//                
//                // TO DO: Determine display conversion for:
//                displayCloudCover = ""
//                displayDewPoint = ""
//                displayIcon = modelHour.icon
//                displayOzone = ""
//                displayPrecipIntensity = ""
//                displayPressure = ""
//                displayPrecipAccumulation = ""
//                displayPrecipType = ""
//                displayWindBearing = ""
//                
//            }
//            
//        }
//        
//    }
//    
//    struct Daily {
//        
//        let days: [Day]
//        
//        init(model: Forecast) {
//            
//            var displayDays: [Day] = []
//            
//            model.daily.days.forEach {
//                let day = Day(modelDay: $0)
//                displayDays.append(day)
//            }
//            
//            days = displayDays
//            
//        }
//        
//        struct Day {
//            
//            var displayDayShort: String
//            
//            init(modelDay: Forecast.Daily.Day) {
//            
//                self.displayDayShort = Date(timeIntervalSince1970: modelDay.time).generateDayShortUppercasedText()
//                
//            }
//            
//        }
//    
//    }
//    
//}
//
//








