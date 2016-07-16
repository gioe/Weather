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
        
        switch currentIndex {
            
        case 0:
            
            guard inputTextField.text?.characters.count == 5 else {
                return
            }
            
            currentUser.zipCode = inputTextField.text
            APIHelper.makeJSONRequest(APIHelper.GetLocationFromZipCode(zipCode: inputTextField.text!), success: { (json) in
                let location = json["results"].arrayValue[0]["geometry"]["location"]
                let latitude = location["lat"].doubleValue
                let longitude = location["lng"].doubleValue
                self.currentUser.location = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
                }, failure: { (error) in
                    
            })
            
            inputTextField.text=""
            inputTextField.resignFirstResponder()
            headerLabel.text = questionsArray[currentIndex + 1]["Question"] as? String
            submitButton.setTitle(questionsArray[currentIndex + 1]["ButtonTitle"] as? String, forState: .Normal)
            currentIndex += 1
            
        case 1:
            
            guard inputTextField.text != nil else {
                return
            }
            
            currentUser.notificationTime = inputTextField.text
            delegate?.pushNextView()
            
        default: break
            
        }
    }
    
    
    @IBAction func textFieldEditing(sender: UITextField) {
        switch currentIndex {
            
        case 0:
            sender.keyboardType = .NumberPad
        case 1:
            let datePickerView : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Time
            datePickerView.frame = CGRectMake(0, 0, 320, 140)
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(SetupView.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        default:
            break
        }

    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        inputTextField.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
}


