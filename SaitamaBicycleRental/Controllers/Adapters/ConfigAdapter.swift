//
//  ConfigAdapter.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 26/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Adapters{
    /** Adapter for configuration files */
    class ConfigAdapter{
        /** Returns data from config with specified key */
        func readDataFromConfig(forKey: String) -> Any!{
            var data: Any!
            var myDict: NSDictionary?
            if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: path)
            }
            
            if let dict = myDict {
                data = dict.value(forKey: forKey)
            }
            return data
        }
    }
}
