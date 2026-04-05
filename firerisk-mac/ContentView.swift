//
//  ContentView.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-03.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var location = LocationManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let city = location.city {
                Text("Visar brandrisk för: \(city)").font(.headline)
            } else {
                Text("Hämtar position...").font(.headline)
            }
            
            /*
            if let lat = location.latitude, let lon = location.longitude {
                Text("Latitude: \(lat), Longitude: \(lon)").font(.headline).foregroundStyle(.secondary)
            }
            */
            
            Divider()
            
            Text("Brandrisknivå: 2").font(.headline)
            Text("Iakta allmän försiktighet om du eldar ocg grillar utomhus").font(.subheadline).fixedSize(horizontal: false, vertical: true)
            Divider()
            Text("Eldningsförbud: Inget").font(.headline)
            
        }
        .padding()
        .frame(width: 260)
    }
}

#Preview {
    ContentView()
}
