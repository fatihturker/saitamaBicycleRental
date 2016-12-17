//
//  Controllers_Utility_RentBicycleUtility_Tests.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import XCTest
@testable import SaitamaBicycleRental
class Controllers_Utility_RentBicycleUtility_Tests: XCTestCase {
    let provider = Controllers.Utility.RentBicycleUtility()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_rent(){
        provider.rent(observer: "test", cardNumber: "12312312312312", name: "Fatih Türker", expiration: "08/18", code: "123")
    }
    
}
