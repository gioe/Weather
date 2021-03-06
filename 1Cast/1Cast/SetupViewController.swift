//
//  SettingsViewController.swift
//  Weather
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import CoreLocation

class SetupViewController: UIViewController, UITextFieldDelegate, MessageDelegate {
    
    var currentUser = User()

    @IBOutlet weak var baseViewController: SetupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewController.inputTextField.delegate = self
        baseViewController.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SetupViewController.keyboardWasShown), name: UIKeyboardDidShowNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWasShown() {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.baseViewController.frame.origin.y -= 100
        })
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func pushNextView() {
        performSegueWithIdentifier(Constants.MainViewSegueIdentifier, sender: nil)
        currentUser.loginStatus = .PastSetup
    }

}
