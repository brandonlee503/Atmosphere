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
    
    var weeklyWeather: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveWeatherForcast()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        
        // Set tableview's background view property
        tableView.backgroundView = BackgroundView()
        
        // Set custom height for tableView row
        tableView.rowHeight = 64
        
        // Change font/size of navbar text
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let navBarAttributesDictionary: [NSObject: AnyObject]? = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: navBarFont]
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
    }

    // MARK: - Table view data source

    // Tells tableView number of sections it has to display
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    // Let tableView know how many rows to display in section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! UITableViewCell
        
        // Query weeklyWeather stored property to get particular index
        let dailyWeather = weeklyWeather[indexPath.row]
        cell.textLabel?.text = dailyWeather.day
        
        return cell
    }
    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForcast() {
        
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        
        // Trailing closure
        forecastService.getForecast(coordinat.lat, long: coordinat.long) {
            (let forecast) in
            if let weatherForecast = forecast,
                let currentWeather = weatherForecast.currentWeather {
                
                // Update UI on the main thread (we're still in the background thread) with some GCD magic
                dispatch_async(dispatch_get_main_queue()) {
                    
                    // Execute trailing closure to update UI labels
                    if let temperature = currentWeather.temperature {
                        
                        // If refering to a stored property from within a closure, you have to use keyword 'self'
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    // Repeat same process for other labels
                    if let precipitation = currentWeather.precipProbability {
                        self.currentPrecipitationLevel?.text = "Rain: \(precipitation)%"
                    }
                    
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    }
                    
                    self.weeklyWeather = weatherForecast.weekly
                    
                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature {
                            self.currentTemperatureRangeLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
}