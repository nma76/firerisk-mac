//
//  firerisk_macApp.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-03.
//

import SwiftUI

@main
struct firerisk_macApp: App {
    @StateObject var model = FireRiskViewModel()
    
    var body: some Scene {
        MenuBarExtra {
            ContentView(model: model)
        } label: {
            Image(systemName: "flame.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.riskColor(for: model.riskForecast?.riskIndex ?? 0))
        }.menuBarExtraStyle(.window)
    }
}
