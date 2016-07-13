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
        self.view.backgroundColor = UIColor.whiteColor()
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
            enableNotificationsButton.layer.borderColor = UIColor(red: 242/255, green: 105/255, blue: 100/255, alpha: 1.0).CGColor
            enableNotificationsButton.backgroundColor = .redColor()
            enableNotificationsButton.layer.borderWidth = 1.5
        }
    }
    
    @IBOutlet weak var cancelButton: UIButton!{
        didSet {
            cancelButton.layer.borderColor = UIColor(red: 242/255, green: 105/255, blue: 100/255, alpha: 1.0).CGColor
            cancelButton.backgroundColor = .redColor()
            cancelButton.layer.borderWidth = 1.5
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