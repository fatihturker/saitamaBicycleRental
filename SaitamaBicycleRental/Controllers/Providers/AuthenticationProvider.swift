//
//  AuthenticationProvider.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Providers{
    /** Provider for authentication methods */
    class AuthenticationProvider{
        private var mServiceUrl: String = Models.Constants.AuthenticationApiUrl
        init(){}
        init(serviceUrl: String){
            mServiceUrl = serviceUrl
        }
        private var serviceAdapter: Controllers.Adapters.ServiceAdapter = Controllers.Adapters.ServiceAdapter()
        
        /** Performs login via service with username and password notifying the posted observer on response */
        func performLogin(observer: String, email: String, password: String){
            self.performAuthentication(observer: observer, email: email, password: password, forService: "auth")
        }
        
        /** Performs register via service with username and password notifying the posted observer on response */
        func performRegister(observer: String, email: String, password: String){
            self.performAuthentication(observer: observer, email: email, password: password, forService: "register")
        }
        
        /** Template method for authentication operations */
        private func performAuthentication(observer: String, email: String, password: String, forService: String){
            let postJson = ["email": email, "password": password]
            let postData = try? JSONSerialization.data(withJSONObject: postJson, options: .prettyPrinted)
            serviceAdapter.makePostRequest(observer: observer, serviceUrl: mServiceUrl + forService, with: postData!)
        }
    }
}
