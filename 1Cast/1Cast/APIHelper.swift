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
    case UpdateUser(user : User)
    
    var url : String {
        switch self {
            
        case .GetForecastForCoordinate(let coordinate):
            
            return "\(Constants.forecastRootURL)\(coordinate!.latitude),\(coordinate!.longitude)"

        case .GetLocationFromZipCode(let zipCode):

            return "\(Constants.googleRootURL)\(zipCode!)&key=\(Constants.GoogleAPIKey)"
        
        case .UpdateUser( _):
            
            return "http://localhost:8000/api/user/?format=json"
        }
    }
    
    var params : [String : AnyObject]? {
        switch self {
        case .GetLocationFromZipCode( _):
            return nil
        case .GetForecastForCoordinate( _):
           return nil
        case .UpdateUser(let user):
            return ["device_token": user.deviceToken ?? "", "zip_code": user.zipCode ?? "", "notification_time" : user.notificationTime ?? "", "location_latitude" : String(user.location!.latitude) ?? "", "location_longitude" : String(user.location!.longitude) ?? ""]
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
        case .UpdateUser:
            return .POST
        }
        
    }

    static func makeJSONRequest(endpoint : APIHelper, success:(JSON) -> Void, failure:(NSError) -> Void) {
        if endpoint.alamofireMethod == .GET {
            Alamofire.request(endpoint.alamofireMethod, endpoint.url).responseJSON { (responseObject) -> Void in
                if responseObject.result.isSuccess {
                    
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                if responseObject.result.isFailure {
                    let error : NSError = responseObject.result.error!
                    print(endpoint.url)
                    print(error)
                    failure(error)
                }
            }
        } else {
            Alamofire.request(endpoint.alamofireMethod, endpoint.url, parameters: endpoint.params, encoding: .JSON, headers: ["Content-type": "application/json"]).responseString { (responseObject) -> Void in
                if responseObject.result.isSuccess {
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                if responseObject.result.isFailure {
                    let error : NSError = responseObject.result.error!
                    print(endpoint.url)
                    print(error)
                    failure(error)
                }
            }
        }
    }
}
