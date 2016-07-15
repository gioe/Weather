//
//  MainViewController.swift
//  1Cast
//
//  Created by Matt Gioe on 7/15/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var currentUser = User()

    @IBOutlet weak var weatherImage: SKYIconView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        weatherImage.hidden = true;
        APIHelper.makeJSONRequest(APIHelper.GetForecastForCoordinate(coordinate: currentUser.location!), success: { (json) in
            let currentSummary = json["hourly"]["summary"].stringValue
            if currentSummary.containsString("cloud"){
                self.weatherImage.setType = Skycons.PartlyCloudyDay
                self.weatherImage.play()
                self.weatherImage.hidden = false
            }
            
            let currentTemperature = json["hourly"]["data"][0]["apparentTemperature"].doubleValue
            self.tempLabel.text = "\(String(Int(currentTemperature)))℉"
            
        }) { (error) in
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
