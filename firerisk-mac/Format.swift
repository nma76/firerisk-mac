//
//  Format.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

import Foundation

extension Double {
    var dotFormat: String {
        String(format: "%.2f", self).replacingOccurrences(of: ",", with: ".")
    }
}
