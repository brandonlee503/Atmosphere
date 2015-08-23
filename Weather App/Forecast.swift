//
//  Forecast.swift
//  Weather App
//
//  Created by Brandon Lee on 8/17/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation

// Main purpose is to act as a wrapper for both the CurrentWeather and DailyWeather models
struct Forecast {
    var currentWeather: CurrentWeather?
    var weekly: [DailyWeather] = []
    
    init(weatherDictionary: [String: AnyObject]?) {
        // Parse the contents of dictionary and create populated instance of current weather
        // Optional binding to make sure jsonDictionary returns non-nil value,
        // if so cast it to a dictionary type and assign to variable
        if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject] {
            currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }
        
        // Because of the JSON nested dictionary response... And some pro optional chaining
        if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]] {
            
            // Iterate over weeklyWeatherArray and retrieve each object cast it to the daily local variable
            for dailyWeather in weeklyWeatherArray {
                
                // Create object for each day and append to weekly array
                let daily = DailyWeather(dailyWeatherDict: dailyWeather)
                weekly.append(daily)
            }
        }
    }
}
