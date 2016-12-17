//
//  TokenProvider.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Providers{
    /** Provider for token including getter and setter operations */
    class TokenProvider{
        var defaults = UserDefaults.standard
        let authTokenKey: String = "AuthToken"
        
        /** Returns authentication token */
        func getToken() -> String{
            return defaults.object(forKey: authTokenKey) as? String ?? ""
        }
        
        /** Sets authentication token */
        func setToken(token: String){
            defaults.set(token, forKey: authTokenKey)
        }
        
        /** Clears authentication token */
        func clearToken(){
            defaults.removeObject(forKey: authTokenKey)
            defaults.synchronize()
        }
    }
}
