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
    @IBOutlet weak var refreshButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    // Initilize API key
    private let forecastAPIKey = ""
    
    
    let coordinat: (lat: Double, long: Double) = (44.5736,-123.2750)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        retrieveWeatherForcast()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    
                    self.toggleRefreshAnimation(false)
                }
            }
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForcast()
    }

    func toggleRefreshAnimation(on: Bool) {
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
}
