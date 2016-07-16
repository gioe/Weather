//
//  Constants.swift
//  Weather
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import Foundation

struct Constants {
    
    static let ForecastAPIKey = "fa7fa58be6b3961fdd2486e753b0136d"
    static let GoogleAPIKey = "AIzaSyC19E6BSRQWmt-G7Lws5eZqIPiHYF8di0k"
    static let forecastRootURL = "https://api.forecast.io/forecast/\(ForecastAPIKey)/"
    static let googleRootURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    static let DatePickerShownNotification = "Date Picker Shown"
    static let LoginStatusKeyForDefaults = "Login Status"
    static let LatitudeKeyForDefaults = "Latitude"
    static let LongitudeKeyForDefaults = "Longitude"
    static let NotificationTimeKeyForDefaults = "Notification Time"
    static let ZipCodeKeyForDefaults = "ZipCode"
    static let MainViewSegueIdentifier = "showMainView"
    static let SetupSegueIdentifier = "showSetupView"


}