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
    
    init(weatherDictionary: [String: AnyObject]) {
        temperature = weatherDictionary["temperature"] as! Int
        humidity = weatherDictionary["hubidity"] as! Int
        precipProbability = weatherDictionary["precipChance"] as! Int
        summary = weatherDictionary["summary"] as! String
    }
}