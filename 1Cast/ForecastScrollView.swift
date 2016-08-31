//
//  ForecastScrollView.swift
//  OneCast
//
//  Created by Matt Gioe on 8/23/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import UIKit

class ForecastScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, forecastArray : [Forecast]){
        self.init(frame: frame)
        setupScrollViewWithForecasts(frame, forecastArray: forecastArray)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupScrollViewWithForecasts(frame : CGRect, forecastArray : [Forecast]){
        let scrollViewWidth:CGFloat = frame.width

        for index in (0...remainingHoursInDay()){
            print(index)
            let newWidth = scrollViewWidth * CGFloat(index)
            let screen = ForecastView.init(frame: CGRectMake(newWidth, 0, scrollViewWidth, frame.height), forecast: forecastArray[index])
            addSubview(screen)
        }
        
        contentSize = CGSizeMake(frame.width * CGFloat(remainingHoursInDay()), frame.height)
        pagingEnabled = true
        bounces = false
        
    }
    
    func remainingHoursInDay() -> Int{
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        return 24 - hour
    }

}
