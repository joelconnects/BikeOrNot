//
//  Error.swift
//  BikeOrNot
//
//  Created by Joel Bell on 2/2/17.
//  Copyright © 2017 CraftedByCrazy. All rights reserved.
//

import Foundation



enum SomeError: Error {
    
    case badRequest
    case parsingError

}

protocol DictionaryInitializable {
    init(data: [String: Any]) throws
}

struct User: DictionaryInitializable {
    let name: String
    let age: Int
    init(data: [String : Any]) throws {
        guard
            let name = data["name"] as? String,
            let age = data["age"] as? Int
            else { throw SomeError.parsingError }
    
        self.name = name
        self.age = age
    }
    
}
