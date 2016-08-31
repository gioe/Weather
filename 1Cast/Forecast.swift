//
//  Forecast.swift
//  1Cast
//
//  Created by Matt Gioe on 7/15/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import Foundation

struct Forecast {
    let currentWeatherStatus : String
    let currentTemperature : String
    let currentTime : NSDate
    
    init (weatherStatus : String, temperature : String, time : NSDate){
        currentWeatherStatus = weatherStatus
        currentTemperature = temperature
        currentTime = time.convertToLocalTime()
    }
}