//
//  RPModel.swift
//  boodaBEST
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

import Foundation

public struct APIError: Codable {
    public let message:String
    
    public init(message:String){
        self.message = message
    }
}

public protocol RPModel{
    
}

