//
//  SetupView.swift
//  1Cast
//
//  Created by Matt Gioe on 7/14/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

@IBDesignable class SetupView: UIView {
    
    var view: UIView!
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SetupView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
    @IBAction func submitResponse(sender: AnyObject) {
        
        
    }
    
}

