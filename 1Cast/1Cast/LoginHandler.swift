
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

private let LoginStatusKeyForDefaults = "Login Status"
private let LatitudeKeyForDefaults = "Latitude"
private let LongitudeKeyForDefaults = "Longitude"
private let NotificationTimeKeyForDefault = "Notification Time"

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
    
    var notificationTime : String?{
        get {
            
            if let time = defaults.objectForKey(NotificationTimeKeyForDefault){
                return time as? String
            } else {
                return nil
            }
        }
        
        set(newtime){
            defaults.setObject(newtime, forKey: NotificationTimeKeyForDefault)
        }
    }

    
    var location : CLLocationCoordinate2D?{
        get {
            
            if let latitude = defaults.objectForKey(LatitudeKeyForDefaults){
                let location = CLLocationCoordinate2D.init(latitude: latitude as! CLLocationDegrees, longitude: defaults.objectForKey(LongitudeKeyForDefaults) as! CLLocationDegrees)
                return location
            } else {
                return nil
            }
        }
        
        set(newLocation){
            defaults.setObject(newLocation?.latitude, forKey: LatitudeKeyForDefaults)
            defaults.setObject(newLocation?.longitude, forKey: LongitudeKeyForDefaults)
        }
        
    }
    
    
    var loginStatus : LoginStatus {
        get {
            if defaults.objectForKey (LoginStatusKeyForDefaults) != nil {
                return LoginStatus.init(rawValue: defaults.integerForKey(LoginStatusKeyForDefaults))!
            } else {
                return .Onboarding
            }
        }
        set(newLoginStatus){
            defaults.setObject(newLoginStatus.rawValue, forKey: LoginStatusKeyForDefaults)
        }
    }
}