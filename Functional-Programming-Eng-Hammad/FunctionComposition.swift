//
//  FunctionComposition.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by magdy khalifa on 28/11/2022.
//

import Foundation

class Example{
    
    
    func addOne(num: Double)->Double{
        num + 1
    }
    
    func square(num: Double)->Double{
        num * num
    }
    
    func subtractTen(num: Double)->Double{
        num - 10
    }
    
    func compose<T1,T2,T3,T4>(_ f1: @escaping (T1)->T2,
                              _ f2: @escaping (T2)->T3,
                              _ f3: @escaping (T3)->T4)-> (T1)->T4{
        
        // function definition
        return { num in f3(f2(f1(num))) }
    }
}
