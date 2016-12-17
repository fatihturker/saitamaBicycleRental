//
//  Constants.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Models{
    /** Contains Constant Values */
    class Constants{
        private static var mConfigAdapter: Controllers.Adapters.ConfigAdapter = Controllers.Adapters.ConfigAdapter()
        
        private static var mAuthenticationApiUrl = ""
        /** Returns constant Authentication Api Url by reading from Config.plist */
        static var AuthenticationApiUrl: String{
            get{
                if mAuthenticationApiUrl == ""{
                    mAuthenticationApiUrl = mConfigAdapter.readDataFromConfig(forKey: "Authentication Api Url") as! String? ?? ""
                }
                return mAuthenticationApiUrl
            }
        }
        
        private static var mPlacesApiUrl = ""
        /** Returns constant Places Api Url by reading from Config.plist */
        static var PlacesApiUrl: String{
            get{
                if mPlacesApiUrl == ""{
                    mPlacesApiUrl = mConfigAdapter.readDataFromConfig(forKey: "Places Api Url") as! String? ?? ""
                }
                return mPlacesApiUrl
            }
        }
        
        private static var mRentApiUrl = ""
        /** Returns constant Rent Api Url by reading from Config.plist */
        static var RentApiUrl: String{
            get{
                if mRentApiUrl == ""{
                    mRentApiUrl = mConfigAdapter.readDataFromConfig(forKey: "Rent Api Url") as! String? ?? ""
                }
                return mRentApiUrl
            }
        }

    }
}
