//
//  String+Extension.swift
//  FHKUtils
//
//  Created by Fredy Leon on 20/12/25.
//

import Foundation

public extension String {
    enum Localization {
        // This enum is used as a namespace for localization utilities
    }
    
    /// Localizes a string using the current string as the localization key.
    /// - Parameters:
    ///   - table: The table to search for the string (defaults to "Localizable").
    ///   - bundle: The bundle to search for the table (defaults to .main).
    ///   - comment: A comment for translators (defaults to an empty string).
    /// - Returns: The localized string.
    public func localized(
        table: String = "Localizable",
        bundle: Bundle = .main,
        comment: String = ""
    ) -> String {
        NSLocalizedString(
            self,
            tableName: table,
            bundle: bundle,
            value: self,
            comment: comment
        )
    }
    
    /// Localizes a string with arguments, using the current string as the localization key.
    /// - Parameters:
    ///   - arguments: The values to substitute in the localized string.
    ///   - table: The table to search for the string (defaults to "Localizable").
    ///   - bundle: The bundle to search for the table (defaults to .main).
    ///   - comment: A comment for translators (defaults to an empty string).
    /// - Returns: The localized string with arguments substituted.
    public func localized(
        _ arguments: CVarArg...,
        table: String = "Localizable",
        bundle: Bundle = .main,
        comment: String = ""
    ) -> String {
        let format = localized(table: table, bundle: bundle, comment: comment)
        return String(format: format, arguments: arguments)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


/*
 
 Basic Usage in Main App
 
 Text("welcome_title".localized())
             
             // String with parameters
             Text("items_count".localized(5))
             
             // Custom table (if you have separate string catalogs)
             Text("special_error".localized(table: "Errors"))
 
 let title = "error_title".localized()
         let message = "error_message".localized("Connection failed")
         
         // Use the localized strings
         print("\(title): \(message)")
 
 */
