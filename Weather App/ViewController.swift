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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}