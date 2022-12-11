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
    
    func test_calculateFrieghtCost(){
        let order = NewOrder()
        let invoice = CreateInvoice1()
        let shipping = CreateShipping1()
        let frieghtCostCalculator = CalculateFrieghtCost1()
        
        guard let frieghtCostCalculatorFunc = example?.calculateFrieghtCost(
            order: order,
            invoice.createInvoice(order:),
            shipping.createShipping(invoice:),
            frieghtCostCalculator.calculateFrieghtCost(shipping:)) else{
            XCTFail()
            return
        }
        
        let frieghtCostValue = frieghtCostCalculatorFunc(order)
        
        XCTAssertEqual(frieghtCostValue.value, 20.0)
    }
    
    func test_calculateShippingDate(){
        let order = NewOrder()
        let availability = CheckAvailability1()
        let shippingDate = GetShippingDate1()
        
        guard let calculateShippingDateFunc = example?.calculateShippingDate(
            order: order,
            availability.checkAvailability(order:),
            shippingDate.GetShippingDate(availability:)) else{
            XCTFail()
            return
        }
        
        let shippingDateValue = calculateShippingDateFunc(order)
        
        XCTAssertEqual(shippingDateValue.shippingValue, 12)
    }
    
    func test_AdjustCost(){
        let order = NewOrder()
        //
        let invoice = CreateInvoice1()
        let shipping = CreateShipping1()
        let frieghtCostCalculator = CalculateFrieghtCost1()
        //
        let availability = CheckAvailability1()
        let shippingDate = GetShippingDate1()
        
        //
        guard let frieghtCostCalculatorFunc = example?.calculateFrieghtCost(
            order: order,
            invoice.createInvoice(order:),
            shipping.createShipping(invoice:),
            frieghtCostCalculator.calculateFrieghtCost(shipping:)) else{
            XCTFail()
            return
        }
        //
        guard let calculateShippingDateFunc = example?.calculateShippingDate(
            order: order,
            availability.checkAvailability(order:),
            shippingDate.GetShippingDate(availability:)) else{
            XCTFail()
            return
        }
        
        let adjustedCost = example?.adjustCost(order: order,
                                               frieghtCostCalculatorFunc,
                                               calculateShippingDateFunc)
        
        XCTAssertEqual(adjustedCost, 44.0)
    }
    
}
