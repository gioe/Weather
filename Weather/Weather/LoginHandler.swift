//
//  LoginHandler.swift
//  3Cast
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import Foundation
private let LoginStatusKeyForDefaults = "Login Status"

enum LoginStatus : Int {
    
    //only two possible statuses
    case LoggedOut = 0
    case LoggedIn = 1
    
    //determine what the initial view controller is for the delegate when the app launches
    var associatedViewController: UIViewController {
        switch self {
        case .LoggedIn:
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as UIViewController
            return viewController
        default:
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier("IntroScrollView") as UIViewController
            return viewController
        }
    }
    
}

struct User {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //could have used core data here but using the defaults instead so we don't overcomplicate things. defaults only needs to tell us whether the user is logged in or not so we simulate a boolean and compute the property as we go
    
    var loginStatus : LoginStatus {
        get {
            if defaults.objectForKey (LoginStatusKeyForDefaults) != nil {
                return LoginStatus.init(rawValue: defaults.integerForKey(LoginStatusKeyForDefaults))!
            } else {
                return .LoggedOut
            }
        }
        set(newLoginStatus){
            defaults.setObject(newLoginStatus.rawValue, forKey: LoginStatusKeyForDefaults)
        }
    }
}