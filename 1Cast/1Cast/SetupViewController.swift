//
//  SettingsViewController.swift
//  Weather
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import CoreLocation

class SetupViewController: UIViewController {
    
    @IBOutlet var baseViewController: SetupView!
    
    @IBOutlet weak var textInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitResponse(sender: AnyObject) {
        _ = sender as! UIButton
//        baseViewController.handleQuestionSubmissionWithReponse = { _ in
//        
//        }
    }
}
