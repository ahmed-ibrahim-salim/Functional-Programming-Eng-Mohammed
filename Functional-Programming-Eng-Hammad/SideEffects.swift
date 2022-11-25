//
//  FIrst_video.swift
//  Functional-Programming-Eng-Hammad
//
//  Created by Ahmad medo on 25/11/2022.
//

import Foundation

class SideEffects{
    
    var x,y: Double
    
    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }
    
// (1- explaining side effects
    // 1.1 changing a global variable
    
    func helloWorld(x1: Double, y1: Double){
        x = x1
        y = y1
    }
    
    //1.2 dependant on public variable, the result, it's output is not the same if order of excution changes.
    func getZ(v: Double)-> Double{
        
        var z: Double
        
        if x > 10 {
            z = (x + y) / (2 + v)
        }else{
            z = (x + y) / (2 - v)
        }
        return z
    }
    
    func updateX(v: Double){
        x = y - (2 * v)
    }
    
    func updateY(v: Double){
        y = x - (2 * v)
    }
    
}
