//
//  SettingSubView.swift
//  OneCast
//
//  Created by Matt Gioe on 7/15/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import ARSLineProgress

@IBDesignable class SettingSubView: UIView {
  
    var view: UIView!
    var currentUser = User()
    let defaults = NSUserDefaults.standardUserDefaults()
    var textField : UITextField = UITextField()
    var newLabel : UILabel = UILabel()
    var labelFrame : CGRect?
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        view = loadViewFromNib()
        labelFrame = valueLabel.frame
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SettingSubView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    @IBAction func changeSetting(sender: AnyObject) {
        let button = sender as! UIButton
        switch button.titleLabel!.text! {
        case "Done":
            button.setTitle("Edit", forState: UIControlState.Normal)
            handleValueChangeDone(button.tag)
        default:
            button.setTitle("Done", forState: UIControlState.Normal)
            handleEditRequest(button.tag)
        }
    }
    
    func handleEditRequest(tagValue : Int){
        switch tagValue {
        case 0:
            
            textField.frame = labelFrame!
            textField.backgroundColor = UIColor.whiteColor()
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.text = currentUser.zipCode
            
            if let oldLabel = valueLabel{
                oldLabel.removeFromSuperview()
            } else {
                newLabel.removeFromSuperview()
            }
            
            addSubview(textField)
            textField.becomeFirstResponder()
            
        case 1:
            
            textField.frame = labelFrame!
            textField.backgroundColor = UIColor.whiteColor()
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.text = currentUser.setNotificationTime
            
            if let oldLabel = valueLabel{
                oldLabel.removeFromSuperview()
            } else {
                newLabel.removeFromSuperview()
            }
            
            let datePickerView : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.Time
            datePickerView.frame = CGRectMake(0, 0, 320, 140)
            textField.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(SettingSubView.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
            addSubview(textField)
            textField.becomeFirstResponder()

        default:
            break
        }
    }
    
    func handleValueChangeDone(tagValue : Int) {
        switch tagValue {
            case 0:
                
                guard textField.text?.characters.count == 5 else {
                    return
                }
                
                newLabel.frame = labelFrame!
                newLabel.font = UIFont (name: "Futura", size: 22)
                currentUser.zipCode = textField.text
                textField.removeFromSuperview()
                newLabel.text = currentUser.zipCode
                
                APIHelper.makeJSONRequest(APIHelper.GetLocationFromZipCode(zipCode: currentUser.zipCode), success: { (json) in
                    let location = json["results"].arrayValue[0]["geometry"]["location"]
                    let latitude = location["lat"].doubleValue
                    let longitude = location["lng"].doubleValue
                    self.currentUser.location = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
                    }, failure: { (error) in
                })
                
                addSubview(newLabel)
            
            case 1:
                
                guard textField.text?.characters.count > 0 else {
                    return
                }
                
                newLabel.frame = labelFrame!
                newLabel.font = UIFont (name: "Futura", size: 22)
                currentUser.notificationTimeUTC = textField.text
                currentUser.setNotificationTime = textField.text
                textField.removeFromSuperview()
                newLabel.text = currentUser.setNotificationTime
                addSubview(newLabel)
            
        default:
    
            break
        }
        
        updateUser()
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        textField.text = dateFormatter.stringFromDate(sender.date)

    }
    
    func updateUser(){
        APIHelper.makeJSONRequest(APIHelper.UpdateUser(user: currentUser), success: { (json) in
        }) { (error) in
        }
    }
}

