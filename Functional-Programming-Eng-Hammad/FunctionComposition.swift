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
struct ShippingDate{
    var shippingValue: Double
}

class Example{
    
    func calculateFrieghtCost<T1,T2,T3,T4>(order: T1,_ f1: @escaping (T1)->T2,
                                           _ f2: @escaping (T2)->T3,
                                           _ f3: @escaping (T3)->T4)-> (T1)->T4{
        
        return {_ in f3(f2(f1(order)))}
    }
    
    func calculateShippingDate<T1,T2,T3>(order: T1,
                                         _ f1: @escaping (T1)->T2,
                                         _ f2: @escaping (T2)->T3)->(T1)->T3{
        return {_ in f2(f1(order))}
    }
    
    func adjustCost<T1>(order: T1,
                        _ f1: (T1)->FrieghtCost,
                        _ f2: (T1)->ShippingDate)->Double{
        let frieghtCost = f1(order)
        let shippongDate = f2(order)
        
        // based on the last two calculations
        let cost = 44.0
        
        return cost
    }
    
}

// --------------------
// Strategy design pattern
// 3 protocols for main purposes and each protocol has 3 implementations
protocol CreateInvoice{
    func createInvoice(order: NewOrder)->Invoice
}
protocol CreateShipping{
    func createShipping(invoice: Invoice)->Shipping
}
protocol CalculateFrieghtCost{
    func calculateFrieghtCost(shipping: Shipping)->FrieghtCost
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

// --------------------
// Strategy design pattern
// 3 protocols for main purposes and each protocol has 3 implementations
protocol CheckAvailability{
    func checkAvailability(order: NewOrder)->Availability
}
protocol GetShippingDate{
    func GetShippingDate(availability: Availability)->ShippingDate
}

// -------------------------------------------
struct GetShippingDate1: GetShippingDate{
    func GetShippingDate(availability: Availability) -> ShippingDate {
        return ShippingDate(shippingValue: 12)
    }
    
}
struct GetShippingDate2: GetShippingDate{
    func GetShippingDate(availability: Availability) -> ShippingDate {
        return ShippingDate(shippingValue: 15)
    }
    
}
struct GetShippingDate3: GetShippingDate{
    func GetShippingDate(availability: Availability) -> ShippingDate {
        return ShippingDate(shippingValue: 20)
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


// small example
extension Example{
    
    
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

