//
//  DailyWeatherTableViewCell.swift
//  Weather App
//
//  Created by Brandon Lee on 8/20/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var dayLabel: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
