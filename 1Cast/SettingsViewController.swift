//
//  SettingsViewController.swift
//  1Cast
//
//  Created by Matt Gioe on 7/15/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var currentUser = User()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var zipCodeView: SettingSubView! {
        didSet{
            zipCodeView.actionButton.tag = 0
            zipCodeView.descriptionLabel.text = "Zip Code"
            zipCodeView.valueLabel.text = currentUser.zipCode
        }
    }
    
    @IBOutlet weak var timeSettingView: SettingSubView! {
        didSet{
            timeSettingView.actionButton.tag = 1
            timeSettingView.descriptionLabel.text = "Notification Time"
            timeSettingView.valueLabel.text = currentUser.notificationTime
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
