//
//  ViewController.swift
//  Weather App
//
//  Created by Brandon Lee on 7/1/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dailyWeather: DailyWeather? {
        
        //TODO: didSet calls configureView while outlets are still nil, restructure app for dailyWeather property to be set after the view is fully initialized
        didSet {
            configureView()
        }
    }
    
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var sunriseLabel: UILabel?
    @IBOutlet weak var sunsetLabel: UILabel?
    
    @IBOutlet weak var lowTemperatureLabel: UILabel?
    @IBOutlet weak var highTemperatureLabel: UILabel?
    @IBOutlet weak var precipitationLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Call configure view again since prepareForSegue method immediately calls didSet observer
        which calls configureView() while the values are nil...*/
        configureView()
    }
    
    func configureView() {

        // Update UI with information from data model
        if let weather = dailyWeather {
            weatherIcon?.image = weather.largeIcon
            summaryLabel?.text = weather.summary
            sunriseLabel?.text = weather.sunriseTime
            sunsetLabel?.text = weather.sunsetTime

            // Set navbar day title
            self.title = weather.day
            
            if let lowTemp = weather.minTemperature,
               let highTemp = weather.maxTemperature,
               let rain = weather.precipChance,
               let humidity = weather.humidity {
                    lowTemperatureLabel?.text = "\(lowTemp)º"
                    highTemperatureLabel?.text = "\(highTemp)º"
                    precipitationLabel?.text = "\(rain)%"
                    humidityLabel?.text = "\(humidity)%"
                
            }
            
            //TODO: Figure out - Why can't we just do this?
            /*
            lowTemperatureLabel?.text = weather.minTemperature
            highTemperatureLabel?.text = weather.maxTemperature
            precipitationLabel?.text = weather.precipChance
            */
            
        }
        
        // Config navbar back button
        if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
            let barButtonAttributesDictionary: [NSObject: AnyObject]? = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: buttonFont]
            
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
