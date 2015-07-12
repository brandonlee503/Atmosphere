//
//  NetworkOperation.swift
//  Weather App
//
//  Created by Brandon Lee on 7/12/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    // Lazy Load these properties so they only get initilized right when we need to use them
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> ()
    
    init(url: NSURL){
        self.queryURL = url
    }
    
    func downloadJSONfromURL(completion: JSONDictionaryCompletion) {
        
        // Initilize request
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        
        // Callback with trailing closure shorthand (since closure is last parameter)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            // 1. Check HTTP response for sucessful GET request
            if let httpResponse = response as? NSHTTPURLResponse {
                
                switch(httpResponse.statusCode) {
                case 200:
                    // 2. Create JSON object with the return data
                    let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject]
                    
                    // Return JSON object to the initial function (the function containing this closure)
                    completion(jsonDictionary)
                    
                default:
                    println("GET request not sucessful. HTTP status code: \(httpResponse.statusCode)")
                }
                
            } else {
                println("Error - Not a valid HTTP response")
            }
        }
        
        dataTask.resume()
        
    }
}