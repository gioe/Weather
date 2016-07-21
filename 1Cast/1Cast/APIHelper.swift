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
    case CreateUser(user : User)
    case UpdateUser(user : User)
    
    var url : String {
        switch self {
            case .GetForecastForCoordinate(let coordinate):
            
                return "\(Constants.forecastRootURL)\(coordinate!.latitude),\(coordinate!.longitude)"
            
            case .GetLocationFromZipCode(let zipCode):
            
                return "\(Constants.googleRootURL)\(zipCode!)&key=\(Constants.GoogleAPIKey)"
            
            case .CreateUser( _):
            
                return "http://localhost:8000/api/v1/token/?format=json"
            
            case .UpdateUser(let user):
                
                return "http://localhost:8000/api/v1/token/\(user.userID!)/?format=json"
            
        }
    }
    
    
    
    var params : [String : AnyObject]? {
        switch self {
        case .GetLocationFromZipCode( _):
            return nil
        case .GetForecastForCoordinate( _):
            return nil
        case .CreateUser(let user):
            return ["device_token": user.deviceToken ?? "7db854c3e0878c4f00dfaba434277638f36b8b7590fe012af2da439e7d767385", "zip_code": user.zipCode ?? "", "notification_time" : user.notificationTime ?? "", "time_zone" : user.timeZone ?? "", "location_latitude" : String(user.location!.latitude) ?? "", "location_longitude" : String(user.location!.longitude) ?? ""]
            
        case .UpdateUser(let user):
            return ["device_token": user.deviceToken ?? "7db854c3e0878c4f00dfaba434277638f36b8b7590fe012af2da439e7d767385", "zip_code": user.zipCode ?? "", "notification_time" : user.notificationTime ?? "", "time_zone" : user.timeZone ?? "", "location_latitude" : String(user.location!.latitude) ?? "", "location_longitude" : String(user.location!.longitude) ?? ""]
        
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
        case .CreateUser:
            return .POST
        case .UpdateUser:
            return .PUT
        }
    }
    
    static func makeJSONRequest(endpoint : APIHelper, success:(JSON) -> Void, failure:(NSError) -> Void) {
        switch endpoint.alamofireMethod {
        case .GET:
            
            Alamofire.request(endpoint.alamofireMethod, endpoint.url, parameters: endpoint.params, encoding: .JSON, headers: ["Content-type": "application/json"]).responseJSON { (responseObject) -> Void in
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
            
        case .PUT, .POST:
            
            Alamofire.request(endpoint.alamofireMethod, endpoint.url, parameters: endpoint.params, encoding: .JSON, headers: ["Content-type": "application/json"]).responseJSON { (responseObject) -> Void in
                if responseObject.result.isSuccess {
                    let resJson = JSON(responseObject.result.value!)
                    print(resJson)
                    success(resJson)
                }
                if responseObject.result.isFailure {
                    let error : NSError = responseObject.result.error!
                    print(endpoint.url)
                    print(error)
                    failure(error)
                }
            }
            
        default:
            break
        }
        
    }

}