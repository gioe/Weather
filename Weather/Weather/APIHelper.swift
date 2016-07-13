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

enum GNMAPIService {
    
    /// Returns a list of nearby Place objects
    case GetNearbyPlaces(nextPage : String?, place : GMSPlace)
    
    
    var url : String {
        switch self {
            
        case .GetNearbyPlaces(let nextPageString, let place):
            if let nextPageString = nextPageString{
                return "\(GNMConstants.googleRootUrl)nearbysearch/json?location=\(place.coordinate.latitude),\(place.coordinate.longitude)&radius=100&key=\(GNMConstants.GoogleAPIKey)&pagetoken=\(nextPageString)"
            }
            
            return "\(GNMConstants.googleRootUrl)nearbysearch/json?location=\(place.coordinate.latitude),\(place.coordinate.longitude)&radius=100&key=\(GNMConstants.GoogleAPIKey)"
            
        }
    }
    
}

extension GNMAPIService {
    var alamofireMethod : Alamofire.Method {
        switch self {
        case .GetNearbyPlaces:
            return .GET
        }
    }
    
    static func makeJSONRequest(endpoint : GNMAPIService, success:(JSON) -> Void, failure:(NSError) -> Void) {
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
