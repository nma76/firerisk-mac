//
//  ContentView.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-03.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    @ObservedObject var model: FireRiskViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let city = model.city {
                Text("Visar brandrisk för: \(city)").font(.headline)
            } else {
                Text("Hämtar position...").font(.headline)
            }
            
            /*
            if let lat = location.latitude, let lon = location.longitude {
                Text("Lat: \(lat), Lon: \(lon)").font(.headline).foregroundStyle(.secondary)
            }
            */
            
            if let risk = model.riskForecast {
                Divider()
                
                Text("Brandrisknivå: \(risk.riskIndex)").font(.headline)
                Text(risk.riskMessage ?? "").font(.subheadline).fixedSize(horizontal: false, vertical: true)
            }
            
            if let ban = model.fireBan {
                Divider()
                
                Text(ban.status ?? "").font(.headline)
                Text(ban.statusMessage ?? "").font(.subheadline).fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .frame(width: 260, height: 350)
    }
}

#Preview {
    ContentView(model: FireRiskViewModel())
}
