//
//  FunctionCompositionTests.swift
//  Functional-Programming-Eng-HammadTests
//
//  Created by magdy khalifa on 28/11/2022.
//

import XCTest

@testable import Functional_Programming_Eng_Hammad

final class FunctionCompositionTests: XCTestCase {

    var example: Example?
    
    override func setUpWithError() throws {
        example = Example()
    }

    override func tearDownWithError() throws {
        example = nil
    }
    
    func test_Compose_ADD_Subtract_Square(){
        
        let arrayOfNum: [Double] = [4.0, 5.0, 10.0, 12.0]
        
        let addOneSquareSubtractTen = example!.compose(example!.addOne,
                                                       example!.square,
                                                       example!.subtractTen)
                
        let numsAfter = arrayOfNum.map({
            addOneSquareSubtractTen($0)
            
        })
        
        XCTAssertEqual([15.0, 26.0, 111.0, 159.0], numsAfter)
    }
}
