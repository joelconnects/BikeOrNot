////
////  APIManager.swift
////  BikeOrNot
////
////  Created by Joel Bell on 2/2/17.
////  Copyright © 2017 CraftedByCrazy. All rights reserved.
////

import Foundation
import CoreLocation

typealias JSONResponse = [String: Any]
typealias APIResponse = Result<JSONResponse?>
typealias PlacemarkResponse = Result<CLPlacemark?>
typealias DataTaskResponse = (data: Data?, urlResponse: URLResponse?, error: Error?)
typealias DataTaskParserResult = Result<Data?>

protocol APIProxy {
    func request(_ router: APIRouter, completion: @escaping (APIResponse) -> ())
    
}

protocol APIRouter {
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var query: String? { get }
}

extension APIRouter {
    
    func generateURLRequest() -> URLRequest? {
        
        let constructedURL = URL(string: baseUrl + path + (query ?? ""))
        guard let url = constructedURL else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
        
    }
    
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

enum NetworkError: Error {
    
    case badRequest
    case badResponse
    case parsingError
    case notFound
    case serverError(statusCode: Int)
    case undefined(statusCode: Int)
    case other(Error)
    
}

enum OperationError: Error {
    
    case failure
    
}

struct ResultParser {
    
    static func parse(_ response: DataTaskResponse) -> DataTaskParserResult {
        if let error = response.error {
            return .failure(NetworkError.other(error))
        }
        guard let urlResponse = response.urlResponse as? HTTPURLResponse else {
            return .failure(NetworkError.badResponse)
        }
        if let error = self.error(forStatusCode: urlResponse.statusCode) {
            return .failure(error)
        }
        if let data = response.data {
            return .success(data)
        } else {
            return .failure(NetworkError.parsingError)
        }
        
    }
    
    fileprivate static func error(forStatusCode code: Int) -> NetworkError? {
        switch code {
        case 200...299:
            return nil
        case 404, 410:
            return .notFound
        case 500...599:
            return .serverError(statusCode: code)
        default:
            return .undefined(statusCode: code)
        }
    }
}






