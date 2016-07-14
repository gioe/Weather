//
//  PopupView.swift
//  Weather
//
//  Created by Matt Gioe on 6/28/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import Foundation
import UIKit
import PopupController

class PopupView: UIViewController, PopupContentViewController {
  
    var closeHandler: ((Bool) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func instance() -> PopupView {
        let storyboard = UIStoryboard(name: "PopupView", bundle: nil)
        return storyboard.instantiateInitialViewController() as! PopupView
    }
    
    // PopupContentViewController Protocol
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSizeMake(300,400)
    }

    @IBOutlet weak var enableNotificationsButton: UIButton!{
        didSet {
            enableNotificationsButton.layer.cornerRadius = 4.0

        }
    }
    
    @IBOutlet weak var cancelButton: UIButton!{
        didSet {
            cancelButton.layer.cornerRadius = 4.0
        }
    }
    
    @IBAction func pressedNotificationsButton(sender: AnyObject) {
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        closeHandler?(true)
    }
    
    @IBAction func pressedCloseButton(sender: AnyObject) {
        closeHandler?(false)
    }
}
