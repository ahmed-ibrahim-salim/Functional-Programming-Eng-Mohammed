//
//  SecondVideo.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by Ahmad medo on 25/11/2022.
//

import Foundation

class PureFunctions{
//  (2- Pure Functions: pure from side effects
    // pure functions: does not read or write from outside, simply it takes input and returns output.
    func addOne(num: Int)->Int{
        return num + 1
    }
    
    func square(num: Int)->Int{
        num * num
    }
    func substractTen(num: Int)->Int{
        num - 10
    }
    
}

extension Collection{
    
// (3- Higher order function:
    // implementing higher order function (Map)
    func myMap<T>(_ transform: (Element)->T)-> [T]{
        var outList = [T]()
        
        for item in self{
            outList.append(transform(item))
        }
        
        return outList
    }
    
    // implementing higher order function (Filter)
    func myFilter<T>(_ isIncluded: (Element)->Bool) ->[T]{
        var outList = [T]()
        
        for item in self{
            if isIncluded(item){ outList.append(item as! T) }
        }
        
        return outList
    }
    
}
