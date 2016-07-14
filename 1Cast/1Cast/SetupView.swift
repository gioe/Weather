//
//  SetupView.swift
//  1Cast
//
//  Created by Matt Gioe on 7/14/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class SetupView: UIView {

    var questionsArray = ["What is your zipcode?", "What time would you like to be notified?", "To what degree of certainty do you want to be notified?", "What time frame would you like us to check for?"];

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.text = questionsArray[0]
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.layer.cornerRadius = 4.0
        }
    }
    
    func handleQuestionSubmissionWithReponse(answer : String, completionHandler : ((Bool) -> ())){
        
    }
    
    
}

