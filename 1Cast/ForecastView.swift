//
//  ForecastView.swift
//  OneCast
//
//  Created by Matt Gioe on 8/23/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ForecastView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, forecast : Forecast){
        self.init(frame: frame)
        setupForecastView(frame, forecast: forecast)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupForecastView(frame : CGRect, forecast : Forecast){
        
        let skycon = SKYIconView()
        skycon.frame = CGRectMake(0, 0, frame.size.height / 2, frame.size.height / 2)
        skycon.backgroundColor = .clearColor()
        skycon.setType = .Cloudy
        addSubview(skycon)
        skycon.play()
        skycon.center.x = bounds.midX
        skycon.center.y = bounds.midY
        
        let temperatureLabel = UILabel.init(frame: CGRectMake(0, skycon.frame.origin.y + skycon.frame.size.height, frame.width, 100))
        temperatureLabel.text = forecast.currentTemperature
        temperatureLabel.textAlignment = .Center
        temperatureLabel.font = UIFont.systemFontOfSize(40)
        addSubview(temperatureLabel)
    
    }
    
    func checkStringForWeather(weatherDescription : String) -> Skycons {
        
        if weatherDescription.containsString("partly-cloudy-night"){
            return .PartlyCloudyNight
        } else if weatherDescription.containsString("partly-cloudy-day"){
            return .PartlyCloudyDay
        } else if weatherDescription.containsString("cloudy"){
            return .Cloudy
        } else if weatherDescription.containsString("rain"){
            return .Rain
        } else if weatherDescription.containsString("snow"){
            return .Snow
        }else if weatherDescription.containsString("clear-night"){
            return .ClearNight
        }else if weatherDescription.containsString("fog"){
            return .Fog
        } else {
            return .ClearDay
        }
    }

}
