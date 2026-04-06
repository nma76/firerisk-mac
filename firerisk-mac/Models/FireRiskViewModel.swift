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
    
    //@Published var location = LocationManager()
    @Published var riskForecast: Forecast?
    @Published var fireBan: FireProhibition?
    @Published var city: String?
    @Published var loading = false
    @Published var error: String?
    
    private var timer: AnyCancellable?
    private let location = LocationManager()
    private let service = FireRiskService()
    
    init() {
        location.$city
            .receive(on: DispatchQueue.main)
            .assign(to: &$city)
        
        Task { await loadRisk() }
        
        timer = Timer.publish(every: 300, on: .main, in: .common)
            .autoconnect()
            .sink {
                [weak self] _ in Task { await self?.loadRisk() }
            }
    }
    
    func loadRisk() async {
        guard let lat = location.latitude,
              let lon = location.longitude else { return }
        
        loading = true
        error = nil
        
        do {
            self.riskForecast = try await service.getRisk(lat: lat, lon: lon)
            self.fireBan = try await service.getFireBan(lat: lat, lon: lon)
        } catch {
            self.error = "Kunde inte hämta data"
        }
        
        loading = false
    }
}
