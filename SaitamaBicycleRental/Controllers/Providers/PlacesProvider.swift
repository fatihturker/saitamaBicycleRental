//
//  PlacesProvider.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Providers{
    class PlacesProvider{
        private var mServiceUrl: String = Models.Constants.PlacesApiUrl + "places"
        init(){}
        init(serviceUrl: String){
            mServiceUrl = serviceUrl
        }
        private var serviceAdapter: Controllers.Adapters.ServiceAdapter = Controllers.Adapters.ServiceAdapter()
        func getPlaces(observer: String){
            serviceAdapter.makeRequestWithToken(observer: observer, serviceUrl: mServiceUrl, with: nil, httpMethod: "GET")
        }
        
        func getPlaces(dao: NSDictionary) throws -> [Models.Renter]{
            if dao["results"] == nil{
                throw Models.ErrorTypes.brokenDirectory
            }
            var places: [Models.Renter] = []
            for result in (dao["results"] as? [NSDictionary])!{
                places.append(Models.Renter(renter: result))
            }
            return places
        }
    }
}
