//
//  DailyWeather.swift
//  Weather App
//
//  Created by Brandon Lee on 8/16/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather {
    
    let maxTemperature: Int?
    let minTemperature: Int?
    let humidity: Int?
    let precipChance: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    var largeIcon: UIImage? = UIImage(named: "default_large.png")
    var sunriseTime: String?
    var sunsetTime: String?
    var day: String?
    
    // Date formatter stored property
    let dateFormatter = NSDateFormatter()
    
    init(dailyWeatherDict: [String: AnyObject]) {
        
        // Using the optional cast operator (as?) in case the dictionary we pass in doesn't contain the key, will still be stored as an optional
        maxTemperature = dailyWeatherDict["temperatureMax"] as? Int
        minTemperature = dailyWeatherDict["temperatureMin"] as? Int
        
        // Safely cast as Int
        if let humidityFloat = dailyWeatherDict["humidity"] as? Double {
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        
        if let precipChanceFloat = dailyWeatherDict["precipProbability"] as? Double {
            precipChance = Int(precipChanceFloat * 100)
        } else {
            precipChance = nil
        }
        
        summary = dailyWeatherDict["summary"] as? String
        
        // Chain optional binding command (versus nesting)
        if let iconString = dailyWeatherDict["icon"] as? String,
        let iconEnum = Icon(rawValue: iconString) {
            (icon, largeIcon) = iconEnum.toImage()
        }
        
        if let sunriseDate = dailyWeatherDict["sunriseTime"] as? Double {
            sunriseTime = timeStringFromUnixTime(sunriseDate)
        } else {
            sunriseTime = nil
        }
        
        if let sunsetDate = dailyWeatherDict["sunsetTime"] as? Double {
            sunsetTime = timeStringFromUnixTime(sunsetDate)
        } else {
            sunsetTime = nil
        }
        
        if let time = dailyWeatherDict["time"] as? Double {
            day = dayStringFromTime(time)
        }
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        
        // Returns date formatted as 12 hour timeg
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.stringFromDate(date)
    }
    
    func dayStringFromTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        
        // Ask for the current locale of the iPhone to display day correctly (eg. Language)
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        
        // Get full day name (eg. MONDAY)
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.stringFromDate(date)
    }
}