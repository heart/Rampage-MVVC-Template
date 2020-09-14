//
//  RP.swift
//  boodaBEST
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

import Foundation

public class RP {
    public typealias Clousure = () -> Void
    public static func async(clousure: @escaping Clousure) {
        DispatchQueue.global(qos: .userInitiated).async {
            clousure()
        }
    }

    public static func main(clousure: @escaping Clousure) {
        DispatchQueue.main.async {
            clousure()
        }
    }
}
