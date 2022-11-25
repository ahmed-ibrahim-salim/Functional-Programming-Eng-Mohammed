//
//  SecondVideoTests.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by Ahmad medo on 25/11/2022.
//

import XCTest

@testable import Functional_Programming_Eng_Hammad

final class PureFunctionsTests: XCTestCase {
    
    override func setUpWithError() throws {}
    
    override func tearDownWithError() throws {}
    
    
    func test_(){
        let sut = PureFunctions()
        
        let nums =  [3,4,5,8,10]
        let items = nums.myMap(sut.addOne(num:))
            .myMap(sut.square(num:))
            .myFilter({ $0 < 70})
        // sort and get first 2
            .sorted()[0..<2]
            .myMap(sut.substractTen(num:))
            
//
        XCTAssertEqual(items, [6,15])
    }

    
}
