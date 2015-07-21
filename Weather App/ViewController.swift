//
//  ViewController.swift
//  Weather App
//
//  Created by Brandon Lee on 7/1/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Label outlets
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLevel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
    
    // Initilize API key
    private let forecastAPIKey = ""
    
    
    let coordinat: (lat: Double, long: Double) = (44.5736,-123.2750)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retrieveWeatherForcast()
        
        
        /* - OLD NOOB IMPLEMENTATION
        // Declare base URL and call it in forcast URL for specific locations
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forcastAPIKey)/")
        let forcastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
        
        // Data object to fetch weather data (synchronous way)
        /*
        let weatherData = NSData(contentsOfURL: forcastURL!, options: nil, error: nil)
        println(weatherData)
        */
        
        // Use NSURLSession API to fetch data (asynchronous way)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        // Create NSURLRequest object
        let request = NSURLRequest(URL: forcastURL!)
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data:
            NSData!, response: NSURLResponse!, error: NSError!) -> Void in
        })

        dataTask.resume()
        */
    }

    func retrieveWeatherForcast() {
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        
        // Trailing closure
        forecastService.getForecast(coordinat.lat, long: coordinat.long) {
            (let currently) in
            if let currentWeather = currently {
                
                // Update UI on the main thread (we're still in the background thread) with some GCD magic
                dispatch_async(dispatch_get_main_queue()) {
                    
                    // Execute trailing closure to update UI labels
                    if let temperature = currentWeather.temperature {
                        
                        // If refering to a stored property from within a closure, you have to use keyword 'self'
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    // Repeat same process for other labels
                    if let humidity = currentWeather.humidity {
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLevel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = summary
                    }
                }
            }
        }
    }
    
    @IBAction func refreshWeather() {
        retrieveWeatherForcast()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}