//
//  SetupView.swift
//  1Cast
//
//  Created by Matt Gioe on 7/14/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit
import CoreLocation

protocol MessageDelegate {
    func pushNextView()
}

@IBDesignable class SetupView: UIView {
    
    var view: UIView!
    var questionsArray = []
    var currentIndex : Int = 0
    var datePicker:UIDatePicker?
    var delegate: MessageDelegate?
    var currentUser = User()
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.text = questionsArray[currentIndex]["Question"] as? String
        }
    }
    
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.setTitle(questionsArray[currentIndex]["ButtonTitle"] as? String, forState: .Normal)
            submitButton.layer.cornerRadius = 4.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        let path = NSBundle.mainBundle().pathForResource("Questions", ofType:"plist")
        questionsArray = NSArray(contentsOfFile:path!)!
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
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
    
    
    @IBAction func saveResponse(sender: AnyObject) {
        
        currentIndex += 1
        
        switch currentIndex {
            
        case 1:
            
            APIHelper.makeJSONRequest(APIHelper.GetLocationFromZipCode(zipCode: inputTextField.text!), success: { (json) in
                let location = json["results"].arrayValue[0]["geometry"]["location"]
                let latitude = location["lat"].doubleValue
                let longitude = location["lng"].doubleValue
                self.currentUser.location = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
                }, failure: { (error) in
                    
            })

            headerLabel.text = questionsArray[currentIndex]["Question"] as? String
            submitButton.setTitle(questionsArray[currentIndex]["ButtonTitle"] as? String, forState: .Normal)
           inputTextField.removeFromSuperview()
            let datePicker = UIDatePicker.init(frame: CGRectMake(inputTextField.frame.origin.x, inputTextField.frame.origin.y, inputTextField.frame.size.width, inputTextField.frame.size.height * 2))
            datePicker.datePickerMode = .Time
            inputTextField.removeFromSuperview()
            addSubview(datePicker)
            
        case 2:
            delegate?.pushNextView()
            
        default: break
            
        }

    }
}


