//
//  Controllers_Providers_TokenProvider_Tests.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import XCTest
@testable import SaitamaBicycleRental
class Controllers_Providers_TokenProvider_Tests: XCTestCase {
    
    let provider = Controllers.Providers.TokenProvider()
    override func setUp() {
        super.setUp()
        provider.setToken(token: "aa")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_getToken_withValidAssertion(){
        XCTAssert("aa" == provider.getToken())
    }
    
    func test_getToken_withInvalidAssertion(){
        XCTAssert("vv" != provider.getToken())
    }
    
    func test_setToken(){
        provider.setToken(token: "gg")
        XCTAssert("gg" == provider.getToken())
    }
    
    func test_clearToken(){
        provider.clearToken()
        XCTAssert("" == provider.getToken())
    }
    
}
