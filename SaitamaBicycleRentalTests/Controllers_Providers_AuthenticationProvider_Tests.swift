//
//  Controllers_Providers_AuthenticationProvider_Tests.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import XCTest
@testable import SaitamaBicycleRental
class Controllers_Providers_AuthenticationProvider_Tests: XCTestCase {
    let provider = Controllers.Providers.AuthenticationProvider()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_performLogin(){
        provider.performLogin(observer: "", email: "test@test.com", password: "123456")
    }
    
    func test_performRegister(){
        provider.performRegister(observer: "", email: "test@test.com", password: "123456")
    }
}
