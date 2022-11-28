//
//  DeliverySystem.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by Ahmad medo on 25/11/2022.
//

import Foundation

class Rule{
    
    var qualifier: (Order) throws ->Bool
    var discountCalculator: (Order)->Double
    
    init(qualifier: @escaping (Order) throws -> Bool,
         discountCalculator: @escaping (Order) -> Double) {
        self.qualifier = qualifier
        self.discountCalculator = discountCalculator
    }
    
    func isOrderQualified(_ order: Order) throws -> (Order)->Double{
        if try qualifier(order){
            return discountCalculator
        }else{
            throw RuleError.ruleNotSatisfied
        }
    }
}

enum RuleError: Error{
    case ruleNotSatisfied
}

// container of products
class Order{
    var products = [Product]()
    
    static func totalPriceForOrder(_ order: Order)->Double{
        let pricesForEachProduct = order.products.map({
            // for each product with quantity
            Product.totalPriceForProductWithQuantity($0)
        })
        let totalOrderPrice =  pricesForEachProduct.reduce(0){
            item, next in
            return item + next
        }
        return totalOrderPrice
    }
        
    // discount based on product type
    let foodDiscount: (Product)->Double = {
        product in
        Product.totalPriceForProductWithQuantity(product) / 2
    }
    let baverageDiscount: (Product)->Double = {
        product in
        Product.totalPriceForProductWithQuantity(product) / 3

    }
    let rawMaterialDiscount: (Product)->Double = {
        product in
        Product.totalPriceForProductWithQuantity(product) / 5

    }
    
}
extension Order{
    
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
    
    func getDiscountCalulatorByProductType(product: Product) throws -> (type: ProductType,
                                                                          discountClo: (Product)->Double) {
        let prodType = try Product.getProdType(product)
        
        // choosing calculation closure
        let orderDiscountCalculator = chooseDiscountCalculator(prodType)
        
        // returning product type to test this function
        return (prodType, orderDiscountCalculator)
    }
    
    func discount(_ product: Product,
                  _ getProductType: (Product)throws ->(ProductType, (Product)->Double)) throws ->Double{
        
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
    
    
    static func getProdType(_ product: Product)throws -> ProductType{
        
        let productIndexCharacters = product.productIndex.myMap({$0})[0..<3]
        let productIndexAsString = String(Array(productIndexCharacters))
        guard let prodType = ProductType(rawValue: productIndexAsString) else{
            throw ProductTypeError.productTypeError
        }
        return prodType
    }
    
    static func totalPriceForProductWithQuantity(_ product: Product)->Double{
        return product.unitPrice * Double(product.quantity)
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
