//
//  SettingsViewController.swift
//  Weather
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import CoreLocation

class SetupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var baseViewController: SetupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewController.inputTextField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SetupViewController.keyboardWasShown), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SetupViewController.keyboardWasHidden), name: UIKeyboardDidHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWasShown() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.baseViewController.frame.origin.y -= 100
        })
    }
    
    func keyboardWasHidden() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.baseViewController.frame.origin.y += 100
        })
    }

}
