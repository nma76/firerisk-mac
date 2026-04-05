//
//  FireRiskResponse.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

struct FireRiskResponse: Codable {
    let periodStartDate: String
    let periodEndDate: String
    let forecast: Forecast
}
