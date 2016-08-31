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
    var foreCastArray : [Forecast] = []
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
        makeWeatherCallWithCompletion { (success) in
            if success{
                //setup scrollview
                let scrollView = ForecastScrollView.init(frame: self.view.bounds, forecastArray: self.foreCastArray)
                self.view.addSubview(scrollView)
            }
        }

    }
    override func viewWillAppear(animated: Bool) {
        if currentZip != currentUser.zipCode{
            currentZip = currentUser.zipCode
//            makeWeatherCall()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dayTimePeriodFormatter = NSDateFormatter()
        // Returns date formatted as 12 hour time.
        dayTimePeriodFormatter.dateFormat = "hh:mm a"
        return dayTimePeriodFormatter.stringFromDate(date)
    }
    
    func makeWeatherCallWithCompletion(completion : (Bool) -> Void){
        APIHelper.makeJSONRequest(APIHelper.GetForecastForCoordinate(coordinate: currentUser.location!), success: { (json) in
            
            let currentForecastArray = json["hourly"]["data"].arrayValue
            
            for currentForecast in currentForecastArray{
                let date = NSDate(timeIntervalSince1970: currentForecast["time"].doubleValue)
                
                let forecast = Forecast.init(weatherStatus: currentForecast["summary"].stringValue, temperature: currentForecast["temperature"].stringValue, time: date)
                self.foreCastArray.append(forecast)
            }
            completion(true)
            
            
            
            
//            let currentSummary = json["hourly"]["data"][0]["icon"].stringValue
//            let currentTime = json["hourly"]["data"][0]["time"].doubleValue
//            let currentTemperature = json["hourly"]["data"][0]["apparentTemperature"].doubleValue
//            self.weatherImage.setType = self.checkStringForWeather(currentSummary, time:self.timeStringFromUnixTime(currentTime))
//            self.weatherImage.play()
//            self.weatherImage.hidden = false
//            self.tempLabel.text = "\(String(Int(currentTemperature)))℉"
            
        }) { (error) in
        }
    }

}

extension NSDate{
    func convertToLocalTime () -> NSDate{
        let offset = Double(NSTimeZone.localTimeZone().secondsFromGMT)
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return self.dateByAddingTimeInterval(offset)
    }
}




