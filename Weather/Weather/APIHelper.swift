//
//  APIHelper.swift
//  Weather
//
//  Created by Matt Gioe on 7/13/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

//
//  APIService.swift
//  Genome
//
//  Created by Matt Gioe on 7/2/16.
//  Copyright © 2016 Matt Gioe. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

enum APIHelper {
    
    /// Returns a list of nearby Place objects
    case GetForecastForCoordinate(coordinate : CLLocationCoordinate2D)
    
    var url : String {
        switch self {
            
        case .GetForecastForCoordinate(let coordinate):
            
            return "\(Constants.forecastRootURL)\(coordinate.latitude),\(coordinate.longitude)"
            
        }
    }
    
}

extension APIHelper {
    var alamofireMethod : Alamofire.Method {
        switch self {
        case .GetForecastForCoordinate:
            return .GET
        }
    }
    
    static func makeJSONRequest(endpoint : APIHelper, success:(JSON) -> Void, failure:(NSError) -> Void) {
        Alamofire.request(endpoint.alamofireMethod, endpoint.url).responseJSON { (responseObject) -> Void in
            
            print(responseObject) //it will print the response success/failure anything
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : NSError = responseObject.result.error!
                failure(error)
            }
        }
    }
}
