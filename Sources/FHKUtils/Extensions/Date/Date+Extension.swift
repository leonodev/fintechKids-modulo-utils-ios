//
//  Date+Extension.swift
//  FHKUtils
//
//  Created by Fredy Leon on 12/3/26.
//

import Foundation

public extension Date {
    /// Retorna la fecha en formato UTC para Supabase
    /// Ejemplo: "2026-03-10 16:48:07.310166+00"
    public var toUTC: String {
        let formatter = DateFormatter()
        // Forzamos el locale para evitar conflictos con formatos de 12h/24h del sistema
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // Establecemos la zona horaria a UTC
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        // SSSSSS para microsegundos y '+00' literal al final para cumplir con tu formato
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS'+00'"
        
        return formatter.string(from: self)
    }
}
