//
//  RPModel.swift
//  boodaBEST
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

import Foundation

public struct APIError: Codable {
    public let message: String

    public init(message: String) {
        self.message = message
    }
}

public protocol RPModel {

}

public protocol JSONModel {
    var json: JSON? { get set }
    mutating func set(json: String?) -> Bool
    mutating func set(json: Data?) -> Bool
}

extension JSONModel where Self: RPModel {
    
    public mutating func set(json: String?) -> Bool {
        guard let json = json else{ return false }
        return set(json: json.data(using: .utf8))
    }
    
    public mutating func set(json: Data?) -> Bool {
        guard let json = json else{ return false }
        if let jsonObject = try? JSON(data: json) {
            self.json = jsonObject
            return true
        }
        return false
    }
    
}
