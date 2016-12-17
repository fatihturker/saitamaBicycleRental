//
//  Controllers_Adapters_ServiceAdapter_Tests.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import XCTest
@testable import SaitamaBicycleRental
class Controllers_Adapters_ServiceAdapter_Tests: XCTestCase {
    
    let adapter = Controllers.Adapters.ServiceAdapter()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_makePostRequest(){
        adapter.makePostRequest(observer: "test", serviceUrl: "test", with: Data())
    }
    
    func test_makeRequestWithToken(){
        adapter.makeRequestWithToken(observer: "test", serviceUrl: "test", with: nil, httpMethod: "GET")
    }
    
}
