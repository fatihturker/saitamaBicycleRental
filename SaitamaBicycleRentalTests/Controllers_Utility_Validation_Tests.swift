//
//  vvvv.swift
//  SaitamaBicycleRental
//
//  Created by FATİH TÜRKER on 27/11/2016.
//  Copyright © 2016 Fatih Türker. All rights reserved.
//

import XCTest
@testable import SaitamaBicycleRental
class Controllers_Utility_Validation_Tests: XCTestCase {
    let validationUtil = Controllers.Utility.Validation()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_isValidMail_withEmptyString() {
        let testMail: String = ""
        let res: Bool = validationUtil.isValidEmail(str: testMail)
        XCTAssert(res == false)
    }
    
    func test_isValidMail_withInvalidMailAdress() {
        let testMail: String = "test@test"
        let res: Bool = validationUtil.isValidEmail(str: testMail)
        XCTAssert(res == false)
    }
    
    func test_isValidMail_withValidMailAdress() {
        let testMail: String = "test@test.com"
        let res: Bool = validationUtil.isValidEmail(str: testMail)
        XCTAssert(res == true)
    }
    
    func test_isValidExpiration_withInvalidExpiration(){
        let testExpiration: String = "00dd"
        let res: Bool = validationUtil.isValidExpiration(str: testExpiration)
        XCTAssert(res == false)
    }
    
    func test_isValidExpiration_withInvalidMonth(){
        let testExpiration: String = "13/25"
        let res: Bool = validationUtil.isValidExpiration(str: testExpiration)
        XCTAssert(res == false)
    }
    
    func test_isValidExpiration_withValidExpiration(){
        let testExpiration: String = "11/16"
        let res: Bool = validationUtil.isValidExpiration(str: testExpiration)
        XCTAssert(res == true)
    }
    
}
