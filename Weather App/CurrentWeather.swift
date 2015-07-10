//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Brandon Lee on 7/2/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    let temperature: Int
    let humidity: Int
    let precipProbability: Int
    let summary: String
    
    // Initialize struct values towards plist values
    init(weatherDictionary: [String: AnyObject]) {
        
        temperature = weatherDictionary["temperature"] as! Int
        
        let humidityFloat = weatherDictionary["humidity"] as! Double
        humidity = Int(humidityFloat * 100)
        
        let precipProbabilityFloat = weatherDictionary["precipProbability"] as! Double
        precipProbability = Int(precipProbabilityFloat * 100)
        
        summary = weatherDictionary["summary"] as! String
    }
}