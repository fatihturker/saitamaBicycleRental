//
//  Controllers_Providers_PlacesProvider_Tests.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import XCTest
@testable import SaitamaBicycleRental
class Controllers_Providers_PlacesProvider_Tests: XCTestCase {
    let provider = Controllers.Providers.PlacesProvider()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getPlaces_withObserver(){
        let observer: String = "observer"
        provider.getPlaces(observer: observer)
    }
    
    func test_getPlaces_withInvalidDao(){
        let dao: NSDictionary = ["test": ""]
        XCTAssertThrowsError(try provider.getPlaces(dao: dao)) { (error) -> Void in
            XCTAssertEqual(error as? Models.ErrorTypes, Models.ErrorTypes.brokenDirectory)
        }
    }
}
