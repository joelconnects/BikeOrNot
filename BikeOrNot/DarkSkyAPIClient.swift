//
//  DarkSkyAPIClient.swift
//  BikeOrNot
//
//  Created by Joel Bell on 10/8/16.
//  Copyright © 2016 CraftedByCrazy. All rights reserved.
//

import Foundation
import CoreLocation

class DarkSkyAPIManager: NSObject, NetworkOperationsManager {
    
    typealias ForecastResult = (forecast: APIResponse, placemark: PlacemarkResponse)
    
    var queue: OperationQueue = OperationQueue()
    
    func getForecast(at location: CLLocation, completionHandler: @escaping (ForecastResult) -> ()) {
        
        let forecastOperation = ForecastOperation(location: location)
        let placemarkOperation = PlacemarkOperation(location: location)
        
        queue.addOperations([forecastOperation, placemarkOperation], waitUntilFinished: false)
        
        queue.operations.onFinish {
            
            guard
                let forecastResponse = forecastOperation.response,
                let placemarkResponse = placemarkOperation.response
                else { completionHandler(forecast: APIResponse.failure(OperationError.failure), placemark: PlacemarkResponse.failure(OperationError.failure)) ; return }
            
            completionHandler((forecastResponse, placemarkResponse))
            
        }
        
    }
    
}

class ForecastOperation: OperationRequest {
    
    let location: CLLocation
    var response: APIResponse?
    
    init(location: CLLocation) {
        self.location = location
        super.init()
    }
    
    override func executeMainTask() {
        
        let router = DarkSkyAPIRouter(location: self.location)
        let client = DarkSkyAPIClient()
        client.request(router) { response in
            self.response = response
            self.state = .finished
        }
        
    }
    
}

class PlacemarkOperation: OperationRequest {
    
    let location: CLLocation
    var response: PlacemarkResponse?
    
    init(location: CLLocation) {
        self.location = location
        super.init()
    }
    
    override func executeMainTask() {
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            if let error = error {
                self.response = Result.failure(error)
            }
            if let placemark = placemarks?.first {
                self.response = Result.success(placemark)
            }
            self.state = .finished
        })
        
    }
    
}

struct DarkSkyAPIRouter: APIRouter {
    
    var baseUrl: String = "https://api.forecast.io"
    var path: String = "/forecast/"
    var method: HTTPMethod = .get
    var query: String? = "?exclude=minutely"
    
    init(location: CLLocation) {
        
        let initialPath = self.path
        self.path = initialPath + DarkSkyAPI.key + "/\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
        
    }
    
}

struct DarkSkyAPIClient: APIProxy {
    
    func request(_ request: APIRouter, completion: @escaping (APIResponse) -> ()) {

        guard let request = request.generateURLRequest() else { return completion(Result.failure(NetworkError.badRequest)) }

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            let result = ResultParser.parse((data, response, error))
                    
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! JSONResponse
                    completion(Result.success(json))
                } catch {
                    completion(Result.failure(NetworkError.parsingError))
                }
            case .failure(let error):
                    completion(Result.failure(error))
            }
            
        }.resume()

    }
    
}
