//
//  SettingSubView.swift
//  OneCast
//
//  Created by Matt Gioe on 7/15/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SettingSubView: UIView {
  
    var view: UIView!
    let defaults = NSUserDefaults.standardUserDefaults()
    var textField : UITextField!
    var settingValueLabel: UILabel!
   
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
            button.setTitle("Change", forState: UIControlState.Normal)
            switch button.tag {
                case 0:
                    textField.removeFromSuperview()
                    self.addSubview(settingValueLabel)
                    settingValueLabel.text = defaults.stringForKey(Constants.ZipCodeKeyForDefaults)
                case 1:
                    textField.removeFromSuperview()
                    self.addSubview(settingValueLabel)
                    settingValueLabel.text = defaults.stringForKey(Constants.NotificationTimeKeyForDefaults)
                default:
                    break
            }
        default:
            button.setTitle("Done", forState: UIControlState.Normal)
            switch button.tag {
                case 0:
                    textField.frame = settingValueLabel.frame
                    textField.backgroundColor = UIColor.whiteColor()
                    textField.borderStyle = UITextBorderStyle.RoundedRect
                    settingValueLabel.removeFromSuperview()
                    self.addSubview(textField)
                case 1:
                    textField.frame = settingValueLabel.frame
                    textField.backgroundColor = UIColor.whiteColor()
                    textField.borderStyle = UITextBorderStyle.RoundedRect
                    settingValueLabel.removeFromSuperview()
                    self.addSubview(textField)
            default:
                    break
            }
        }
    }
}

