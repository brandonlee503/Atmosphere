//
//  ForecastService.swift
//  Weather App
//
//  Created by Brandon Lee on 7/13/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation

struct ForecastService {
    
    // Struct properties
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    
    // Initilize struct properties
    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    // Input location and a closure and return the forecast
    // Use closure here since we'll be calling the download JSON method of NetworkOperation
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
        
        // Safely initilize forecast URL
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {
            
            let networkOperation = NetworkOperation(url: forecastURL)
            
            // Trailing closure
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSONDictionary(JSONDictionary)
                
                // This moves it up to the completion handler in parameter so that if we call the getForecast() method,
                // and complete the completion handler and access the currentWeather variable, we get access to the
                // populated instance that we're passing up.
                completion(currentWeather)
            }
            
        } else {
            println("Could not construct a valid URL")
        }
    }
    
    // Parse the contents of dictionary and create populated instance of current weather
    func currentWeatherFromJSONDictionary(jsonDictionary: [String: AnyObject]?) -> CurrentWeather? {
        
        // Optional binding to make sure jsonDictionary returns non-nil value,
        // if so cast it to a dictionary type and assign to variable
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject] {
            
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
            
        } else {
            println("JSON Dictionary returned nil for 'currently' key")
            return nil
        }
    }
}