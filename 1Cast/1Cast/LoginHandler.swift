
//
//  LoginHandler.swift
//  3Cast
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

enum LoginStatus : Int {
    
    //only two possible statuses
    case Onboarding = 0
    case NotPastSetup = 1
    case PastSetup = 2
    
    //determine what the initial view controller is for the delegate when the app launches
    var associatedViewController: UIViewController {
        switch self {
        case .Onboarding:
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("IntroScrollView") as UIViewController
            return viewController
        case .NotPastSetup:
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("SetupViewController") as UIViewController
            return viewController
        case .PastSetup:
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as UIViewController
            return viewController
        }
    }
    
}

struct User {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var deviceToken : String? {
        get {
            if let deviceToken = defaults.stringForKey(Constants.DeviceTokenKeyForDefaults){
                return deviceToken
            } else {
                return nil
            }
        }
        
        set(newToken){
            defaults.setObject(newToken, forKey: Constants.DeviceTokenKeyForDefaults)
        }

    }
    
    var timeZone : String? {
        get {
            return NSTimeZone.localTimeZone().name
        }
    }
    
    var userID : String? {
        get {
            if let userID = defaults.stringForKey(Constants.UserIDKeyForDefaults){
                return userID
            } else {
                return nil
            }
        }
        
        set(newID){
            defaults.setObject(newID, forKey: Constants.UserIDKeyForDefaults)
        }
    }
    
    var zipCode : String?{
        get {
            
            if let zipCode = defaults.stringForKey(Constants.ZipCodeKeyForDefaults){
                return zipCode             } else {
                return nil
            }
        }
        
        set(newZip){
            defaults.setObject(newZip, forKey: Constants.ZipCodeKeyForDefaults)
        }
    }
    
    var notificationTimeUTC : String?{
        get {
            
            if let time = defaults.stringForKey(Constants.NotificationTimeKeyForDefaults){
                return time
            } else {
                return nil
            }
        }
        
        set(newtime){
            
            let offset = Double(NSTimeZone.localTimeZone().secondsFromGMT)
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
            let date = dateFormatter.dateFromString(newtime!)
            let finalDateString : String
            
            if offset > 0 {
                let finalTime = date!.dateByAddingTimeInterval(offset)
                dateFormatter.dateFormat = "HH:mm:ss"
                finalDateString = dateFormatter.stringFromDate(finalTime)
            } else {
                let finalTime = date!.dateByAddingTimeInterval(offset * -1)
                dateFormatter.dateFormat = "HH:mm:ss"
                finalDateString = dateFormatter.stringFromDate(finalTime)
            }
            
            defaults.setObject(finalDateString, forKey: Constants.NotificationTimeKeyForDefaults)
            
        }
    }
    
    var setNotificationTime : String?{
        get {
            if let time = defaults.stringForKey(Constants.SetNotificationTimeKeyForDefaults){
                return time
            } else {
                return nil
            }
        }
        
        set(newtime){
            defaults.setObject(newtime, forKey: Constants.SetNotificationTimeKeyForDefaults)

        }
    }

    
    var location : CLLocationCoordinate2D?{
        get {
            
            if let latitude = defaults.objectForKey(Constants.LatitudeKeyForDefaults){
                let location = CLLocationCoordinate2D.init(latitude: latitude as! CLLocationDegrees, longitude: defaults.objectForKey(Constants.LongitudeKeyForDefaults) as! CLLocationDegrees)
                return location
            } else {
                return nil
            }
        }
        
        set(newLocation){
            defaults.setObject(newLocation?.latitude, forKey: Constants.LatitudeKeyForDefaults)
            defaults.setObject(newLocation?.longitude, forKey: Constants.LongitudeKeyForDefaults)
        }
        
    }
    
    
    var loginStatus : LoginStatus {
        get {
            if defaults.objectForKey (Constants.LoginStatusKeyForDefaults) != nil {
                return LoginStatus.init(rawValue: defaults.integerForKey(Constants.LoginStatusKeyForDefaults))!
            } else {
                return .Onboarding
            }
        }
        set(newLoginStatus){
            defaults.setObject(newLoginStatus.rawValue, forKey: Constants.LoginStatusKeyForDefaults)
        }
    }
}