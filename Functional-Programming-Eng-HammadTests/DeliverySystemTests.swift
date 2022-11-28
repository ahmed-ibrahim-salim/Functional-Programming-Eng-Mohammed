//
//  DeliverySystemTests.swift
//  Functional-Programming-Eng-HammadTests
//
//  Created by Ahmad medo on 25/11/2022.
//

import XCTest

@testable import Functional_Programming_Eng_Hammad

final class DeliverySystemTests: XCTestCase {
    
    var order: Order?
    var prodFood: Product?
    var prodRawMaterial: Product?
    
    override func setUpWithError() throws {
        order = Order()
        prodFood =  Product(productIndex: "FOO-001", quantity: 2, unitPrice: 40.0)
        prodRawMaterial =  Product(productIndex: "RAW-001", quantity: 2, unitPrice: 40.0)
                
    }
    
    override func tearDownWithError() throws {
        order = nil
        prodFood = nil
        prodRawMaterial = nil
    }
    
    func test_ProductType_ReturnsCorrectType()throws{
        
        // when
        let prodAsFood = try Product.getProdType(prodFood!)
        let prodAsRaw = try Product.getProdType(prodRawMaterial!)
        
        // then
        XCTAssertEqual(prodAsFood, .food)
        XCTAssertEqual(prodAsRaw, .rawMaterial)
        
    }
    
    func test_ProductType_ThrowsError()throws{
        // given
        
        let prodNotImplemented =  Product(productIndex: "Raaa-001", quantity: 2, unitPrice: 40.0)
        
        // when - then
        XCTAssertThrowsError(try Product.getProdType(prodNotImplemented))
        
    }
    
    func test_Discount()throws{
    // given
        order?.products = [prodRawMaterial!]
    // when
        
        // passing getProductType without excuting it
        let discountAmount = try order!.discount(prodRawMaterial!, order!.getDiscountCalulatorByProductType(product:))
        
        XCTAssertEqual(discountAmount, 16.0)
        
        XCTAssertEqual(Order.totalPriceForOrder(order!), 80)
        
        let totalPriceAfterDiscount = Order.totalPriceForOrder(order!) - discountAmount
        
    // then
        XCTAssertEqual(totalPriceAfterDiscount, 64.0)
        
    }
    func test_Rules_IsQualified_ReturnsCalculatior()throws {
    // given
        order?.products = [prodFood!, prodRawMaterial!]
        
        // defining rule as a condition and calculator
        let isFoodRule = Rule(qualifier: {
            order in
            // defining a condition
            let prodsQualified = try order.products.filter({
                product in
                let prodType = try Product.getProdType(product)
                return prodType == ProductType.food
            })
            return prodsQualified.count > 0
        }, discountCalculator: {
            order in
            let orderDiscountAmount = order.products
                .map({
                    product in
                    return Product.totalPriceForProductWithQuantity(product) / 5
                })
                .reduce(0){
                    item, next in
                    return item + next
                }
            return orderDiscountAmount
        })
        
        let isRawMaterialRule = Rule(qualifier: {
            order in
            // defining a condition
            let prodsQualified = try order.products.filter({
                product in
                let prodType = try Product.getProdType(product)
                return prodType == ProductType.rawMaterial
            })
            return prodsQualified.count > 0
        }, discountCalculator: {
            order in
            let orderDiscountAmount = order.products
                .map({
                    product in
                    // discountForProduct = totalProductPrice/5
                    return Product.totalPriceForProductWithQuantity(product) / 5
                })
                .reduce(0){
                    item, next in
                    return item + next
                }
            return orderDiscountAmount
        })

        // rule calculates discount, then reduce from full-order price
    // when
        let isFoodRuleCalculator = try isFoodRule.isOrderQualified(order!)
        let isRawMaterialRuleCalculator = try isRawMaterialRule.isOrderQualified(order!)
        
        let discountCalculators: [ (Order)->Double ] = [isFoodRuleCalculator, isRawMaterialRuleCalculator]
                
        let orderTotalDiscounts: Double = discountCalculators.map({
            dicountCalc in
            return dicountCalc(order!)
        }).reduce(0){
            item, next in
            return item + next
        }
        
        let orderPriceAfterDiscounts = Order.totalPriceForOrder(order!) - orderTotalDiscounts
    // then
        XCTAssertEqual(orderPriceAfterDiscounts, 96.0)
    }
    
    func test_Rules_NotQualified_ThrowsRuleError()throws {
        // given
        let prodBaverage =  Product(productIndex: "BAV-001", quantity: 2, unitPrice: 40.0)
        
        order?.products = [prodBaverage, prodRawMaterial!]
        
        // defining rule as a condition and calculator
        let rule = Rule(qualifier: {
            order in
            // defining a condition
            let prodsQualified = try order.products.filter({
                product in
                let prodType = try Product.getProdType(product)
                return prodType == ProductType.food
            })
            return prodsQualified.count > 0
//            productIndex == "FOO-001"
        }, discountCalculator: {
            order in
            let orderDiscountAmount = order.products
                .map({
                    product in
                    // discountForProduct = totalProductPrice/5
                    return Product.totalPriceForProductWithQuantity(product) / 5
                })
                .reduce(0){
                    item, next in
                    return item + next
                }
            return orderDiscountAmount
        })
        
        // when - then
        XCTAssertThrowsError(try rule.isOrderQualified(order!))
        
    }
}
