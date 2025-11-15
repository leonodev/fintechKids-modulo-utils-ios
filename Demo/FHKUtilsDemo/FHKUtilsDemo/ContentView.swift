//
//  ContentView.swift
//  FHKUtilsDemo
//
//  Created by Fredy Leon on 13/11/25.
//

import SwiftUI
import FHKUtils

@MainActor
struct ContentView: View {
    @State private var logMessages: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "hammer.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.blue)
                
                Text("FHKUtils Showcase")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Swift 6 + iOS 18")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(4)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(4)
                
                // Botones de prueba
                Button("Probar request / reponse") {
                    Logger.request("GET /api/users")
                    Logger.response("{ Ok }")
                }
                .capsuleButton(background: .blue)
                
                Button("Simular Success") {
                    Logger.info("Conexión Success")
                }
                .capsuleButton(background: .green)
                
                Button("Simular Error") {
                    Logger.error("Error de conexión")
                }
                .capsuleButton(background: .red)
                
                Button("Simular Warning") {
                    Logger.warning("Warning conexión")
                }
                .capsuleButton(background: .orange)
                
                Button("Simular Debug") {
                    Logger.debug("Debug conexión")
                }
                .capsuleButton(background: .indigo)
                
                // Mostrar logs
                if !logMessages.isEmpty {
                    Text("Revisa la consola de Xcode para ver los logs")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .navigationTitle("FHKUtils Swift 6")
        }
    }
    
    private func addLogMessage(_ message: String) {
        logMessages.append(message)
    }
}

struct CapsuleButtonStyle: ViewModifier {
    var background: Color
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
            .frame(width: 300, height: 50)
            .background(background)
            .foregroundColor(.white)
            .cornerRadius(50)
    }
}

extension View {
    func capsuleButton(background: Color) -> some View {
        self.modifier(CapsuleButtonStyle(background: background))
    }
}

#Preview {
    ContentView()
}

