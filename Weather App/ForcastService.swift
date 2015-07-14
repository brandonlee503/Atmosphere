//
//  ForcastService.swift
//  Weather App
//
//  Created by Brandon Lee on 7/13/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation

struct ForcastService {
    
    // Struct properties
    let forcastAPIKey: String
    let forcastBaseURL: NSURL?
    
    // Initilize struct properties
    init(APIKey: String) {
        forcastAPIKey = APIKey
        forcastBaseURL = NSURL(string: "https://api.forcast.io/forcast/\(forcastAPIKey)/")
    }
    
    // Input location and a closure and return the forcast
    // Use closure here since we'll be calling the download JSON method of NetworkOperation
    func getForcast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
        
        // Safely initilize forcast URL
        if let forcastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forcastBaseURL) {
            
            let networkOperation = NetworkOperation(url: forcastURL)
            
            // Trailing closure
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let currentWeather = self.currentWeatherFromJSONDictionary(JSONDictionary)
                
                // This moves it up to the completion handler in parameter so that if we call the getForcast() method,
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