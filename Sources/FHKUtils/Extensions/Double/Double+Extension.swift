//
//  Double+Extension.swift
//  FHKUtils
//
//  Created by Fredy Leon on 17/3/26.
//

import Foundation

public extension Double {
    public func formattedValue(showDecimals: Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        
        if showDecimals {
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
        } else {
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
        }
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
