//
//  Common.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
extension Controllers.Utility{
    class Validation{
        func isValidEmail(str:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: str)
        }
        
        func isValidExpiration(str:String) -> Bool {
            let expirationRegex = "(0?[1-9]|1[012])/[0-9]{2}"
            
            let expirationTest = NSPredicate(format:"SELF MATCHES %@", expirationRegex)
            return expirationTest.evaluate(with: str)
        }
    }
}
