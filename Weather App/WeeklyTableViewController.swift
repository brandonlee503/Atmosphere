//
//  WeeklyTableViewController.swift
//  Weather App
//
//  Created by Brandon Lee on 8/15/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentPrecipitationLevel: UILabel?
    @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
    
    // Initilize API key
    private let forecastAPIKey = ""
    
    let coordinat: (lat: Double, long: Double) = (44.5736,-123.2750)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = BackgroundView()
        retrieveWeatherForcast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    // MARK: - Weather Fetching
    
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
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLevel?.text = "\(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                }
            }
        }
    }
}