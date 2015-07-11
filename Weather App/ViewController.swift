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
    
    private let forcastAPIKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Declare base URL and call it in forcast URL for specific locations
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forcastAPIKey)/")
        let forcastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
        
        // Data object to fetch weather data
        let weatherData = NSData(contentsOfURL: forcastURL!, options: nil, error: nil)
        println(weatherData)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}