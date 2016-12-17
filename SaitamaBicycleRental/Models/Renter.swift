//
//  Renter.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import Foundation
import MapKit

extension Models{
    class Renter{
        var id: String = ""
        var location: CLLocationCoordinate2D! = nil
        var name: String = ""
        
        init(renter: NSDictionary){
            id = (renter["id"] as? String)!
            name = (renter["name"] as? String)!
            let locDict = renter["location"] as? NSDictionary
            let lat = locDict?["lat"] as? CLLocationDegrees
            let lng = locDict?["lng"] as? CLLocationDegrees
            location = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        }
    }
}
