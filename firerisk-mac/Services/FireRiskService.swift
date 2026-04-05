//
//  FireriskService.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

import Foundation

class FireRiskService {
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.httpAdditionalHeaders = [
            "Accept": "application/json",
            "User-Agent": "firerisk-mac"
        ]
        self.session = URLSession(configuration: config)
    }
    
    func getRisk(lat: Double, lon: Double, lang: String = "sv") async throws -> Forecast {
        let latStr = lat.dotFormat
        let lonStr = lon.dotFormat
        let urlString = "https://api.msb.se/brandrisk/v2/CurrentRisk/\(lang)/\(latStr)/\(lonStr)"
        print("Url:", urlString)
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, respons) = try await session.data(from: url)
        print(respons)
        if let jsonString = String(data: data, encoding: .utf8) {
            print("JSON:\n\n\(jsonString)")
        }
        
        guard let http = respons as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(FireRiskResponse.self, from: data)
        return decoded.forecast
    }
}
