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
    
    case GetForecastForCoordinate(coordinate : CLLocationCoordinate2D?)
    case GetLocationFromZipCode(zipCode : String?)
    
    var url : String {
        switch self {
            
        case .GetForecastForCoordinate(let coordinate):
            
            return "\(Constants.forecastRootURL)\(coordinate!.latitude),\(coordinate!.longitude)"

        case .GetLocationFromZipCode(let zipCode):

            return "\(Constants.googleRootURL)\(zipCode!)&key=\(Constants.GoogleAPIKey)"

        }
        
    }
    
}

extension APIHelper {
    var alamofireMethod : Alamofire.Method {
        switch self {
        case .GetForecastForCoordinate:
            return .GET
        case .GetLocationFromZipCode:
            return .GET
        }
    }

    static func makeJSONRequest(endpoint : APIHelper, success:(JSON) -> Void, failure:(NSError) -> Void) {
        Alamofire.request(endpoint.alamofireMethod, endpoint.url).responseJSON { (responseObject) -> Void in
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
