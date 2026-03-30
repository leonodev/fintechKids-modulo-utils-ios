//
//  String+Extension.swift
//  FHKUtils
//
//  Created by Fredy Leon on 20/12/25.
//

//import Foundation
//
//public extension String {
//    enum Localization {
//        // This enum is used as a namespace for localization utilities
//    }
//    
//    /// Localizes a string using the current string as the localization key.
//    /// - Parameters:
//    ///   - table: The table to search for the string (defaults to "Localizable").
//    ///   - bundle: The bundle to search for the table (defaults to .main).
//    ///   - comment: A comment for translators (defaults to an empty string).
//    /// - Returns: The localized string.
//    public func localized(
//        table: String = "Localizable",
//        bundle: Bundle = .main,
//        comment: String = ""
//    ) -> String {
//        NSLocalizedString(
//            self,
//            tableName: table,
//            bundle: bundle,
//            value: self,
//            comment: comment
//        )
//    }
//    
//    /// Localizes a string with arguments, using the current string as the localization key.
//    /// - Parameters:
//    ///   - arguments: The values to substitute in the localized string.
//    ///   - table: The table to search for the string (defaults to "Localizable").
//    ///   - bundle: The bundle to search for the table (defaults to .main).
//    ///   - comment: A comment for translators (defaults to an empty string).
//    /// - Returns: The localized string with arguments substituted.
//    public func localized(
//        _ arguments: CVarArg...,
//        table: String = "Localizable",
//        bundle: Bundle = .main,
//        comment: String = ""
//    ) -> String {
//        let format = localized(table: table, bundle: bundle, comment: comment)
//        return String(format: format, arguments: arguments)
//    }
//    
//    func capitalizingFirstLetter() -> String {
//        return prefix(1).uppercased() + dropFirst()
//    }
//
//    public mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
//}

import Foundation

public extension String {
    
    // 1. Helper para obtener el Bundle del idioma actual de la App
    static var currentLanguageBundle: Bundle {
        // Aquí deberías obtener el código del idioma que el usuario eligió (ej: "en", "es", "it")
        // Si no tienes un LanguageManager, puedes usar el primer idioma preferido o "en" por defecto
        let languageCode = UserDefaults.standard.string(forKey: "language_user") ?? "en"
        
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return .main
        }
        return bundle
    }

    // 2. Localización base
    func localized(
        table: String = "Localizable",
        bundle: Bundle = String.currentLanguageBundle, // <-- Cambiado de .main a nuestro dinámico
        comment: String = ""
    ) -> String {
        // Usamos la API de Bundle directamente para evitar comportamientos extraños de la macro NSLocalizedString
        return bundle.localizedString(forKey: self, value: self, table: table)
    }
    
    // 3. Localización con argumentos
    func localized(
        _ arguments: CVarArg...,
        table: String = "Localizable",
        bundle: Bundle = String.currentLanguageBundle, // <-- Consistencia aquí también
        comment: String = ""
    ) -> String {
        let format = localized(table: table, bundle: bundle, comment: comment)
        
        // Es importante pasar el locale para que números y fechas se formateen según el idioma elegido
        return String(format: format, locale: Locale(identifier: bundle.bundleIdentifier ?? "en"), arguments: arguments)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
