//
//  Localize.swift
//  
//
//  Created by Narongrit Kanhanoi on 11/9/2563 BE.
//

import Foundation

public class Localize {
    
    static private let defaultLocale = "en"
    static private var _locale = ""
    
    public static var currentLocale:String {
        get{
            if _locale == "" {
                let pref = UserDefaults.standard
                let locale = pref.string(forKey: "in-app-locale") ?? defaultLocale
                _locale = locale
            }
            return _locale
        }
    }
    
    public static func update(locale: String){
        _locale = locale
        let pref = UserDefaults.standard
        pref.set(locale, forKey: "in-app-locale")
        pref.synchronize()
    }
    
}
