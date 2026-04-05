//
//  FireRiskViewModel.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

import SwiftUI
internal import Combine

@MainActor

class FireRiskViewModel: ObservableObject {
    
    @Published var location = LocationManager()
    @Published var riskForecast: Forecast?
    @Published var fireBan: FireProhibition?
    @Published var loading = false
    @Published var error: String?
    
    private let service = FireRiskService()
    
    func loadRisk() async {
        guard let lat = location.latitude,
              let lon = location.longitude else { return }
        
        loading = true
        error = nil
        
        do {
            riskForecast = try await service.getRisk(lat: lat, lon: lon)
            fireBan = try await service.getFireBan(lat: lat, lon: lon)
        } catch {
            //error = "Kunde inte hämta data"
        }
        
        loading = false
    }
}
