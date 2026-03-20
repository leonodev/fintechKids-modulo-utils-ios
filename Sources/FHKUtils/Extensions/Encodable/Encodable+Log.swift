//
//  Encodable+Log.swift
//  FHKUtils
//
//  Created by Fredy Leon on 20/3/26.
//

import Foundation

public extension Encodable {
    /// possible words that should be obfuscated
    func toSafeLogString(obfuscate: [String] = [
        "password", "pwd", "token", "secret", "key"
    ]) -> String {
        // Try to convert to Data
        guard let data = try? JSONEncoder().encode(self) else {
            return String(describing: self)
        }
        
        // Convert to Dictionary for manipulation
        guard var dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return String(describing: self)
        }
        
        // Find and replace case-sensitive keys
        for key in dictionary.keys {
            if obfuscate.contains(where: { key.lowercased().contains($0) }) {
                dictionary[key] = "********"
            }
        }
        
        // Convert back to a "pretty" printed JSON
        if let safeData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
           let safeString = String(data: safeData, encoding: .utf8) {
            return safeString
        }
        
        return String(describing: self)
    }
}
