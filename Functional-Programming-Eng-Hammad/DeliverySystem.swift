//
//  DeliverySystem.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by Ahmad medo on 25/11/2022.
//

import Foundation

class Rule{
    
    var qualifier: (Order)->Bool
    var calculator: (Order)->Double
    
    init(qualifier: @escaping (Order) -> Bool, calculator: @escaping (Order) -> Double) {
        self.qualifier = qualifier
        self.calculator = calculator
    }
    
    func isQualified(_ order: Order) throws -> (Order)->Double{
        if qualifier(order){
            return calculator
        }else{
            throw RuleError.ruleNotSatisfied
        }
    }
}

enum RuleError: Error{
    case ruleNotSatisfied
}

class Order{
    var products = [Product]()
    
    let foodDiscount: (Product)->Double = {
        product in
        let unitPrice =  product.unitPrice - (product.unitPrice / 2)
        
        return unitPrice * Double(product.quantity)
    }
    let baverageDiscount: (Product)->Double = {
        product in
        let unitPrice =  product.unitPrice - (product.unitPrice / 3)
        
        return unitPrice * Double(product.quantity)
    }
    let rawMaterialDiscount: (Product)->Double = {
        product in
        let unitPrice =  product.unitPrice - (product.unitPrice / 5)
        
        return unitPrice * Double(product.quantity)
    }
    
    func chooseDiscountCalculator(_ prodType: ProductType)->(Product)->Double{
        switch prodType{
        case .food:
            return foodDiscount
        case .baverage:
            return baverageDiscount
        case .rawMaterial:
            return rawMaterialDiscount
        }
    }
    
    func getProductType(_ product: Product)throws -> (type: ProductType, discountClo: (Product)->Double) {
        
        let productIndexCharacters = product.productIndex.myMap({$0})[0..<3]
        let productIndexAsString = String(Array(productIndexCharacters))
        guard let prodType = ProductType(rawValue: productIndexAsString) else{
            throw ProductTypeError.productTypeError
        }
        
        // choosing calulation closure
        let orderDiscountCalculator = chooseDiscountCalculator(prodType)
        
        // returning product type to test this function
        return (prodType, orderDiscountCalculator)
    }
    
    func discount(_ product: Product, _ getProductType: (Product)throws ->(ProductType, (Product)->Double)) throws ->Double{
        let (_, orderDiscountCalculator) = try getProductType(product)
        return orderDiscountCalculator(product)
    }
}

class Product{
    var productIndex: String
    var quantity: Int
    var unitPrice: Double
    
    init(productIndex: String, quantity: Int, unitPrice: Double) {
        self.productIndex = productIndex
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
}

// FOO-001, BAV-001, RAW-001

enum ProductType: String{
    case food = "FOO"
    case baverage = "BAV"
    case rawMaterial = "RAW"
}

enum ProductTypeError: Error{
    case productTypeError
}
