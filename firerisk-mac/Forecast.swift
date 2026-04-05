//
//  Forecast.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

struct Forecast: Codable {
    let date: String
    let issuedDate: String
    let forecastTypeId: Int
    let forecastTypeName: String
    let fwiDailyIndex: Int
    let fwiIndex: Int
    let fwiMessage: String
    let combustibleIndex: Int
    let combustibleMessage: String
    let grassIndex: Int
    let grassMessage: String
    let woodIndex: Int
    let woodMessage: String
    let riskIndex: Int
    let riskMessage: String
}
