//
//  RentBicycleUtility.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Utility{
    class RentBicycleUtility{
        private var mServiceUrl: String = Models.Constants.RentApiUrl + "rent"
        init(){}
        init(serviceUrl: String){
            mServiceUrl = serviceUrl
        }
        private var serviceAdapter: Controllers.Adapters.ServiceAdapter = Controllers.Adapters.ServiceAdapter()
        func rent(observer: String, cardNumber: String, name: String, expiration: String, code: String){
            let postJson = ["number": cardNumber, "name": name, "expiration": expiration, "code": code]
            let postData = try? JSONSerialization.data(withJSONObject: postJson, options: .prettyPrinted)
            serviceAdapter.makeRequestWithToken(observer: observer, serviceUrl: mServiceUrl, with: postData, httpMethod: "POST")
        }
    }
}
