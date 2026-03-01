//
//  EmailValidation.swift
//  FHKUtils
//
//  Created by Fredy Leon on 1/3/26.
//

import Foundation

public extension String {
    
    /// Based in teh standard RFC 5322
    var isRegexEmail: Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // standard RFC 5322 limit emails to 254 characters
        guard trimmed.count <= 254 else { return false }
        return trimmed.isRegexEmail
    }
}
