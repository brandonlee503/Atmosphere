//
//  Icon.swift
//  Weather App
//
//  Created by Brandon Lee on 8/16/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import UIKit

// Icon possibilities
enum Icon: String {
    
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> (regularIcon: UIImage?, largeIcon: UIImage?) {
        var imageName: String
        
        // Enums can be initilized with passing in a raw value
        // If the value matches one of the enum's values, we get it back
        switch self {
        case .ClearDay:
            imageName = "clear-day"
        case .ClearNight:
            imageName = "clear-night"
        case .Rain:
            imageName = "rain"
        case .Snow:
            imageName = "snow"
        case .Sleet:
            imageName = "sleet"
        case .Wind:
            imageName = "wind"
        case .Fog:
            imageName = "fog"
        case .Cloudy:
            imageName = "cloudy"
        case .PartlyCloudyDay:
            imageName = "cloudy-day"
        case .PartlyCloudyNight:
            imageName = "cloudy-night"
        }
        
        let regularIcon = UIImage(named: "\(imageName).png")
        let largeIcon = UIImage(named: "\(imageName)_large.png")
        
        return (regularIcon, largeIcon)
    }
}