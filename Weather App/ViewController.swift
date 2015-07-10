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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // If "CurrentWeather.plist" exists in the main directory of our project...
        // 1 - Assign path string to plistPath variable
        // 2 - Load contents of the plist into an NSDictionary instance
        // 3 - Load contents of dictionary of with "currently" key (if it exists) as any object
        if let plistPath = NSBundle.mainBundle().pathForResource("CurrentWeather", ofType: "plist"), let weatherDictionary = NSDictionary(contentsOfFile: plistPath), let currentWeatherDictionary = weatherDictionary["currently"] as? [String: AnyObject] {
            
            // Create instance of struct initilized with our plist values
            let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
            
            // Optional chanining and modifying label output
            currentTemperatureLabel?.text = "\(currentWeather.temperature)º"
            currentHumidityLabel?.text = "\(currentWeather.humidity)%"
            currentPrecipitationLevel?.text = "\(currentWeather.precipProbability)%"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}