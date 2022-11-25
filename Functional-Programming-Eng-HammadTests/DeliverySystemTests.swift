//
//  DeliverySystemTests.swift
//  Functional-Programming-Eng-HammadTests
//
//  Created by Ahmad medo on 25/11/2022.
//

import XCTest

@testable import Functional_Programming_Eng_Hammad

final class DeliverySystemTests: XCTestCase {
    
    override func setUpWithError() throws {  }
    
    override func tearDownWithError() throws { }
    
    func test_ProductType_ReturnsCorrectType()throws{
        // given
        let order = Order()
        
        let prodFood =  Product(productIndex: "FOO-001", quantity: 2, unitPrice: 40.0)
        
        let prodRawMaterial =  Product(productIndex: "RAW-001", quantity: 2, unitPrice: 40.0)
        
        // when
        let prodAsFood = try order.getProductType(prodFood)
        let prodAsRaw = try order.getProductType(prodRawMaterial)
        
        // then
        XCTAssertEqual(prodAsFood.type, .food)
        XCTAssertEqual(prodAsRaw.type, .rawMaterial)
        
    }
    
    func test_ProductType_ThrowsError()throws{
        // given
        let order = Order()
        
        let prodNotImplemented =  Product(productIndex: "Raaa-001", quantity: 2, unitPrice: 40.0)
        
        // when - then
        XCTAssertThrowsError(try order.getProductType(prodNotImplemented))
        
    }
    
    func test_Discount()throws{
        // given
        let order = Order()
        
        let prodRawMaterial =  Product(productIndex: "RAW-001", quantity: 2, unitPrice: 40.0)
        
        // when
        // 2*40 = 80 after discount  2*(40 - (40/5)) = 64
        
        // passing getProductType without excuting it
        let orderAfterDiscount = try order.discount(prodRawMaterial, order.getProductType(_:))
        
        // then
        XCTAssertEqual(orderAfterDiscount, 64.0)
        
    }
    func test_Rules_IsQualified_ReturnsCalculatior()throws {
        // given
        let prodFood =  Product(productIndex: "FOO-001", quantity: 2, unitPrice: 40.0)
        let prodRawMaterial =  Product(productIndex: "RAW-001", quantity: 2, unitPrice: 40.0)
        
        let order = Order()
        order.products = [prodFood, prodRawMaterial]
        
        // defining rule as a condition and calculator
        let rule = Rule(qualifier: {
            order in
            // defining condition
            return order.products[0].productIndex == "FOO-001"
        }, calculator: {
            order in
            // 32 + 32
            let prices = order.products
                .map({$0.unitPrice - ($0.unitPrice / 5)})
                .reduce(0){
                    item, next in
                    return item + next
                }
            return prices
        })
        
    // when
        let calculator = try rule.isQualified(order)
        
        let returnedOrderPrice = calculator(order)
    // then
        XCTAssertEqual(returnedOrderPrice, 64.0)
    }
    
    func test_Rules_NotQualified_ThrowsRuleError()throws {
        // given
        let prodFood =  Product(productIndex: "FOO-001", quantity: 2, unitPrice: 40.0)
        let prodRawMaterial =  Product(productIndex: "RAW-001", quantity: 2, unitPrice: 40.0)
        
        let order = Order()
        order.products = [prodFood, prodRawMaterial]
        
        // defining rule as a condition and calculator
        let rule = Rule(qualifier: {
            order in
            // defining condition
            return order.products[0].productIndex == "None"
        }, calculator: {
            order in
            // 32 + 32
            let prices = order.products
                .map({$0.unitPrice - ($0.unitPrice / 5)})
                .reduce(0){
                    item, next in
                    return item + next
                }
            return prices
        })
        
    // when - then
        XCTAssertThrowsError(try rule.isQualified(order))
        
    }
}
