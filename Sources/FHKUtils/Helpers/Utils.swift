//
//  Utils.swift
//  FHKUtils
//
//  Created by Fredy Leon on 21/4/26.
//

public struct Utils {
    
    public static var numberBarCode: String {
        let min: Int64 = 10_000_000_000_000
        let max: Int64 = 99_999_999_999_999
        
        let randomNumber = Int64.random(in: min...max)
        return "\(randomNumber)"
    }
}
