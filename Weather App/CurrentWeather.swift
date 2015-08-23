//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Brandon Lee on 7/2/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    
    // Set icon to a default
    var icon : UIImage? = UIImage(named: "default.png")
    
    // Initialize struct values towards plist values
    init(weatherDictionary: [String: AnyObject]) {
        
        temperature = weatherDictionary["temperature"] as? Int
        
        if let humidityFloat = weatherDictionary["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }

        if let precipProbabilityFloat = weatherDictionary["precipProbability"] as? Double {
            precipProbability = Int(precipProbabilityFloat * 100)
        } else {
            precipProbability = nil
        }
        
        // Set weather summary
        summary = weatherDictionary["summary"] as? String
        
        // Set Icon Image
        if let iconString = weatherDictionary["icon"] as? String, let weatherIcon: Icon = Icon(rawValue: iconString) {
            
            // When a method returns a tuple, we can grab both values by using constants in parentheses
            // Using an underscore for the second element tells Swift to ignore it
            (icon, _) = weatherIcon.toImage()
        }
    }
}