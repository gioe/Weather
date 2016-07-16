//
//  MainViewController.swift
//  1Cast
//
//  Created by Matt Gioe on 7/15/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var currentUser = User()
    var currentZip : String?
    @IBOutlet weak var weatherImage: SKYIconView! {
        didSet{
            self.weatherImage.play()
        }
    }
    
    @IBOutlet weak var tempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentZip = currentUser.zipCode
        weatherImage.hidden = true
        makeWeatherCall()

    }
    override func viewWillAppear(animated: Bool) {
        if currentZip != currentUser.zipCode{
            currentZip = currentUser.zipCode
            makeWeatherCall()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkStringForWeather(weatherDescription : String, time : String) -> Skycons {
        
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
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dayTimePeriodFormatter = NSDateFormatter()
        // Returns date formatted as 12 hour time.
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        return dayTimePeriodFormatter.stringFromDate(date)
    }
    
    func makeWeatherCall(){
        APIHelper.makeJSONRequest(APIHelper.GetForecastForCoordinate(coordinate: currentUser.location!), success: { (json) in
            print(json)
            let currentSummary = json["hourly"]["data"][0]["icon"].stringValue
            let currentTime = json["hourly"]["data"][0]["time"].doubleValue
            let currentTemperature = json["hourly"]["data"][0]["apparentTemperature"].doubleValue
            self.weatherImage.setType = self.checkStringForWeather(currentSummary, time:self.timeStringFromUnixTime(currentTime))
            self.weatherImage.play()
            self.weatherImage.hidden = false
            self.tempLabel.text = "\(String(Int(currentTemperature)))℉"
            
        }) { (error) in
        }
    }
}
