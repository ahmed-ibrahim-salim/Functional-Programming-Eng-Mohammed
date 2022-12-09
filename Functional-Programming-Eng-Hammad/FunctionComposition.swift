//
//  FunctionComposition.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by magdy khalifa on 28/11/2022.
//

import Foundation

struct NewOrder{}

struct Invoice{}
struct Shipping{}

struct FrieghtCost{
    var value: Double
}

struct Availability{}
struct ShippingDate{}


class Example{
    
    
    func calculateFrieghtCost<T1,T2,T3,T4>(order: T1,_ f1: @escaping (T1)->T2,
                                           _ f2: @escaping (T2)->T3,
                                           _ f3: @escaping (T3)->T4)-> (T1)->T4{
        
        return {_ in f3(f2(f1(order)))}
    }
    
    func compose<T1,T2,T3,T4>(_ f1: @escaping (T1)->T2,
                              _ f2: @escaping (T2)->T3,
                              _ f3: @escaping (T3)->T4)-> (T1)->T4{
        
        // function definition
        return { num in f3(f2(f1(num))) }
    }
    func addOne(num: Double)->Double{num + 1}
    
    func square(num: Double)->Double{num * num}
    
    func subtractTen(num: Double)->Double{num - 10}
}

// --------------------
// Strategy design pattern
// 5 protocols for main purposes and each protocol has 3 implementations
protocol CreateInvoice{
    func createInvoice(order: NewOrder)->Invoice
}
protocol CreateShipping{
    func createShipping(invoice: Invoice)->Shipping
}
protocol CalculateFrieghtCost{
    func calculateFrieghtCost(shipping: Shipping)->FrieghtCost
}
protocol CheckAvailability{
    func checkAvailability(order: NewOrder)->Availability
}
protocol GetShippingDate{
    func GetShippingDate(availability: Availability)->ShippingDate
}

// different implementations


// ---------------------------------------
struct CalculateFrieghtCost1: CalculateFrieghtCost{
    func calculateFrieghtCost(shipping: Shipping) -> FrieghtCost {
        return FrieghtCost(value: 20)
    }
}
struct CalculateFrieghtCost2: CalculateFrieghtCost{
    func calculateFrieghtCost(shipping: Shipping) -> FrieghtCost {
        return FrieghtCost(value: 40)
    }
}
struct CalculateFrieghtCost3: CalculateFrieghtCost{
    func calculateFrieghtCost(shipping: Shipping) -> FrieghtCost {
        return FrieghtCost(value: 60)
    }
}
// ----------------------------------
struct CreateShipping1: CreateShipping{
    func createShipping(invoice: Invoice) -> Shipping {
        return Shipping()
    }
}
struct CreateShipping2: CreateShipping{
    func createShipping(invoice: Invoice) -> Shipping {
        return Shipping()
    }
}
struct CreateShipping3: CreateShipping{
    func createShipping(invoice: Invoice) -> Shipping {
        return Shipping()
    }
}
// ----------------------------------------
struct CreateInvoice1: CreateInvoice{
    func createInvoice(order: NewOrder) -> Invoice {
        return Invoice()
    }
}
struct CreateInvoice2: CreateInvoice{
    func createInvoice(order: NewOrder) -> Invoice {
        return Invoice()
    }
}
struct CreateInvoice3: CreateInvoice{
    func createInvoice(order: NewOrder) -> Invoice {
        return Invoice()
    }
}
// -------------------------------------------

struct GetShippingDate1: GetShippingDate{
    func GetShippingDate(availability: Availability) -> ShippingDate {
        return ShippingDate()
    }
    
}
struct GetShippingDate2: GetShippingDate{
    func GetShippingDate(availability: Availability) -> ShippingDate {
        return ShippingDate()
    }
    
}
struct GetShippingDate3: GetShippingDate{
    func GetShippingDate(availability: Availability) -> ShippingDate {
        return ShippingDate()
    }
    
}
// ------------------------------------
struct CheckAvailability1: CheckAvailability{
    func checkAvailability(order: NewOrder) -> Availability {
        return Availability()
    }
}
struct CheckAvailability2: CheckAvailability{
    func checkAvailability(order: NewOrder) -> Availability {
        return Availability()
    }
}

struct CheckAvailability3: CheckAvailability{
    func checkAvailability(order: NewOrder) -> Availability {
        return Availability()
    }
}
