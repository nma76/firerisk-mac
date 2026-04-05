//
//  ContentView.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-03.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @StateObject private var location = LocationManager()
    
    @State private var riskForecast: Forecast?
    @State private var fireBan: FireProhibition?
    @State private var loading = false
    @State private var error: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let city = location.city {
                Text("Visar brandrisk för: \(city)").font(.headline)
            } else {
                Text("Hämtar position...").font(.headline)
            }
            
            /*
            if let lat = location.latitude, let lon = location.longitude {
                Text("Lat: \(lat), Lon: \(lon)").font(.headline).foregroundStyle(.secondary)
            }
            */
            
            if let risk = riskForecast {
                Divider()
                
                Text("Brandrisknivå: \(risk.riskIndex)").font(.headline)
                Text(risk.riskMessage ?? "").font(.subheadline).fixedSize(horizontal: false, vertical: true)
            }
            
            if let ban = fireBan {
                Divider()
                
                Text(ban.status ?? "").font(.headline)
                Text(ban.statusMessage ?? "").font(.subheadline).fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(width: 260, height: 260)
        .task(id: location.longitude)
        {
            await loadRisk()
        }
        .task {
            for await _ in Timer.publish(every: 300, on: .main, in: .common).autoconnect().values {
                await loadRisk()
            }
        }

    }
    
    func loadRisk() async {
        print("loadRisk triggered!")
        guard let lat = location.latitude,
              let lon = location.longitude else { return }
           
        loading = true
        error = nil
        
        do {
            let service = FireRiskService()
            riskForecast = try await service.getRisk(lat: lat, lon: lon)
            fireBan = try await service.getFireBan(lat: lat, lon: lon)
        } catch {
            self.error = "Kunde inte hämta data"
        }
        
        loading = false
    }
}

#Preview {
    ContentView()
}
