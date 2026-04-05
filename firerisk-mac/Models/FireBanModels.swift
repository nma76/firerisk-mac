//
//  FireBanModels.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

struct FireBanResponse: Codable {
    let county: String?
    let countyCode: String?
    let municipality: String?
    let municipalityCode: String?
    let fireProhibition: FireProhibition
}

struct FireProhibition: Codable {
    let status: String?
    let statusMessage: String?
    let statusCode: Int
    let startDate: String?
    let revisionDate: String?
    let description: String?
    let authority: String?
    let url: String?
}
